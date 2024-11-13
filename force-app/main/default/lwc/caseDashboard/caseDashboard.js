import { LightningElement, wire } from 'lwc';
import getCasesSummary from '@salesforce/apex/CaseDashboardController.getCasesSummary';

export default class CaseDashboard extends LightningElement {
    // Holds the summary data of cases
    caseSummary;
    // Wire to fetch case summary data from Apex
    @wire(getCasesSummary)
    wiredCaseSummary({ error, data }) {
        console.log(data);
        if (data) {
            this.caseSummary = data;// Assign data if available
        } else if (error) {
            console.error('Error fetching case summary', error);
        }
    }
}