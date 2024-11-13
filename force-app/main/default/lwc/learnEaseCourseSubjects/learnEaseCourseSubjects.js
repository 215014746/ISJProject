import { LightningElement, wire } from 'lwc';
import getCourseAndSubject from '@salesforce/apex/CourseController.getStudentCourse';
import { NavigationMixin } from "lightning/navigation";

export default class LearnEaseCourseSubjects extends NavigationMixin(LightningElement) {
   
    courseData;
    baseUrl = '/course/viewcourse?';
    subjectUrl = '/course/viewcourse/viewsubject?';

    connectedCallback() {
        getCourseAndSubject().then((result) => {
            console.log(result);
            this.courseData = result;
        }).catch(
            (error) => {
                console.log(error);
            }
        );
    }

    navigateToViewCourse(e) {
        
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.baseUrl + 'courseId=' + e.target.dataset.course,
          },
        });
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