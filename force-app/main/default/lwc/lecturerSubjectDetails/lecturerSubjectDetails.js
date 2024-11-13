import { LightningElement, wire } from 'lwc';
import getSubjectBySubjectId from '@salesforce/apex/SubjectController.getSubjectBySubjectId';
import { NavigationMixin } from "lightning/navigation";
import { CurrentPageReference } from 'lightning/navigation';
import getAllBySubject from '@salesforce/apex/AssessmentController.getAllBySubject';
import createAssessmentModal from 'c/lecturerCreateAssessment';

export default class LecturerSubjectDetails extends NavigationMixin(LightningElement) {

    subjectData;
    subjectId;
    assessment;
    assessments = [];
    baseUrl = '/lecturer-subjects/assessmentview?';
    editUrl = '/lecturer-subjects/assessmentedit?';

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
           this.subjectId = currentPageReference.state?.subjectId;
          if(this.subjectId) {
            this.getSubjectDetails();
          }
       }
    }

    getSubjectDetails() {
        getSubjectBySubjectId({subjectId: this.subjectId}).then((result) => {
            console.log(result);
            this.subjectData = result;
            this.getAssessmentSubjects();
        }).catch(
            (error) => {
                console.log(error);
            }
        );
    }

    getAssessmentSubjects() {
        getAllBySubject({subject: this.subjectId}).then((result) => {
            console.log(result);
           this.assessments = result;
           console.log(this.assessments);
        }).catch(
            (error) => {
                console.log(error);
            }
        );
    }

    navigateToViewAssessment(e) {
        
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.baseUrl + 'assessmentId=' + e.target.dataset.assessment,
          },
        });
    }
    navigateToEditAssessment(e) {
        
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.editUrl + 'assessmentId=' + e.target.dataset.assessment,
          },
        });
    }

    async handleCreateAssessment() {
        try {
            const result = await createAssessmentModal.open({
                size: 'large', 
                assessment: {
                    subjectCode: this.subjectData.subjectCode,
                    subject: this.subjectData.subjectId,
                    name: this.subjectData.name,
                }   
            });
            
            if (result) {
                // Reload the assessments list after creating a new assessment
                this.getAssessmentSubjects();
            }
            
            console.log(result);
        } catch (error) {
            console.error(error.stack);  
        }
    }
    

}