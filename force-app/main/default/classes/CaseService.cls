public with sharing class CaseService {

    public static void validateReservationCases(List<Case> reservationCases) {
        Set<Id> accountIds = new Set<Id>();
        for (Case reservationsCase : reservationCases) {
            ID Veer = reservationsCase.AccountId;
            if (reservationsCase.Account == null) {
                reservationsCase.addError('You cannot create a request without attaching an account');
            } else {
                accountIds.add(reservationsCase.AccountId );
            }
        }
        
        Map<Id, Account> accountsWithContacts = AccountSelector.selectAccountsWithContacts(accountIds);
        for (Case reservationsCase : reservationCases) {
            Account account = accountsWithContacts.get(reservationsCase.AccountId);
            Integer contactsCount = account?.Contacts?.size();
            if (contactsCount == 0) {
                reservationsCase.addError('You cannot create a request for accounts without contacts');
            } else if (reservationsCase.Origin.equalsIgnoreCase(Constants.WEB_ORIGIN) && contactsCount > 1) {
                reservationsCase.addError('Web request are only allowed to have one attendee');
            } else if (reservationsCase.Origin.equalsIgnoreCase(Constants.PHONE_ORIGIN) && contactsCount > 3) {
                reservationsCase.addError('Phone request are only allowed to have three attendees');
            }
        }       
    }
}