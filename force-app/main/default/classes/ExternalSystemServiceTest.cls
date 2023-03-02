@isTest
public with sharing class ExternalSystemServiceTest {
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
        ExternalSystemService.registerAttendees(request.Id);
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
        ExternalSystemService.registerAttendees(request.Id);
        Test.stopTest();

        List<Log__c> logs = [SELECT Message__c FROM Log__c];

        String msg = logs[0].message__c;

        // then
        System.assertEquals('The status code returned was not expected: 500 ; ()', msg);
    }
    
}