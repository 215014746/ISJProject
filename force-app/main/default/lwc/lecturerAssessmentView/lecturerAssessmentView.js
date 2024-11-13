import { LightningElement, track, wire } from 'lwc';
import getAssessmentAndQuestionsByAssessmentId from '@salesforce/apex/AssessmentController.getAssessmentAndQuestionsByAssessmentId';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';

export default class LecturerAssessmentView extends NavigationMixin(LightningElement)  {

    @track assessment;
    @track error;
    assessmentId;
    @track assessmentResponse;


    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference && currentPageReference.state.assessmentId) {
            this.assessmentId = currentPageReference.state.assessmentId;
            this.loadAssessmentData();
        }
    }

    loadAssessmentData() {
        getAssessmentAndQuestionsByAssessmentId({ assessmentId: this.assessmentId })
            .then(result => {
                this.assessment = result;
                this.error = undefined;
                console.log('my assessment', result);
                
            })
            .catch(error => {
                this.error = error.body.message;
                this.assessment = undefined;
            });
    }

    refreshData() {
        this.loadAssessmentData();
    }

    // Call this method after any changes are made to the assessment
    handleAssessmentChange() {
        // Logic to update the assessment
        // After successful update, refresh the data
        this.refreshData();
    }
    
    handleBack() {
        window.history.back();
    } 
}