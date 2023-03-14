public with sharing class EmailService {

    /**
     * Notify the provided Contact by email about their registration.
     * @param contact The Contact to be notified.
     */
    public static void notifyAttendeeByEmail(Contact contact) {
        // Format the confirmation body with the Contact's name
        String body = String.format(Constants.CONFIRM_BODY, new String[]{contact.Name});

        // Send the confirmation email
        sendEmail(contact.Email, Constants.CONFIRM_SUBJECT, body);
    }

    /**
     * mehtod used to send email messages
     * @param toAddresse email address of recipient
     * @param subject of the message
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
            // used to verify success in unit test
            Log.error(Constants.EMAIL_SUCCESS_MESSAGE);
        } else {
            // used to verify failure in unit test
            Log.error(Constants.EMAIL_ERROR_MESSAGE + results[0].errors[0].message);
        }
    }
  }