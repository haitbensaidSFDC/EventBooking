public class CaseTriggerHelper { 
    
    public static void validateReservation(List<Case> resRequests){
        Set<Id> accountIds = new Set<Id>();
        for(Case resRequest : resRequests){
            if(resRequest.AccountId != null)
                accountIds.add(resRequest.AccountId);
        }
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts)FROM Account WHERE Id IN :accountIds ]; 
        
        for(Case resRequest : resRequests){
            // Testing if the content of case is null or not to avoid NPE ;) 
            if(resRequest != null && resRequest.AccountId != null){
                
                for (Account account: accounts) {
                    if (account.Id == resRequest.AccountId) {
                        Integer relatedContacts = account.Contacts.size();
                        resRequest = addRequestErrors(resRequest, relatedContacts);
                    }
                }
            }else{
                resRequest.addError('You cannot create a request without attaching an account');
            }      
        }  
    }
    
    public static void registerAttendees(List<Case> resRequests){
        Set<Id> accountIds = new Set<Id>();
        for(Case resRequest : resRequests){
            if(resRequest.Status == 'Closed'){
                accountIds.add(resRequest.AccountId);
            }
        }
        ExternalSystemService.registerAttendees(accountIds);
    }
    
    public static Case addRequestErrors(Case req, Integer relatedContacts){
        Case resRequest = req;
        if(relatedContacts == 0){
            resRequest.addError('You cannot create a request for accounts without contacts');
            Log.error('You cannot create a request for accounts without contacts');
        }else{
            switch on resRequest.Origin {
                when 'Web' {
                    if(relatedContacts >= 2 ){
                        resRequest.addError('Web request are only allowed to have one attendee');
                        Log.error('Web request are only allowed to have one attendee');
                    }
                }
                when 'Phone'{
                    if(relatedContacts >= 4 ){
                        resRequest.addError('Phone request are only allowed to have three attendee');
                        Log.error('Phone request are only allowed to have three attendee');
                    }
                }
            }        
        }
        return resRequest;
    }
    
    
}