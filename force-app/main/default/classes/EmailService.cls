public with sharing class EmailService {

    /**
     * notify contacts by email about registration
     * @param contact contact to be notified
     */
    public static void notifyAttendeeByEmail(Contact contact){
        String confirmSubject = 'B.hotels Registration confirmed';
        String body = 'Hello ' + contact.name + ' \n Your registration is confirmed \n ' + 'Cordially!' ;
        sendEmail(contact.Email, confirmSubject, body);
    } 

    /**
     * mehtod used to send email messages
     * @param toAddresse email address of recipient
     * @param subject subject of the message
     * @param body body of the message 
     */
    private static void sendEmail(String toAddresse, String subject, String body) {

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