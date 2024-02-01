public with sharing class createDummyCampaignRecords {
    public static void createCampaignAccount() {
        List<Campaign> cmpgn = new List<Campaign>();
        for (Integer i = 1; i <= 10; i++) {
            Campaign cg = new Campaign();
            cg.Name = 'Predestination ' + i;
            cg.Target_Donation_Amount__c =  8200;
            cg.Achieved_Donation_Amount__c= 11000;
            cg.StartDate= Date.today();
            cg.EndDate= Date.today().addDays(+10);
            cg.Campaign_Completion_Date__c= Date.today().addDays(+10);
            cg.Status = 'Expired';
            cmpgn.add(cg);
        }
        if(!cmpgn.isEmpty()){
            insert cmpgn;
        }
    }
}

