@isTest
private class SendMassEmailtoDonorsTest {
  @isTest
  static void testSendCampaignNotificationEmails() {
    // Create test data
    /*Contact testContact = new Contact(
      FirstName = 'Test',
      LastName = 'Contact',
      Email = 'betulozbudak@gmail.com'
    );*/
    
    Account testAccount = new Account(
      Name = 'Test Account',
      PersonEmail = 'betulozbudak@gmail.com'
      
    );
    

    Campaign testCampaign = new Campaign(
      Name = 'Test Campaign',
      IsActive = true
    );
  
    EmailTemplate testEmailTemplate = new EmailTemplate(
      DeveloperName = 'Send_Campaign_Notification_Emails',
      FolderId = UserInfo.getUserId(),
      Subject = 'Test Subject',
      HtmlValue = 'Test Body'
    );

    
    Database.insert(testAccount, false);
    //Database.insert(testContact,false);
    Database.insert(testCampaign,false);
    Database.insert(testEmailTemplate,false);
    

    

    List<sendMassEmailtoDonors.InputRequest> testInputs = new List<sendMassEmailtoDonors.InputRequest>();
    sendMassEmailtoDonors.InputRequest testInput = new sendMassEmailtoDonors.InputRequest();
    testInput.donorEmail = new List<String>{testAccount.PersonEmail};
    testInput.campaignId = new List<Id>{testCampaign.Id};
    testInputs.add(testInput);

    Test.startTest();

    // Call the sendCampaignNotificationEmails method
    sendMassEmailtoDonors.sendCampaignNotificationEmails(testInputs);

    Test.stopTest();

    // Verify that an email was sent
    List<EmailMessage> sentEmails = [
      SELECT Id
      FROM EmailMessage
      WHERE RelatedToId = :testCampaign.Id
    ];
    System.assertEquals(1, sentEmails.size(), 'One email should have been sent');
  }
}