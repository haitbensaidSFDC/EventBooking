public  class ExternalSystemService {

    @future(callout=true)
    public static void registerAttendees(Id caseID){
        
            Case reservation = [SELECT Id, AccountId FROM Case WHERE Id = :caseID LIMIT 1 ];

            for(Account a : [ SELECT id, (SELECT id, name, email FROM Contacts) FROM Account WHERE id = :reservation.AccountId]){
                for(Contact c : a.Contacts){

                    HttpResponse response = RegistrationHelper.createRegistration(c);

                    if (response.getStatusCode() != 201) {
                        System.debug('The status code returned was not expected: ' +
                            response.getStatusCode() + ' ' + response.getStatus());
                    } else {
                       // Everything went as expected.
                       notifyAttendeeByEmail(c);
                    }
                }
        }
    } 

    public static void notifyAttendeeByEmail(Contact contact){
        String confirmSubject = 'B.hotels Registration confirmed';
        String body = 'Hello ' + contact.name + ' \n Your registration is confirmed \n ' + 'Cordially!' ;
        EmailService.sendEmail(contact.Email, confirmSubject, body);
    } 
}
