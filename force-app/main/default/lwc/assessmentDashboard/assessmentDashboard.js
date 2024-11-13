import { LightningElement, track, wire } from 'lwc';
import getAllStudentsAssessments from '@salesforce/apex/AssessmentController.getAllStudentsAssessments';

export default class AssessmentDashboard extends LightningElement {
    @track assessments = [];
    @track inProgressCount = 0;
    @track completeCount = 0;
    @track notStartedCount = 0;

    @track columns = [
        { label: 'Subject Code', fieldName: 'subjectCode', type: 'text' },
        { label: 'Assessment Name', fieldName: 'title', type: 'text' },
        { label: 'Due Date', fieldName: 'dueDate', type: 'date' },
        { label: 'Status', fieldName: 'assessmentStatus', type: 'text' }
    ];

    @wire(getAllStudentsAssessments)
    wiredAssessments({ error, data }) {
        
        if (data) {
            console.log('assessments', data);
            this.assessments = data;
            this.calculateCounts();
            console.log('assessments', data);
        } else if (error) {
            // Handle error
            console.error('Error fetching assessments: ', error);
        }
    }

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