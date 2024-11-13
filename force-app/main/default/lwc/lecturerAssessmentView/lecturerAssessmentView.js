import { LightningElement, track, wire } from 'lwc';
import getAssessmentAndQuestionsByAssessmentId from '@salesforce/apex/AssessmentController.getAssessmentAndQuestionsByAssessmentId';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';

export default class LecturerAssessmentView extends NavigationMixin(LightningElement) {

    @track assessment; // Holds assessment and question data
    @track error; // Holds error message if data fetch fails
    assessmentId; // Stores assessment ID from the page state
    @track assessmentResponse; // Placeholder for potential response data

    // Retrieve page parameters to get the assessment ID
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference && currentPageReference.state.assessmentId) {
            this.assessmentId = currentPageReference.state.assessmentId;
            this.loadAssessmentData(); // Load assessment data with the ID
        }
    }

    // Load assessment and question details from the server
    loadAssessmentData() {
        getAssessmentAndQuestionsByAssessmentId({ assessmentId: this.assessmentId })
            .then(result => {
                this.assessment = result;
                this.error = undefined;
                console.log('my assessment', result);})
            .catch(error => {
                this.error = error.body.message;
                this.assessment = undefined;
            });
    }

    // Refresh assessment data after any change
    refreshData() {
        this.loadAssessmentData();
    }

    // Handles updates to the assessment and refreshes the view
    handleAssessmentChange() {
        this.refreshData();}
    
    // Go back to the previous page
    handleBack() {
        window.history.back();
    }
}
