import { LightningElement, wire } from 'lwc';
import getStudentResponses from '@salesforce/apex/AssessmentResponseController.getStudentResponses';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';


const actions = [
    { label: 'Go to', name: 'edit' }, 
]; 

const columns = [
    { label: 'Student Number', fieldName: 'studentNumber', type: 'text' },
    { label: 'Student Name', fieldName: 'studentName', type: 'text' },
    { label: 'Subject Code', fieldName: 'subjectCode', type: 'text' },
    { label: 'Assessment Name', fieldName: 'assessmentName', type: 'text' },
    { label: 'Marks', fieldName: 'marks', type: 'number' },

    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    }
];


export default class LecturerStudentResponseListView extends NavigationMixin(LightningElement) {
    data;
    error;
    columns = columns;
    assessmentId;
   
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference && currentPageReference.state.assessmentId) {
            this.assessmentId = currentPageReference.state.assessmentId;
            this.loadStudentResponses();
        }
    }

    // Function to load student responses
    loadStudentResponses() {
        getStudentResponses({assessmentId:this.assessmentId})
            .then(result => {
                console.log('Data loaded successfully:', result); 
                this.data = result;
                this.error = undefined;
            })
            .catch(error => {
                console.error('Error loading student responses:', error);  // Log the error
                this.error = error;
                this.data = undefined;
            });
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        console.log(actionName);
        const row = event.detail.row;
        switch (actionName) {
            case 'view':
                this.navigateToView(row);
                break;
            case 'edit':
                this.navigateToEdit(row);
                break;
            default:
        }
    }

    navigateToEdit(row) {
        const { assessmentResponseId } = row;
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: '/student-assessment-response?assessmentResponseId='+assessmentResponseId,
          },
        });
    }
}
