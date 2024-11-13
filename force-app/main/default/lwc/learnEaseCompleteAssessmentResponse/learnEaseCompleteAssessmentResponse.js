import { LightningElement,wire } from 'lwc';
import getResponeAndQuestionResponseByAssessmentResponseId from '@salesforce/apex/AssessmentResponseController.getResponeAndQuestionResponseByAssessmentResponseId';
import { CurrentPageReference } from 'lightning/navigation';
import saveAssessmentQuestionResponses from '@salesforce/apex/AssessmentQuestionResponseController.saveAssessmentQuestionResponses';

export default class LearnEaseCompleteAssessmentResponse extends LightningElement {

    assessmentResponseId;
    assessmentResponse;

    responsesMap = {};
    responseData = {
    responses : []
};

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        console.log(currentPageReference.state.assessmentResponseId);
        if (currentPageReference && currentPageReference.state.assessmentResponseId) {
            this.assessmentResponseId = currentPageReference.state.assessmentResponseId;
            this.loadAssessmentData();
        }
    }

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

    updateResponse(e){
        console.log(e.target.value);
        console.log(e.target.dataset.resp);
        this.responsesMap[e.target.dataset.resp].questionResponse = e.target.value;
        console.log(JSON.stringify(this.responsesMap, null, 2));
    }


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