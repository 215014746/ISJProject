import { LightningElement, track, wire } from 'lwc';
import getAssessmentAndQuestionsByAssessmentId from '@salesforce/apex/AssessmentController.getAssessmentAndQuestionsByAssessmentId';
import updateAsssessmentQuestion from '@salesforce/apex/AssessmentQuestionController.updateAsssessmentQuestion';
import createAssessmentQuestion from '@salesforce/apex/AssessmentQuestionController.createAssessmentQuestion';
import deleteAssessmentQuestion from '@salesforce/apex/AssessmentQuestionController.deleteAssessmentQuestion';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

export default class LecturerAssessmentEdit extends NavigationMixin(LightningElement) {

    @track assessment; // Full assessment object (including questions)
    @track error;
    assessmentId; // Assessment ID received from the URL
    @track editedQuestions = []; // Stores questions for editing
    @track newQuestionText = ''; // For adding a new question

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference && currentPageReference.state.assessmentId) {
            this.assessmentId = currentPageReference.state.assessmentId;
            this.loadAssessmentData();
        }
    }

    // Load assessment data along with questions
    loadAssessmentData() {
        getAssessmentAndQuestionsByAssessmentId({ assessmentId: this.assessmentId })
            .then(result => {
                this.assessment = result;
                this.error = undefined;
                // Initialize editedQuestions with assessment questions
                this.editedQuestions = result.questions.map(question => ({
                    ...question
                }));
            })
            .catch(error => {
                this.error = error.body.message;
                this.assessment = undefined;
            });
    }

    // Handle changes in the input fields for question number and text
    handleInputChange(event) {
        const field = event.target.dataset.field;
        const questionId = event.target.dataset.id;
        const questionIndex = this.editedQuestions.findIndex(q => q.assessmentQuestionId === questionId);
        if (questionIndex !== -1) {
            this.editedQuestions[questionIndex][field] = event.target.value;
        }
    }

    handleNewQuestionTextChange(e){
        this.newQuestionText = e.target.value;

    }

    // Add a new question to the assessment
    handleAddQuestion() {
        const newQuestion = {
            assessmentQuestionId: null, // ID will be created after saving in Salesforce
            questionNumber: this.editedQuestions.length + 1, // Auto-increment question number
            questionText: this.newQuestionText,
            assessment: this.assessmentId // Link the new question to the current assessment
        };

        // Call Apex method to create the question
        createAssessmentQuestion({ asseessmentQuestionData: JSON.stringify(newQuestion) })
            .then(() => {
                this.newQuestionText = ''; // Clear input field
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'New question added successfully',
                        variant: 'success',
                    })
                );
                this.loadAssessmentData(); // Reload the assessment data after saving
            })
            .catch(error => {
                this.error = error.body.message;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Failed to add new question',
                        variant: 'error',
                    })
                );
            });
    }

    // Save changes to the existing questions
    handleSave() {
        // Loop through each edited question and save changes
        this.editedQuestions.forEach(question => {
            const updatedQuestion = {
                ...question,
                assessmentId: this.assessmentId // Ensure the question is linked to the assessment
            };

            updateAsssessmentQuestion({ assessmentQuestionData: JSON.stringify(updatedQuestion) })
                .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Questions updated successfully',
                            variant: 'success',
                        })
                    );
                    this.loadAssessmentData(); // Reload the data to reflect updates
                })
                .catch(error => {
                    this.error = error.body.message;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: `Failed to update question: ${question.questionNumber}`,
                            variant: 'error',
                        })
                    );
                });
        });
    }

    // Delete a question from the assessment
    handleDeleteQuestion(event) {
        const questionId = event.target.dataset.id;

        deleteAssessmentQuestion({ assessmentQuestionId: questionId })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Question deleted successfully',
                        variant: 'success',
                    })
                );
                this.loadAssessmentData(); // Reload the assessment data after deletion
            })
            .catch(error => {
                this.error = error.body.message;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Failed to delete question',
                        variant: 'error',
                    })
                );
            });
    }

    // Handle navigation back to the previous page
    handleBack() {
        window.history.back();
    }
}