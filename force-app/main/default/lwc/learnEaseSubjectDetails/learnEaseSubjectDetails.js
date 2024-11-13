import { LightningElement, wire } from 'lwc';
import getSubjectBySubjectId from '@salesforce/apex/SubjectController.getSubjectBySubjectId';
import { NavigationMixin } from "lightning/navigation";
import { CurrentPageReference } from 'lightning/navigation';
import getAllBySubject from '@salesforce/apex/AssessmentController.getAllBySubject';

export default class LearnEaseSubjectDetails extends NavigationMixin(LightningElement) {

    subjectData;
    subjectId;
    assessments = [];
    baseUrl = '/assessmentview?';

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


}