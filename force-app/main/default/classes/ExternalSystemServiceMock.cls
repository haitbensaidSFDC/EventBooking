/**
 * @description       :
 * @author            : melbazi@salesforce.com
 * @group             :
 * @last modified on  : 28-03-2022
 * @last modified by  : melbazi@salesforce.com
 **/
@isTest
global with sharing class ExternalSystemServiceMock implements HttpCalloutMock {
  // Implement this interface method
  global HTTPResponse respond(HTTPRequest request) {
    // Create a fake response
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json');
    response.setBody(
      '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}'
    );
    response.setStatusCode(201);
    return response;
  }
}
