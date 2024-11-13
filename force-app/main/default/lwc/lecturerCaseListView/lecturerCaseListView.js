import { LightningElement, api, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getCasesByCaseReceiverId from '@salesforce/apex/CaseController.getCasesByCaseReceiverId';

const actions = [
    { label: 'Edit', name: 'edit' }, 
]; 

export default class lecturerEaseListCaseView  extends NavigationMixin(LightningElement) { 
    @api caseReceiverId;
    caseId;
    @track cases;
    @track error;
    
    @track columns = [
        { label: 'Case Number', fieldName: 'caseNumber', type: 'url', 
            typeAttributes: { label: { fieldName: 'caseNumber' }, target: '_self' } },
        { label: 'Subject', fieldName: 'subject' },
        { label: 'Description', fieldName: 'description' },
        { label: 'Case Reason', fieldName: 'caseReason' },
        { label: 'Status', fieldName: 'status' },
        { label: 'Case Owner Name', fieldName: 'caseOwnerName' },
        { label: 'Case Receiver Name', fieldName: 'caseReceiverName' },
        { label: 'Created Date', fieldName: 'createdDate', type: 'date', 
            typeAttributes: { year: "numeric", month: "short", day: "2-digit" } },
        { label: 'Comment', fieldName: 'comment' },
        {
            type: 'action',
            typeAttributes: { rowActions: actions },
        }
    ];
    
    connectedCallback() {
        console.log('LecturerCaseListView connected. caseReceiverId:', this.caseReceiverId);
    }

    @wire(getCasesByCaseReceiverId)
    wiredCases({ error, data }) {
        console.log('Wire service called with caseReceiverId:', this.caseReceiverId);
        if (data) {
            console.log('Data received:', JSON.stringify(data));
            this.cases = data.map(caseRecord => ({
                ...caseRecord,
                OwnerName: caseRecord.Owner ? caseRecord.Owner.Name : '',
                CaseReceiverName: caseRecord.Case_Receiver__r ? caseRecord.Case_Receiver__r.Name : ''
            }));
            this.error = undefined;
            console.log('Processed cases:', JSON.stringify(this.cases));
        } else if (error) {
            console.error('Error:', JSON.stringify(error));
            this.error = error;
            this.cases = undefined;
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        console.log(actionName);
        const row = event.detail.row;
        switch (actionName) {
            case 'view':
                this.navigateToView(row);
                break;
            case 'edit':
                this.navigateToEdit(row);
                break;
            default:
        }
    }

    navigateToEdit(row) {
        const { caseID } = row;
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: '/cases/edit?recordId='+caseID,
          },
        });
    }

    renderedCallback() {
        console.log('Component rendered. Cases:', this.cases ? this.cases.length : 0);
    }
}
