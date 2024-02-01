public without sharing class CampaignUpdateBatch implements Database.Batchable <sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        //query
        Database.QueryLocator q1 = Database.getQueryLocator([ SELECT id, Remaining_Donation_Amount__c,EndDate,Status FROM Campaign 
                                                              WHERE Remaining_Donation_Amount__c>0 AND EndDate <=YESTERDAY ]);
        //return CHUNK of it.
        return q1;
    }

    public void execute(Database.BatchableContext bc, list<Campaign> scope){
        //update records.
        
        system.debug('execute method start');
        list <Campaign> updateCamp = new list<Campaign>();
        for(Campaign eachCamp : scope){
            
            eachCamp.Status='Expired';
            updateCamp.add(eachCamp);
                          
        }

        if(!updateCamp.isEmpty()){
        update updateCamp;
        system.debug('execute method done');

        }
    }
    public void finish(Database.BatchableContext bc){
        system.debug('finish method called.');
        
    }

} 





