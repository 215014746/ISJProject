import { LightningElement, track, wire } from 'lwc';
import getAllStudentsAssessments from '@salesforce/apex/AssessmentController.getAllStudentsAssessments';

export default class AssessmentDashboard extends LightningElement {
    // Tracks the list of assessments and status counts
    @track assessments = [];
    @track inProgressCount = 0;
    @track completeCount = 0;
    @track notStartedCount = 0;

    // Define columns for the datatable
    @track columns = [
        { label: 'Subject Code', fieldName: 'subjectCode', type: 'text' },
        { label: 'Assessment Name', fieldName: 'title', type: 'text' },
        { label: 'Due Date', fieldName: 'dueDate', type: 'date' },
        { label: 'Status', fieldName: 'assessmentStatus', type: 'text' }
    ];
    // Wire to retrieve assessment data and populate the counts
    @wire(getAllStudentsAssessments)
    wiredAssessments({ error, data }) {
        
        if (data) {
            console.log('assessments', data);
            this.assessments = data;
            this.calculateCounts();// Calculate status counts
            console.log('assessments', data);
        } else if (error) {
            // Handle error
            console.error('Error fetching assessments: ', error);// Log error if data retrieval fails
        }
    }
    // Count assessments by status
    calculateCounts() {
        this.inProgressCount = this.assessments.filter(
            assessment => assessment.assessmentStatus === 'In Progress'
        ).length;
        
        this.completeCount = this.assessments.filter(
            assessment => assessment.assessmentStatus === 'Completed'
        ).length;
        
        this.notStartedCount = this.assessments.filter(
            assessment => assessment.assessmentStatus === 'Not Started'
        ).length;
    }
}