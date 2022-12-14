public  class ExternalSystemService {

     /**
      * register an attendee in an external system
      * @param caseID case whose account contacts will be registered and notified 
      */
    @future (callout=true)
    public static void registerAttendees(Id caseID){
        
            Case reservation = [SELECT Id, AccountId FROM Case WHERE Id = :caseID LIMIT 1 ];

            for(Account a : [ SELECT id, (SELECT id, name, email FROM Contacts) FROM Account WHERE id = :reservation.AccountId]){
                
                for(Contact c : a.Contacts){

                    HttpResponse response = RegistrationHelper.createRegistration(c);

                    if (response.getStatusCode() != 201) {
                        Log.error('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
                    } else {
                       // Everything went as expected.
                       EmailService.notifyAttendeeByEmail(c);
                    }
                }
        }
    } 
    
}
