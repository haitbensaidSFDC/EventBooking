@isTest
private class AccountSelectorTest {
    @isTest
    static void testGetAccountsByIds() {
        // given
        List<Account> accounts = new List<Account>{
            new Account(Name='Test Account 1'),
            new Account(Name='Test Account 2')
        };
        insert accounts;
        
        List<Contact> contacts = new List<Contact>{
            new Contact(AccountId=accounts[0].Id, LastName='Test Contact 1'),
            new Contact(AccountId=accounts[1].Id, LastName='Test Contact 2'),
            new Contact(AccountId=accounts[1].Id, LastName='Test Contact 3')
        };
        insert contacts;
        
        // when
        Set<Id> accountIds = new Set<Id>{accounts[0].Id, accounts[1].Id};
        Map<Id, Account> result = AccountSelector.getAccountsByIds(accountIds);
        
        // then
        System.assertEquals(2, result.size());
        System.assertEquals(accounts[0].Id, result.get(accounts[0].Id).Id);
        System.assertEquals(1, result.get(accounts[0].Id).Contacts.size());
        System.assertEquals(accounts[1].Id, result.get(accounts[1].Id).Id);
        System.assertEquals(2, result.get(accounts[1].Id).Contacts.size());
    }
}