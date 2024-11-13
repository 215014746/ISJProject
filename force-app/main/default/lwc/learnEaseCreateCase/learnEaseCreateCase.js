import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import createCase from '@salesforce/apex/CaseController.createCase';
import getCaseReceivers from '@salesforce/apex/LectureController.getCaseRecievers';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LearnEaseCreateCase extends LightningModal {

    caseReceivers = []; // List of possible receivers for the case
    caseData = {}; // Data object to hold case information input by the user

    // Fetch case receivers when component is created
    constructor() {
        super();
        getCaseReceivers().then(result => {
            this.caseReceivers = result;
        });
    }

    @api case; // Holds case data passed to this component

    // Options for case reasons dropdown
    get options() {
        return [
            { label: 'Late Submission', value: 'Late Submission' },
            { label: 'Absent due to illness', value: 'Absent due to illness' },
            { label: 'Unmarked Assessment', value: 'Unmarked Assessment' },
            { label: 'Missing Marks', value: 'Missing Marks' },
            { label: 'Other', value: 'other' },
        ];
    }

    // Handlers for input fields to update caseData object
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

    // Save the case and show a toast message based on result
    handleSave() {
        createCase({ caseData: JSON.stringify(this.caseData) })
            .then(result => {
                // Show success toast notification
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'Case created successfully',
                    variant: 'success'
                }));
                
                // Reset form data after saving
                this.caseData = {};

                // Close the modal with result
                this.close(result);
            })
            .catch(error => {
                // Show error toast notification
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error creating case',
                    message: error.body.message,
                    variant: 'error'
                }));

                // Close the modal even in case of an error
                this.close();
            });
    }

    // Close modal without saving when user cancels
    handleCancel() {
        this.close('cancel');
    }
}
