@isTest
public class ContactSelectorTest {
    
    @isTest
    public static void testGetContactsByAccountId() {
        // given
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Contact testContact1 = new Contact(FirstName = 'fname1', LastName = 'name1', Email = 'test@test1.com', AccountId = testAccount.Id);
        Contact testContact2 = new Contact(FirstName = 'fname2', LastName = 'name2', Email = 'test@test2.com', AccountId = testAccount.Id);
        insert new List<Contact>{testContact1, testContact2};

        // when
        List<Contact> contacts = ContactSelector.getContactsByAccountId(testAccount.Id);
        
        // then
        System.assertEquals(2, contacts.size());
    }
}