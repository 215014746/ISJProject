import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import { NavigationMixin } from 'lightning/navigation';
import getAssessmentResponseByAssessmentId from '@salesforce/apex/AssessmentResponseController.getAssessmentResponseByAssessmentId';
import createAssessmentResponse from '@salesforce/apex/AssessmentResponseController.createAssessmentResponse';
import getLoggedInUserStudentNumberAndName from '@salesforce/apex/CommunityUserDataService.getLoggedInUserStudentNumberAndName';

export default class LearnEaseCreateAssessmentResponse extends LightningModal {

    @api assessment; // Assessment details passed from parent
    studentNumber; // Holds student number
    studentName; // Holds student name
    assessmentResponse; // Existing assessment response data
    assessmentResponseId; // ID of the newly created assessment response
    assessmentResponseData = {}; // Stores data for creating/updating assessment response
  
    constructor() {
        super();
        this.fetchStudentData(); // Fetch student data on load
        this.loadAssessmentResponse(); // Load existing assessment response if any
    }

    // Loads assessment response based on the assessment ID
    loadAssessmentResponse() {
        getAssessmentResponseByAssessmentId({ assessmentId: this.assessmentId })
            .then(result => {
                this.assessmentResponse = result; })
            .catch(error => {
                console.error(error); // Log any error in loading response
            });
    }  

    // Fetches student number and name of logged-in user
    fetchStudentData() {
        getLoggedInUserStudentNumberAndName()
            .then(result => {
                this.studentNumber = result.studentNumber;
                this.studentName = result.name;
                this.assessmentResponseData.studentNumber = result.studentNumber;
                this.assessmentResponseData.studentName = result.name;
            })
            .catch(error => {
                console.error(error); // Log any error in fetching student data
            });
    }
     
    // Closes the modal
    handleCancel() {
        this.close('okay');
    } 
    
    // Handles saving the assessment response
    handleSave() {
        // Prepare data for new assessment response
        this.assessmentResponseData.assessmentId = this.assessment.assessmentId;
        this.assessmentResponseData.subjectCode = this.assessment.subjectCode;
        this.assessmentResponseData.assessmentName = this.assessment.assessmentName;

        createAssessmentResponse({ assessmentResponseData: JSON.stringify(this.assessmentResponseData) })
            .then(result => {
                this.assessmentResponseId = result;
                this.close(result); // Close modal with response ID
            })
            .catch(error => {
                console.error(error); // Log any error in creating response
            });
    }
}
