import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import { NavigationMixin } from 'lightning/navigation';
import getAssessmentResponseByAssessmentId from '@salesforce/apex/AssessmentResponseController.getAssessmentResponseByAssessmentId';
import createAssessmentResponse from '@salesforce/apex/AssessmentResponseController.createAssessmentResponse';
import getLoggedInUserStudentNumberAndName from '@salesforce/apex/CommunityUserDataService.getLoggedInUserStudentNumberAndName';

export default class LearnEaseCreateAssessmentResponse extends LightningModal {

    @api assessment;
    studentNumber;
    studentName;
    assessmentResponse;
    assessmentResponseId;
    assessmentResponseData = {};
  
   constructor(){
    super();
    this.fetchStudentData();
    this.loadAssessmentResponse();
   }

    loadAssessmentResponse() {
        getAssessmentResponseByAssessmentId({ assessmentId: this.assessmentId })
            .then(result => {
                this.assessmentResponse = result;
                console.log('my assessment response', result);
                this.fetchStudentNumber();
            })
            .catch(error => {
             
            });
    }  
    fetchStudentData() {
        getLoggedInUserStudentNumberAndName()
            .then(result => {
                this.studentNumber = result['studentNumber'] ;
                this.studentName = result['name'] ;
                console.log(result);
                this.assessmentResponseData['studentNumber'] = result['studentNumber'];
                this.assessmentResponseData['studentName'] = result['name'] ;
            })
            .catch(error => {
                
            });
        }
     

    handleCancel() {
        this.close('okay');
    } 
    
    handleSave() {
        //this.close('okay');
        this.assessmentResponseData.assessmentId = this.assessment.assessmentId;
        this.assessmentResponseData.subjectCode = this.assessment.subjectCode;
        this.assessmentResponseData.assessmentName = this.assessment.assessmentName;

        console.log(JSON.stringify(this.assessmentResponseData, null, 2));

        createAssessmentResponse({ assessmentResponseData: JSON.stringify(this.assessmentResponseData)})
        .then(result => {
            this.assessmentResponseId = result;
            this.close(result);
        })
        .catch(error => {
         console.error(error);
        });
    }
}