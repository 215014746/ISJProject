import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LearnEaseCaseEditForm extends LightningElement {
    @api recordId;
    @api objectApiName = 'Case';

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.recordId = currentPageReference.state.c__recordId; // Retrieve recordId from state
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Success',
            message: `Case record has been saved successfully!`,
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }

    handleError(event) {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: event.detail.message,
            variant: 'error',
        });
        this.dispatchEvent(evt);
    }
}