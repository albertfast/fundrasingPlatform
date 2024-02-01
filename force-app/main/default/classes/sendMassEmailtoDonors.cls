public with sharing class sendMassEmailtoDonors {
  // Invocable method to send campaign notification emails to donors with consent
  @InvocableMethod(label='Send Campaign Notification Emails')
  public static void sendCampaignNotificationEmails(List<inputRequest> inputs) {
    InputRequest request = inputs[0];
    
    List<Messaging.SingleEmailMessage> donorEmail = new List<Messaging.SingleEmailMessage>();

    // Get the email template for the campaign notification email
    List<EmailTemplate> emailTemplates = [SELECT Id, Subject, HtmlValue, Body FROM EmailTemplate WHERE DeveloperName = 'Send_Campaign_Notification_Emails' LIMIT 1];
    if (emailTemplates.isEmpty()) {
      System.debug('Email template not found');
      // choose a default EmailTemplate or show an error message
    } else {
      EmailTemplate emailTemplate = emailTemplates[0];
      
      // Get the accounts with the donor emails
      Set<String> donorEmails = new Set<String>();
      for (InputRequest input : inputs) {
        donorEmails.addAll(input.donorEmail);
      }
      List<Account> accounts = [SELECT Id, PersonEmail, PersonContactId FROM Account WHERE PersonEmail IN :donorEmails];

      // Loop through the list of donors and send them an email for each campaign
      for (InputRequest input : inputs) {
        for (Account acc : accounts) {
          if (input.donorEmail.contains(acc.PersonEmail)) {
            //Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(emailTemplate.Id, acc.PersonContactId, acc.Id);
            Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(emailTemplate.Id, acc.PersonContactId, input.campaignId[0]);
            mail.setHtmlBody(Messaging.renderStoredEmailTemplate(emailTemplate.Id, acc.PersonContactId, input.campaignId[0]).getHtmlBody());
            mail.setToAddresses(new List<String>{acc.PersonEmail});
            mail.setTargetObjectId(acc.PersonContactId);
            mail.setTemplateId(emailTemplate.Id);
            mail.setSaveAsActivity(true);
            mail.setWhatId(input.campaignId[0]);
            donorEmail.add(mail);
          }
        }
        if (!donorEmail.isEmpty()) {
          Messaging.sendEmail(donorEmail);
        }
      }
    }
  }
  public class InputRequest {
    @invocableVariable(label = 'Donor Email' description = 'Donor Email' required = true)
    public List<String> donorEmail;

    @invocableVariable(label = 'Campaign Id' description = 'Campaign Id' required = true)
    public List<Id> campaignId;
  }
}