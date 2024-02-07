public without sharing class DonationUtility {
    @AuraEnabled(cacheable=true)
    public static List<Account> fetchTopCont(){
        return [SELECT Id,Name,Total_Donation__c,Anonymous__c 
                FROM Account 
                WHERE IsPersonAccount=true
                ORDER BY Total_Donation__c DESC
                LIMIT 3];
    }
    @AuraEnabled(cacheable=true)
    public static List<Campaign> fetchCampaigns(){
        try {
            return [SELECT Id,Name,Description,Image_URL__c 
                    FROM Campaign 
                    WHERE Status =:Constant.ACTIVE_STATUS 
                    LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
            
        }
    }
}