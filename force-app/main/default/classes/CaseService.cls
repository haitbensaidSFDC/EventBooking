public with sharing class CaseService {

    /**
     * 
     * @param newCases 
     */
    public static void validateCases(List<Case> newCases) {
        Set<Id> accountIds = new Set<Id>();
        for (Case caseRequest : newCases) {
            accountIds.add(caseRequest.AccountId);
        } 
        Map<Id, Account> accounts = AccountSelector.getAccountsByIds(accountIds);
        
        for (Case caseRequest : newCases) {
            if (caseRequest.AccountId == null) {
                caseRequest.addError('You cannot create a request without attaching an account');
                continue;
            }
            Account account = accounts.get(caseRequest.AccountId);
            if (account == null || account.Contacts.isEmpty()) {
                caseRequest.addError('You cannot create a request for accounts without contacts');
                continue;
            }
            Integer numAttendees = account.Contacts.size();
            if (caseRequest.Origin == 'Web' && numAttendees > 1) {
                caseRequest.addError('Web request are only allowed to have one attendee');
            } else if (caseRequest.Origin == 'Phone' && numAttendees > 3) {
                caseRequest.addError('Phone request are only allowed to have three attendee');
            }
        }
    }

    /**
     * 
     * @param newCases 
     */
    public static void manageRegestrations(List<Case> newCases) {
        for(Case caseRequest : newCases) {
            if(caseRequest.Status == 'Closed'){
                ExternalSystemService.registerAttendees(caseRequest.Id);
            }
        }
    }
}



