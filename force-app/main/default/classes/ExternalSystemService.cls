public  class ExternalSystemService {

     /**
      * register an attendee in an external system
      * @param caseID case whose account contacts will be registered and notified 
      */
    @future (callout=true)
    public static void registerAttendees(Id caseID){
        // select account by caseId
        Account account = AccountSelector.getAccountByCaseId(caseID);
        // select contacts to be registered by accountId
        List<Contact> contacts = ContactSelector.getContactsByAccountId(account.Id);
        
        for(Contact c : contacts){
            HttpResponse response = RegistrationHelper.createRegistration(c);
            if (response.getStatusCode() != 201) {
                Log.error('The status code returned was not expected: ' + response.getStatusCode());
            } else {
                // Everything went as expected.
                EmailService.notifyAttendeeByEmail(c);
            }
        }
    }
}
