import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';

export default class LearnEaseCaseDetail extends NavigationMixin(LightningElement) {
    // Holds the record ID from the URL
    @api recordId;
    // Retrieve record ID from URL parameters
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
           this.recordId = currentPageReference.state?.recordId;
       }
    }

    handleBack() {
        window.history.back();
    }
    // Navigate to edit page with the current case ID
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