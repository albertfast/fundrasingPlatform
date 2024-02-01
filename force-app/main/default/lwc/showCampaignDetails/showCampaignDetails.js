import { LightningElement, api } from 'lwc';
import DONATIONCAMPAIGN from '@salesforce/schema/Campaign';
import NAME from '@salesforce/schema/Campaign.Name';
import TARGETDONATION from '@salesforce/schema/Campaign.Target_Donation_Amount__c';
import ACHIEVEDDONATION from '@salesforce/schema/Campaign.Achieved_Donation_Amount__c';
import REMAININGDONATION from '@salesforce/schema/Campaign.Remaining_Donation_Amount__c';
import ENDDATE from '@salesforce/schema/Campaign.EndDate';

export default class ShowCampaignDetails extends LightningElement {
    objectName= DONATIONCAMPAIGN;
    fields={
        name: NAME,
        targetDonation: TARGETDONATION,
        achievedDonation: ACHIEVEDDONATION,
        remainingDonation:REMAININGDONATION,
        endDate:ENDDATE,
 
    }
    @api recordId;
}

