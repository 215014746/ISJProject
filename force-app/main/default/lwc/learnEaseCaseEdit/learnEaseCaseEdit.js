import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCaseReceivers from '@salesforce/apex/LectureController.getCaseRecievers';

export default class LearnEaseCaseEdit extends NavigationMixin(LightningElement) {
    @api recordId;

    caseReceivers;
    lecturer;
    // Fetch case receivers when the component is constructed
    constructor() {
        super();
        getCaseReceivers().then(result => {
            this.caseReceivers = result;
        });
    }

    // Update lecturer value based on user selection
    handleLecturer  (event) {
        this.lecturer = event.target.value;
    }
    // Retrieve record ID from URL parameters
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
           this.recordId = currentPageReference.state?.recordId;
       }
    }
    // Show a success toast and navigate to the case detail view upon successful save
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Case updated",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
        this.navigateToDetail(event.detail.id);
    }

    handleCancel() {this.navigateToDetail(this.recordId);
        
    }

    handleBack() {
        window.history.back();
    }

     // Navigate to view a specific case by ID
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
    // Navigate to the case detail page with specified record ID
    navigateToDetail(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                componentName: 'c__LearnEaseListCaseView'
            },
            state: {
                recordId: recordId
            }
        });
    }
}