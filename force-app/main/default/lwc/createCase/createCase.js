import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createCase from '@salesforce/apex/CaseController.createCase';
import getSubjectsByCourseId from '@salesforce/apex/SubjectController.getSubjectsByCourseId';

export default class CreateCase extends LightningElement {
    @track caseObject = {
        Subject: '',
        Description: '',
        SubjectId: ''
    };
    @track subjects = [];

    @wire(getSubjectsByCourseId)
    wiredSubjects({ error, data }) {
        if (data) {
            this.subjects = data.map(subject => ({
                label: subject.Name,
                value: subject.Id
            }));
        } else if (error) {
            this.showToast('Error', 'Error loading subjects', 'error');
        }
    }

    handleInputChange(event) {
        this.caseObject[event.target.name] = event.target.value;
    }

    handleSubjectChange(event) {
        this.caseObject.SubjectId = event.detail.value;
    }

    handleSubmit() {
        const caseData = JSON.stringify(this.caseObject);
        createCase({ caseData: caseData })
            .then(result => {
                this.showToast('Success', 'Case created successfully', 'success');
                this.resetForm();
            })
            .catch(error => {
                this.showToast('Error', 'Error creating case: ' + error.body.message, 'error');
            });
    }

    resetForm() {
        this.caseObject = {
            Subject: '',
            Description: '',
            SubjectId: ''
        };
        this.template.querySelectorAll('lightning-input, lightning-textarea, lightning-combobox').forEach(element => {
            element.value = '';
        });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}