public with sharing class AccountSelector {

    /**
     * returns the list of accounts by Ids assiciated with contacts lists
     * @param accountIds 
     * @return  `Map<Id, Account>`
     */
    public static Map<Id, Account> getAccountsByIds(Set<Id> accountIds) {
        Map<Id, Account> accounts = new Map<Id, Account>([
            SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account
            WHERE Id IN :accountIds
        ]);
        return accounts;
    }

    /**
     * Returns the Account associated with a Case Id.
     * @param caseId 
     * @return The associated Account
     */
    public static Account getAccountByCaseId(Id caseId) {
        List<Case> cases = [SELECT Id, AccountId FROM Case WHERE Id = :caseId];
        if (cases.isEmpty() || cases[0].AccountId == null) {
            return null;
        }
        Map<Id, Account> accounts = getAccountsByIds(new Set<Id>{cases[0].AccountId});
        return accounts.get(cases[0].AccountId);
    }
}