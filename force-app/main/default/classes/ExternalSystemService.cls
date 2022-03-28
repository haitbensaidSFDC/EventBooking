/**
 * @description       :
 * @author            : melbazi@salesforce.com
 * @group             :
 * @last modified on  : 28-03-2022
 * @last modified by  : melbazi@salesforce.com
 **/
public class ExternalSystemService {
  private static String webServiceURL = 'callout:B_Hotels_Credentials/animals';

  @future(callout=true)
  public static void registerAttendees(Id requestId) {
    Case reservationRequest = [
      SELECT Id, AccountId
      FROM Case
      WHERE Id = :requestId
      LIMIT 1
    ];
    for (Account company : [
      SELECT id, (SELECT id, name, email FROM Contacts)
      FROM Account
      WHERE id = :reservationRequest.AccountId
    ]) {
      for (Contact attendee : company.Contacts) {
        Http http = new Http();
        HttpRequest request = ExternalSystemHelper.buildRegisterRequest(
          webServiceURL,
          attendee
        );
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 201) {
          System.debug(
            'The status code returned was not expected: ' +
            response.getStatusCode() +
            ' ' +
            response.getStatus()
          );
        } else {
          // Everything went as expected.
          System.debug(response.getBody());
          notifyAttendeeByEmail(attendee);
          Log.error('success');
        }
      }
    }
  }

  private static void notifyAttendeeByEmail(Contact attendee) {
    String email = attendee.email;
    String subject = 'You registration for B.hotels was succesfully confirmed';
    String body =
      'Hi ' +
      attendee.name +
      ',\nYou registration for B.hotels was succesfully confirmed.\nEnjoy your stay!';
    EmailService emailService = new EmailService();
    emailService.sendEmail(email, subject, body);
  }
}
