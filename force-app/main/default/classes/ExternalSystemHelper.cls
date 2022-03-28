/**
 * @description       :
 * @author            : melbazi@salesforce.com
 * @group             :
 * @last modified on  : 28-03-2022
 * @last modified by  : melbazi@salesforce.com
 **/
public with sharing class ExternalSystemHelper {
  public static HttpRequest buildRegisterRequest(String url, Contact attendee) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(url);
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json;charset=UTF-8');

    // Set the body as a JSON object
    request.setBody('{"name":"' + attendee.name + '-' + attendee.email + '}');

    return request;
  }
}
