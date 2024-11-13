import { LightningElement, wire } from 'lwc';
import getResponeAndQuestionResponseByAssessmentResponseId from '@salesforce/apex/AssessmentResponseController.getResponeAndQuestionResponseByAssessmentResponseId';
import { CurrentPageReference } from 'lightning/navigation';
import saveAssessmentQuestionResponses from '@salesforce/apex/AssessmentQuestionResponseController.saveAssessmentQuestionResponses';

export default class LecturerAssessmentMarking extends LightningElement {

    assessmentResponseId; // ID of the assessment response to be marked
    assessmentResponse; // Data for the assessment response

    responsesMap = {}; // Stores question responses by responseId
    responseData = { responses: [] }; // Data structure to save modified responses

    // Get URL parameters to retrieve assessment response ID
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        console.log(currentPageReference.state.assessmentResponseId);
        if (currentPageReference && currentPageReference.state.assessmentResponseId) {
            this.assessmentResponseId = currentPageReference.state.assessmentResponseId;
            this.loadAssessmentData();
        }
    }

    // Load assessment and question response data by assessment ID
    loadAssessmentData() {
        getResponeAndQuestionResponseByAssessmentResponseId({ assessmentResponseId: this.assessmentResponseId })
            .then(result => {
                this.assessmentResponse = result;
                console.log('my assessment', result);
                if (result.responses) {
                    result.responses.forEach(element => {
                        this.responsesMap[element.responseId] = element;
                    });
                }})
            .catch(error => {
                console.error(error.stack);
                console.log('my assessment error');
            });
    }

    // Update marks for each question response in responsesMap
    updateResponse(e) {
        this.responsesMap[e.target.dataset.resp].marks = e.target.value;
        console.log(JSON.stringify(this.responsesMap, null, 2));
    }

    // Save modified responses to server
    saveResponses() {
        Object.keys(this.responsesMap).forEach(e => {
            this.responseData.responses.push(this.responsesMap[e]);
        });
        console.log(JSON.stringify(this.responseData, null, 2));

        saveAssessmentQuestionResponses({ data: JSON.stringify(this.responseData) })
            .then(() => {
                location.reload(); // Reload the page after saving
            })
            .catch(error => {
                console.error(error);
            });
            
    }

    // Navigate back to the previous page
    handleBack() {
        window.history.back();
    }

}