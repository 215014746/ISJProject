import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';

export default class LearnEaseCaseDetail extends NavigationMixin(LightningElement) {
    @api recordId;

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
           this.recordId = currentPageReference.state?.recordId;
       }
    }

    handleBack() {
        window.history.back();
    }

    handleEdit() {
        const caseID = this.recordId
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/cases/view?recordId='+caseID,
            }
        });
    }
}