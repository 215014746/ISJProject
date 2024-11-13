import { LightningElement,wire } from 'lwc';
import getResponeAndQuestionResponseByAssessmentResponseId from '@salesforce/apex/AssessmentResponseController.getResponeAndQuestionResponseByAssessmentResponseId';
import { CurrentPageReference } from 'lightning/navigation';
import saveAssessmentQuestionResponses from '@salesforce/apex/AssessmentQuestionResponseController.saveAssessmentQuestionResponses';

export default class LearnEaseCompleteAssessmentResponse extends LightningElement {

    assessmentResponseId;// Holds assessment response ID from URL
    assessmentResponse;// Stores assessment response data
    responsesMap = {};// Maps response IDs to their corresponding data
    responseData = {
    responses : []
};// Object to store responses for saving

    // Retrieve assessmentResponseId from URL parameters
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        console.log(currentPageReference.state.assessmentResponseId);
        if (currentPageReference && currentPageReference.state.assessmentResponseId) {
            this.assessmentResponseId = currentPageReference.state.assessmentResponseId;
            this.loadAssessmentData();
        }
    }
    // Fetch assessment data and populate responsesMap
    loadAssessmentData() {
        getResponeAndQuestionResponseByAssessmentResponseId({ assessmentResponseId: this.assessmentResponseId })
            .then(result => {
                this.assessmentResponse = result;
                console.log('my assessment', result);
                if(result.responses){
                    result.responses.forEach(element => {
                        this.responsesMap[element.responseId] = element;
                    });
                }
                
            })
            .catch(error => {
          console.error(error.stack);
          console.log('my assessment error');
            });
    }
    // Update question response based on user input
    updateResponse(e){
        console.log(e.target.value);
        console.log(e.target.dataset.resp);
        this.responsesMap[e.target.dataset.resp].questionResponse = e.target.value;
        console.log(JSON.stringify(this.responsesMap, null, 2));
    }

    // Save all question responses to the server
    saveResponses(){
        Object.keys(this.responsesMap).forEach(e => {
           this.responseData.responses.push(this.responsesMap[e]);
        });
        console.log(JSON.stringify(this.responseData, null, 2));

        saveAssessmentQuestionResponses({data : JSON.stringify(this.responseData)}).
        then(() => {
            location.reload();
        }).
        catch(error => {
            console.error(error);
        });
     
    }

    handleBack() {
        window.history.back();
    }
}