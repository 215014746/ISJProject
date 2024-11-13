import { LightningElement, wire } from 'lwc';
import getCasesSummary from '@salesforce/apex/CaseDashboardController.getCasesSummary';

export default class CaseDashboard extends LightningElement {
    caseSummary;

    @wire(getCasesSummary)
    wiredCaseSummary({ error, data }) {
        console.log(data);
        if (data) {
            this.caseSummary = data;
        } else if (error) {
            console.error('Error fetching case summary', error);
        }
    }
}