public with sharing class AccountSelector {

    /**
     * returns the list of accounts by Ids assiciated with contacts lists
     * @param accountIds 
     * @return  `Map<Id, Account>`
     */
    public static Map<Id, Account> getAccountsByIds(Set<Id> accountIds) {
        // Execute a SOQL query to retrieve the specified accounts and their related contacts
        Map<Id, Account> accounts = new Map<Id, Account>([
            SELECT Id, (SELECT Id FROM Contacts) FROM Account
            WHERE Id IN :accountIds
        ]);
        return accounts;
    }
}