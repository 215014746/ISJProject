import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import createCase from '@salesforce/apex/CaseController.createCase';
import getCaseReceivers from '@salesforce/apex/LectureController.getCaseRecievers'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LearnEaseCreateCase extends LightningModal {

    caseReceivers = [];
    caseData = {}; 

    constructor() {
        super();
        getCaseReceivers().then(result => {
            this.caseReceivers = result;
        });
    }

    @api case;

    // Options for case reasons
    get options() {
        return [
            { label: 'Late Submission', value: 'Late Submission' },
            { label: 'Absent due to illness', value: 'Absent due to illness' },
            { label: 'Unmarked Assessment', value: 'Unmarked Assessment' },
            { label: 'Missing Marks', value: 'Missing Marks' },
            { label: 'Other', value: 'other' },
        ];
    }

    // Handlers for input fields
    handleSubject(e) {
        this.caseData.subject = e.target.value;
    }

    handleStatus(e) {
        this.caseData.status = e.target.value;
    }

    handleReason(e) {
        this.caseData.caseReason = e.detail.value;
    }

    handleDescription(e) {
        this.caseData.description = e.target.value;
    }

    handleStudent(e) {
        this.caseData.caseOwner = e.target.value;
    }

    handleLecturer(e) {
        this.caseData.caseReceiver = e.detail.value;
    }

    // Save Case and handle result
    handleSave() {
        createCase({ caseData: JSON.stringify(this.caseData) })
            .then(result => {
                // Show success toast
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'Case created successfully',
                    variant: 'success'
                }));

                // Reset form data to avoid duplication
                this.caseData = {};

                // Close the modal
                this.close(result);
            })
            .catch(error => {
                // Show error toast
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error creating case',
                    message: error.body.message,
                    variant: 'error'
                }));

                // Still close the modal if needed
                this.close();
            });
    }

    // Close form on cancel
    handleCancel() {
        this.close('cancel');
    }
}
