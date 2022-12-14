public with sharing class EmailService {

    /**
     * mehtod used to send email messages
     * @param toAddresse email address of recipient
     * @param subject subject of the message
     * @param body body of the message 
     */
    public static void sendEmail(String toAddresse, String subject, String body) {

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { toAddresse };
        message.subject = subject;
        message.plainTextBody = body;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            Log.error('notify success');
            System.debug('email is sent successfully.' + results[0]);
        } else {
            Log.error('The email failed to send: ' + results[0].errors[0].message);
        }
    }
  }