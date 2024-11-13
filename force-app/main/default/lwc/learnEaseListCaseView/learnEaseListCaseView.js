import { LightningElement, track, wire } from 'lwc';
import getCasesByOwnerId from '@salesforce/apex/CaseController.getCasesByOwnerId';
import USER_ID from '@salesforce/user/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation";
import createCaseModal from 'c/learnEaseCreateCase';

const actions = [
    { label: 'View', name: 'view' },
    { label: 'Edit', name: 'edit' },
];

const columns = [
    { label: 'Case Number', fieldName: 'caseNumber', type: 'url', 
        typeAttributes: { label: { fieldName: 'caseNumber' }, target: '_self' } },
    { label: 'Subject', fieldName: 'subject' },
    { label: 'Description', fieldName: 'description' },
    { label: 'Case Reason', fieldName: 'caseReason' },
    { label: 'Status', fieldName: 'status' },
    { label: 'Case Owner Name', fieldName: 'caseOwnerName' },
    { label: 'Case Receiver Name', fieldName: 'caseReceiverName' },
    { label: 'Created Date', fieldName: 'createdDate',type:'date', typeAttributes: { year: "numeric", month: "short", day: "2-digit" }},
    { label: 'Comment', fieldName: 'comment' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    }
];

export default class LearnEaseListCaseView extends NavigationMixin(LightningElement) {

    @track data = [];
    columns = columns;
    @track case;
    caseID;
    @track error;

    // Fetch data from Apex when the component is connected
    connectedCallback() {
        this.loadCases();
    }

    loadCases() {
        getCasesByOwnerId({ ownerId: USER_ID}) // Example owner ID, replace with a dynamic value if needed
            .then((result) => {
                this.data = result;
            })
            .catch((error) => {
                this.error = error;
                this.showToast('Error', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(event);
    }
    handleRowAction(event) {
        const actionName = event.detail.action.name;
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
 
    navigateToView(row) {
        console.log(row);
        const { caseID } = row;
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: '/cases/view?recordId='+caseID,
          },
        });
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

async handleCreateCase() {
    try {
        const result = await createCaseModal.open({
            size: 'large',
        });

        if (result) {
            this.loadCases();
        }

        console.log('Case creation result:', result);
    } catch (error) {
        console.error('Error occurred while creating case:', error);
    }
}


}