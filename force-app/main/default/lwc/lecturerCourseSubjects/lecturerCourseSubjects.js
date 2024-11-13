import { LightningElement, wire } from 'lwc';
import getLecturerByContactId from '@salesforce/apex/LecturerSubjectController.getLecturerByContactId';
import { NavigationMixin } from "lightning/navigation";

export default class LecturerCourseSubjects extends NavigationMixin(LightningElement) {

    lecturerSubjectData;
    baseUrl = '/lecturer-subjects';
    subjectUrl = '/lecturer-subjects/subjectview?';

    connectedCallback() {
      getLecturerByContactId().then((result) => {
            console.log(result);
            this.lecturerSubjectData = result;
        }).catch(
            (error) => {
                console.log(error);
            }
        );
    }

    navigateToViewSubject(e) {
        
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.subjectUrl + 'subjectId=' + e.target.dataset.subject,
          },
        });
    }
}