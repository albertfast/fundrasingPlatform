import { LightningElement,api,track } from 'lwc';
import fetchCampaign from '@salesforce/apex/DonationUtility.fetchCampaigns';
export default class activeCampaignList extends LightningElement {

    
    @track campaignList;
    isOpenCampaignModel = false;
    cmp;
    campaignId;

    connectedCallback() {
        fetchCampaign()
        .then((result) => {
            if(result){
                this.campaignList =[];
                console.log('Apex Result::: '+JSON.stringify(result));
                for(let i = 0; i< result.length; i++){
                    this.campaignList.push({
                        image : result[i].Image_URL__c ,
                        heading : result[i].Name, 
                        description : result[i].Description,
                        id : result[i].Id
                        });
                }
                console.log(JSON.stringify(this.campaignList)); 
            }  
        })
        .catch((error) => {
            console.log(JSON.stringify(error)); 
        });
    }


    openCampaignDetail(event){
        console.log("Parent component text clickeeed");
        this.isOpenCampaignModel = true;
        const index = event.detail;
        console.log(event.detail);
        this.cmp = this.campaignList[index-1];
    }

    CloseModal(){
        this.isOpenCampaignModel = false;
        this.cmp = undefined;
    }
}