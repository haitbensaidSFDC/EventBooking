@isTest
public class EventBookingTest {  

    @isTest
    public static void refuseCaseCreationWhenAnAccountIsNotAttachedToACase(){
        // Given

        Case request = new Case(Origin = 'Phone',Subject = 'Event Booking', Description = 'Book Spots');
        
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
    
        Account a1 = new Account(Name = 'Salesforce');
        insert a1;

        Case request = new Case(Origin = 'Phone',Subject = 'Event Booking', Description = 'Book Spots', AccountId = a1.ID);
        
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
        
        Account a1 = new Account(Name = 'Salesforce');
        insert a1;
        
        Contact c1 = new Contact(LastName = 'Contact 1', AccountId = a1.ID);
        insert c1;

        Contact c2 = new Contact(LastName = 'Contact 2', AccountId = a1.ID);
        insert c2;

        Contact c3 = new Contact(LastName = 'Contact 3', AccountId = a1.ID);
        insert c3;

        Case request = new Case(Origin = 'Phone',Subject = 'Event Booking', Description = 'Book Spots for Company A1 & their 3 employees', AccountId = a1.ID);
        
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
        
        Account a1 = new Account(Name = 'Salesforce');
        insert a1;
        
        Contact c1 = new Contact(LastName = 'Contact 1', AccountId = a1.ID);
        insert c1;

        Contact c2 = new Contact(LastName = 'Contact 2', AccountId = a1.ID);
        insert c2;

        Contact c3 = new Contact(LastName = 'Contact 3', AccountId = a1.ID);
        insert c3;

        Contact c4 = new Contact(LastName = 'Contact 4', AccountId = a1.ID);
        insert c4;

        Case request = new Case(Origin = 'Phone',Subject = 'Event Booking', Description = 'Book Spots for Company A1 & their 4 employees', AccountId = a1.ID);
        
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
        Account a1 = new Account(Name = 'Salesforce');
        insert a1;
        Contact c1 = new Contact(LastName = 'Contact 1', AccountId = a1.ID);
        insert c1;

        Case request = new Case(Origin = 'Web',Subject = 'Event Booking', Description = 'Book One Spot for Company A1', AccountId = a1.ID);

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
        
        Account a1 = new Account(Name = 'Salesforce');
        insert a1;
        
        Contact c1 = new Contact(LastName = 'Contact 1', AccountId = a1.ID);
        insert c1;
        Contact c2 = new Contact(LastName = 'Contact 2', AccountId = a1.ID);
        insert c2;
        Contact c3 = new Contact(LastName = 'Contact 3', AccountId = a1.ID);
        insert c3;
        Case request = new Case(Origin = 'Web',Subject = 'Event Booking', Description = 'Book Spots for Company A1 & their 3 employees', AccountId = a1.ID);
        
        // When 

        Test.startTest();
        Database.SaveResult result = Database.insert(request, false);
        Test.stopTest();

        // Then

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Web request are only allowed to have one attendee', result.getErrors()[0].getMessage());

            
    } 

    @isTest
    public static void confirmRegisterContactsWhenCaseIsClosedSuccess() {

        // Given     
        Test.setMock(HttpCalloutMock.class, new RegistrationCalloutMock(201));
        Account a1 = new Account(Name = 'Salesforce');
        insert a1;
        Contact c1 = new Contact(LastName = 'Contact 1', AccountId = a1.ID, Email = 'test1@test.com');
        insert c1;
        Case request = new Case(Origin = 'Phone',Subject = 'Event Booking', Description = 'simple description', AccountId = a1.ID);
        insert request;

        // when
        Test.startTest();
        request.Status = 'closed';
        update request;
        Test.stopTest();

        List<Log__c> logs = [SELECT Message__c FROM Log__c];

        String msg = logs[0].message__c;

        // then
        System.assertEquals('notify success ; ()', msg);
    }

    @isTest
    public static void confirmRegisterContactsWhenCaseIsClosedFail() {

        // Given     
        Test.setMock(HttpCalloutMock.class, new RegistrationCalloutMock(500));
        Account a1 = new Account(Name = 'Salesforce');
        insert a1;
        Contact c1 = new Contact(LastName = 'Contact 1', AccountId = a1.ID, Email = 'test1@test.com');
        insert c1;
        Case request = new Case(Origin = 'Phone',Subject = 'Event Booking', Description = 'simple description', AccountId = a1.ID);
        insert request;

        // when
        Test.startTest();
        request.Status = 'closed';
        update request;
        Test.stopTest();

        List<Log__c> logs = [SELECT Message__c FROM Log__c];

        String msg = logs[0].message__c;

        // then
        System.assertEquals('The status code returned was not expected: 500 ; ()', msg);
    }
    

}
