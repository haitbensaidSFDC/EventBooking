public with sharing class ContactSelector {
    /**
     * returns a List of Contacts associated with the given Account Id.
     * @param accountId
     * @return A List of Contacts associated with the provided Account Id.
     */
    public static List<Contact> getContactsByAccountId(Id accountId) {
        return [SELECT Id, Name, FirstName, LastName, Email FROM Contact WHERE AccountId = :accountId];
    }
}