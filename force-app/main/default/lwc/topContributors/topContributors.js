import fetchTopContributors from '@salesforce/apex/ManageDonation.fetchTopContributors';
import { LightningElement, wire } from 'lwc';

export default class TopContributors extends LightningElement {
    error;
    @wire(fetchTopContributors)
    accounts;

    get topContributors() {
        if(this.accounts.data) {
            return this.accounts.data.map(acc => {
                return {
                    name: acc.name,
                    displayName: acc.displayName,
                    totalDonation: acc.totalDonation
                }
            });
        }
        return [];
    }
}

