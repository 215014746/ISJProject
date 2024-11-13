import { LightningElement, track, wire } from 'lwc';
import getAssessmentAndQuestionsByAssessmentId from '@salesforce/apex/AssessmentController.getAssessmentAndQuestionsByAssessmentId';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import getAssessmentResponseByAssessmentId from '@salesforce/apex/AssessmentResponseController.getAssessmentResponseByAssessmentId';
import createAssessmentResponseModal from 'c/learnEaseCreateAssessmentResponse';

export default class LearnEaseAssessmentView extends NavigationMixin(LightningElement) {
    @track assessment;
    @track error;
    assessmentId;
    @track assessmentResponse;

    // Retrieve assessment ID from URL parameters
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference && currentPageReference.state.assessmentId) {
            this.assessmentId = currentPageReference.state.assessmentId;
            this.loadAssessmentData();
        }
    }

    // Fetch assessment and questions data
    loadAssessmentData() {
        getAssessmentAndQuestionsByAssessmentId({ assessmentId: this.assessmentId })
            .then(result => {
                this.assessment = result;
                this.error = undefined;
                console.log('my assessment', result);
                if(this.assessmentId ){
                    this.loadAssessmentResponse();
                }
            })
            .catch(error => {
                this.error = error.body.message;
                this.assessment = undefined;
            });
    }
    // Fetch assessment response data by assessment ID
    loadAssessmentResponse() {
        getAssessmentResponseByAssessmentId({ assessmentId: this.assessmentId })
            .then(result => {
                this.assessmentResponse = result;
                console.log('my assessment response', result);
            })
            .catch(error => {
                console.error(error);
            
            });
    }
    // Navigate to view subject page with the assessment ID
    navigateToViewSubject(assessmentId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/lightning/c/viewAssessments?assessmentId=' + assessmentId // Pass the assessment ID
            }
        });
    }
    handleBack() {
        window.history.back();
    }
    // Handle creation of a new assessment response in a modal - pop up form when create button is clicked
    async handleCreateAssessmentResponse() {
        const result = await createAssessmentResponseModal.open({
            size: 'large',
            assessment: {
                assessmentId: this.assessmentId,
                assessmentName: this.assessment.title,
                subjectCode: this.assessment.subjectCode,
            }
        });
        
        console.log(result);
    
        // Reload the assessment data if a new response was created
        if (result) {
            this.loadAssessmentData(); // Refresh data to reflect new addition
        }
    }
    
    // Navigate to view the assessment response page
    handleViewAssessmentResponse(){

        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/assessmentresponse?assessmentResponseId=' + this.assessmentResponse.assessmentResponseId 
            }
        });
    }

}