@isTest
public class CaseTriggerHelper_Test {  
    
    @isTest
    public static void refuseCaseCreationWhenAnAccountIsNotAttachedToACase(){
        // Given
        
        Case request = TestDataFactory.createCaseDataWithoutAccount();
        
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot create a request without attaching an account',
                            result.getErrors()[0].getMessage());
    }
    @isTest
    public static void refuseCaseCreationWhenNoContactIsAttachedToAnAccount(){
        // Given
        
        Account a1 = TestDataFactory.createAccountData('Test Account');
        insert a1;
        
        Case request = TestDataFactory.createCaseData('Phone',a1.Id);            
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot create a request for accounts without contacts',
                            result.getErrors()[0].getMessage());
    }
    
    @isTest
    public static void bookEventFromPhone(){
        // Given
        
        Account a1 = TestDataFactory.createAccountData('Test Account');
        insert a1;
        
        List<Contact> con = TestDataFactory.createConData(a1.Id,3);
        insert con;
        
        
        Case request = TestDataFactory.createCaseData('Phone',a1.Id);            
        
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        Test.stopTest();
        
        // Then
        
        System.assert(result.isSuccess());
        
        
    }
    
    @isTest
    public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanThreeForPhoneCases(){
        // Given
        
        Account a1 = TestDataFactory.createAccountData('Test Account');
        insert a1;
        
        List<Contact> con = TestDataFactory.createConData(a1.Id,4);
        insert con;
        
        
        Case request = TestDataFactory.createCaseData('Phone',a1.Id);            
        
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Phone request are only allowed to have three attendee',
                            result.getErrors()[0].getMessage());
        
    }
    @isTest
    public static void bookEventFromTheWeb(){
        // Given
        
        Account a1 = TestDataFactory.createAccountData('Test Account');
        insert a1;
        
        List<Contact> con = TestDataFactory.createConData(a1.Id,1);
        insert con;
        
        
        Case request = TestDataFactory.createCaseData('Web',a1.Id);  
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(result.isSuccess());
        
        
    } 
    @isTest
    public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanOneForWebCases(){
        // Given
        
        Account a1 = TestDataFactory.createAccountData('Test Account');
        insert a1;
        
        List<Contact> con = TestDataFactory.createConData(a1.Id,3);
        insert con;
        
        
        Case request = TestDataFactory.createCaseData('Web',a1.Id);  
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Web request are only allowed to have one attendee',
                            result.getErrors()[0].getMessage());
        
        
    } 
    
     /*@isTest(SeeAllData=true)
    public static void registerAttendees(){
        // Given
        
        Account a1 = TestDataFactory.createAccountData('Test Account');
        insert a1;
        
        List<Contact> con = TestDataFactory.createConData(a1.Id,3);
        insert con;
        
        
        Case request = TestDataFactory.createCaseData('Phone',a1.Id);            
        insert request;
        request.Status='Closed';
        
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.Update(request, false);
        Test.stopTest();
        
        // Then
        
        System.assert(result.isSuccess());
        
        
    }*/

    
}