// learnEaseCase.js
import { LightningElement, track, wire } from 'lwc';
import getCasesByOwnerId from '@salesforce/apex/CaseController.getCasesByOwnerId';
import USER_ID from '@salesforce/user/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation";

const columns = [
    { label: 'Case Number', fieldName: 'caseNumber', type: 'url', 
        typeAttributes: { label: { fieldName: 'caseNumber' }, target: '_self' } },    
    { label: 'Case ID', fieldName: 'caseID' },
    { label: 'Subject', fieldName: 'subject' },
    { label: 'Description', fieldName: 'description' },
    { label: 'Case Reason', fieldName: 'caseReason' },
    { label: 'Status', fieldName: 'status' },
    { label: 'Case Owner', fieldName: 'caseOwner' },
    { label: 'Case Receiver', fieldName: 'caseReceiver' },
    { label: 'Case Owner Name', fieldName: 'caseOwnerName' },
    { label: 'Case Receiver Name', fieldName: 'caseReceiverName' },
    { label: 'Comment', fieldName: 'comment' },
];

export default class LearnEaseCase extends NavigationMixin(LightningElement) {
    @track data = [];
    columns = columns;
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
    // Shows a success message after performing an operation
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(event);
    }
  

        handleRowAction(event) {
            const caseId = event.detail.row.caseID;
            // Navigate to the case edit form
            this[NavigationMixin.Navigate]({
                type: "standard__webPage",
          attributes: {
            URL: '/cases/editForm',
          },
                state: {
                    c__recordId: caseId 
                }
            });
        }

}