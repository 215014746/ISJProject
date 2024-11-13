import { LightningElement, wire } from 'lwc';
import getCourseAndSubject from '@salesforce/apex/CourseController.getStudentCourse';
import { NavigationMixin } from "lightning/navigation";

export default class LearnEaseCourseSubjects extends NavigationMixin(LightningElement) {
   
    courseData;// Holds data for courses and subjects
    baseUrl = '/course/viewcourse?';// URL for course view navigation
    subjectUrl = '/course/viewcourse/viewsubject?';// URL for subject view navigation
  // Fetch course and subject data when component loads
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
// Navigate to course view page with course ID
    navigateToViewCourse(e) {
        
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.baseUrl + 'courseId=' + e.target.dataset.course,
          },
        });
    }
// Navigate to subject view page with subject ID
    navigateToViewSubject(e) {
        
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.subjectUrl + 'subjectId=' + e.target.dataset.subject,
          },
        });
    }



}