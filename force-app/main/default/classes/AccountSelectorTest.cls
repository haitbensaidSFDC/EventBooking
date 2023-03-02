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
    }

    @isTest
    static void testGetAccountByCaseId() {
        // given
        List<Account> accounts = new List<Account>{
            new Account(Name='Test Account 1'),
            new Account(Name='Test Account 2')
        };
        insert accounts;

        List<Contact> contacts = new List<Contact>{
            new Contact(AccountId=accounts[0].Id, LastName='Test Contact 1'),
            new Contact(AccountId=accounts[1].Id, LastName='Test Contact 2')
        };
        insert contacts;

        List<Case> cases = new List<Case>{
            new Case(Subject='Test Case 1', AccountId=accounts[0].Id),
            new Case(Subject='Test Case 2', AccountId=accounts[1].Id)
        };
        insert cases;

        // when
        Account result = AccountSelector.getAccountByCaseId(cases[0].Id);


        // then
        System.assertEquals(accounts[0].Id, result.Id);
        System.assertEquals(accounts[0].Name, result.Name);
    }

    @isTest
    static void testGetAccountByCaseIdReturnsNull() {
        Account result = AccountSelector.getAccountByCaseId('000000000000000000');
        System.assertEquals(null, result);
    }
}