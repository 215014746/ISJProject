import { LightningElement, api, track } from 'lwc';
import getCaseSummaryCaseReceiver from '@salesforce/apex/CaseDashboardController.getCaseSummaryCaseReceiver';


export default class LecturerCaseDashboard extends LightningElement {
    @api caseReceiverId; 
    @track caseSummary = { New: 0, InProgress: 0, Closed: 0 };
    @track error;

    // Invoked when the component is inserted into the DOM
    connectedCallback() {
        console.log('LecturerCaseDashboard connected. caseReceiverId:', this.caseReceiverId);
        this.loadCaseStatusSummary();
    }

    // Method to call Apex imperatively
    loadCaseStatusSummary() {
        getCaseSummaryCaseReceiver({ caseReceiverId: this.caseReceiverId })
            .then((data) => {
                console.log('Data received:', data);
                this.caseSummary = {
                    New: data.New || 0,
                    InProgress: data.InProgress|| 0,
                    Closed: data.Closed || 0
                };
                this.error = undefined;
                console.log('Case Summary:', this.caseSummary);
            })
            .catch((error) => {
                console.error('Error:', error);
                this.error = error.body ? error.body.message : 'Unknown error';
                this.caseSummary = { New: 0, InProgress: 0, Closed: 0 };
            });
    }
}