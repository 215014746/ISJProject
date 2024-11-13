import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LecturerCaseEdit extends LightningElement {
    @api recordId;

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

    handleCancel() {
        this.navigateToDetail(this.recordId);
    }

    handleBack() {
        window.history.back();
    }

    navigateToDetail(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__component',
            attributes: {
                componentName: 'c__LearnEaseCaseDetail'
            },
            state: {
                recordId: recordId
            }
        });
    }
}