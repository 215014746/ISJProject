import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import getCourseById from '@salesforce/apex/CourseController.getCourseById';

export default class ViewCourseDetails extends LightningElement {
    courseId;
    courseData;
    error;

    // Wire the current page reference to get the state parameters (courseId)
    @wire(CurrentPageReference)
    currentPageReference;

    connectedCallback() {
        // Ensure currentPageReference is available and retrieve courseId from URL state
        if (this.currentPageReference?.state?.courseId) {
            this.courseId = this.currentPageReference.state.courseId;
            console.log('Course ID from URL: ' + this.courseId);

            // Fetch course details using the courseId
            this.fetchCourseDetails();
        } else {
            console.error('Course ID not found in URL');
        }
    }

    fetchCourseDetails() {
        // Call the Apex method to get the course details by courseId
        getCourseById({ courseId: this.courseId })
            .then(result => {
                this.courseData = result;
                console.log('Fetched course details:', this.courseData);
            })
            .catch(error => {
                this.error = error;
                console.error('Error fetching course details:', this.error);
            });
    }

    handleBack() {
        window.history.back();
    }
}
