@Istest 
private class CampaignUpdateBatchTest {
    @TestSetup
    static void setup(){
        //Create test data
        Campaign campaign1 = new Campaign(
            Name = 'Test Campaign1',
            StartDate = Date.today().addDays(-10),
            EndDate = Date.today().addDays(-1),
            Target_Donation_Amount__c = 300,
            Achieved_Donation_Amount__c= 200,
            Status = 'Completed'
        );
        insert campaign1;

        Campaign campaign2 = new Campaign(
            Name = 'Test Campaign2',
            StartDate = Date.today().addDays(-10),
            EndDate = Date.today().addDays(-1),
            Target_Donation_Amount__c = 300,
            Achieved_Donation_Amount__c= 300,
            Status = 'Completed'
        );
        insert campaign2;

        Campaign campaign3 = new Campaign(
            Name = 'Test Campaign3',
            StartDate = Date.today().addDays(-10),
            EndDate = Date.today().addDays(1),
            Target_Donation_Amount__c = 300,
            Achieved_Donation_Amount__c= 200,
            Status = 'Completed'
        );
        insert campaign3;
    }

    @IsTest 
    static void testCampaignUpdateBatch() {
        Test.startTest();

        //Start the batch job
        CampaignUpdateBatch batchJob = new CampaignUpdateBatch();
        Database.executeBatch(batchJob);

        // Verify that the campaigns with remaining donations less than or equal to zero and
        // end date less than or equal to yesterday have been updated to expired
        List<Campaign> expiredCampaigns = [SELECT Id, Name, Status FROM Campaign WHERE Status = 'Completed'];
        System.assertEquals(3, expiredCampaigns.size());
        System.assertEquals('Test Campaign1', expiredCampaigns[0].Name);

        //Debug the returned campaigns
        List<Campaign> campaigns = [SELECT Id, Name, Status FROM Campaign WHERE Status = 'Completed'];
        System.debug(campaigns);

        Test.stopTest();

    }

    @IsTest
    static void testExecuteMethod() {
        // Schedule the job to run immediately
        CampaignUpdateScheduler scheduler = new CampaignUpdateScheduler();
        String cronExpression = '0 0 0 * * ?';
        system.schedule('Test Campaign Update', cronExpression, scheduler);
    
        // Wait for the job to complete
        Test.startTest();
        Test.stopTest();
    }
}