/**
 * @description       :
 * @author            : melbazi@salesforce.com
 * @group             :
 * @last modified on  : 28-03-2022
 * @last modified by  : melbazi@salesforce.com
 **/
public with sharing class EmailService {
  public void sendEmail(String email, String subject, String body) {
    Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
    String[] sendingTo = new List<String>{ email };
    semail.setToAddresses(sendingTo);
    semail.setSubject(subject);
    semail.setPlainTextBody(body);
    Messaging.SendEmailResult[] results = Messaging.sendEmail(
      new List<Messaging.SingleEmailMessage>{ semail }
    );

    if (results[0].success) {
      System.debug('The email was sent successfully.');
    } else {
      Log.error('The email failed to send: ' + results[0].errors[0].message);
    }
  }
}
