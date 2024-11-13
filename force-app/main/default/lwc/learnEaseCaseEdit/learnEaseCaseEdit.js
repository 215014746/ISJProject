import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCaseReceivers from '@salesforce/apex/LectureController.getCaseRecievers';

export default class LearnEaseCaseEdit extends NavigationMixin(LightningElement) {
    @api recordId;

    caseReceivers;
    lecturer;

    constructor() {
        super();
        getCaseReceivers().then(result => {
            this.caseReceivers = result;
        });
    }
    handleLecturer  (event) {
        this.lecturer = event.target.value;
    }

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
           this.recordId = currentPageReference.state?.recordId;
       }
    }

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