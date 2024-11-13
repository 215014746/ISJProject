import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import createAssessment from '@salesforce/apex/AssessmentController.createAssessment';


export default class LecturerCreateAssessment extends LightningModal {

    @api assessment;
    assessmentData = {};
   

    handleInputDescription(e){
        this.assessmentData['description'] = e.target.value;
    }

    handleInputTitle(e){
        this.assessmentData['title'] = e.target.value;
    }

    handleInputDueDate(e){
        this.assessmentData['dueDate'] = e.target.value;
    }

   

    handleCancel() {
        this.close('cancel');
    }

    handleSave() {

        console.log(JSON.stringify(this.assessmentData,null,2));
        this.assessmentData['assessmentStatus'] = "Not Started";
        this.assessmentData['subjectCode'] = this.assessment.subjectCode;
        this.assessmentData['subject'] = this.assessment.subject;
        createAssessment({ assessmentData: JSON.stringify(this.assessmentData) })
            .then(result => {
                console.log('Assessment created with ID:', result);
                this.close(result);
            })
            .catch(error => {
                console.error('Error creating assessment:', error);
            });
    }

}