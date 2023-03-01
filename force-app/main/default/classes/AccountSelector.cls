public with sharing class AccountSelector {
    public static Map<Id, Account> selectAccountsWithContacts(Set<Id> accountIds) {
        return new Map<Id, Account>([
            SELECT Id, (SELECT Id FROM Contacts)
            FROM Account
            WHERE Id IN :accountIds
        ]);
    }
}