
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
                caseRequest.addError(Constants.ERROR_NO_ACCOUNT_ATTACHED);
                continue;
            }
            Account account = accounts.get(caseRequest.AccountId);
            if (account == null || account.Contacts.isEmpty()) {
                caseRequest.addError(Constants.ERROR_NO_CONTACTS_FOR_ACCOUNT);
                continue;
            }
            Integer numAttendees = account.Contacts.size();
            if (caseRequest.Origin == Constants.WEB_ORGIN && numAttendees > Constants.LIMIT_WEB_ATTENDEES) {
                caseRequest.addError(Constants.ERROR_TOO_MANY_ATTENDEES_FOR_WEB);
            } else if (caseRequest.Origin == Constants.PHONE_ORGIN && numAttendees > Constants.LIMIT_PHONE_ATTENDEES) {
                caseRequest.addError(Constants.ERROR_TOO_MANY_ATTENDEES_FOR_PHONE);
            }
        }
    }

    /**
     * 
     * @param newCases 
     */
    public static void manageRegestrations(List<Case> newCases) {
        for(Case caseRequest : newCases) {
            if(caseRequest.Status == Constants.STATUS_CLOSED){
                ExternalSystemService.registerAttendees(caseRequest.Id);
            }
        }
    }
}