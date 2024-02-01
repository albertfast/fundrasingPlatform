public without sharing class ManageDonation {
    @AuraEnabled(cacheable=true)
    public static List<TopContributor> fetchTopContributors() {
        List<TopContributor> topContributors = new List<TopContributor>();
        List<Account> accounts = [SELECT Id, Name, Total_Donation__c, Anonymous__c
                                  FROM Account
                                  WHERE IsPersonAccount = true
                                  ORDER BY Total_Donation__c DESC
                                  LIMIT 3];

        for(Account acc : accounts) {
            topContributors.add(new TopContributor(
                acc.Name,
                acc.Anonymous__c ? 'Anonymous' : acc.Name,
                acc.Total_Donation__c
            ));
        }

        return topContributors;
    }

    public class TopContributor {
        @AuraEnabled public String name;
        @AuraEnabled public String displayName;
        @AuraEnabled public Decimal totalDonation;

        public TopContributor(String name, String displayName, Decimal totalDonation) {
            this.name = name;
            this.displayName = displayName;
            this.totalDonation = totalDonation;
        }
    }
}


  
  