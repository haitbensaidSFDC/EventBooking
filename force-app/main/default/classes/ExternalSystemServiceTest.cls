/**
 * @description       :
 * @author            : melbazi@salesforce.com
 * @group             :
 * @last modified on  : 28-03-2022
 * @last modified by  : melbazi@salesforce.com
 **/
@isTest
global with sharing class ExternalSystemServiceTest {
  @isTest
  static void testRegisterAttendees() {
    // Set mock callout class
    Test.setMock(HttpCalloutMock.class, new ExternalSystemServiceMock());
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock.

    Test.startTest();
    Case request = new Case();
    insert request;

    ExternalSystemService.registerAttendees(request.Id);
    Test.stopTest();

    List<Log__c> logs = [SELECT Message__c FROM Log__c];
    System.assertEquals(1, logs.size());
    System.assertEquals('success', logs[0].Message__c);
  }
}
