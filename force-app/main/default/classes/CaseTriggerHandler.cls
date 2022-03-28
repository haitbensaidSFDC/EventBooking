/**
 * @description       : A handler for case trigger
 * @author            : melbazi@salesforce.com
 * @group             :
 * @last modified on  : 28-03-2022
 * @last modified by  : melbazi@salesforce.com
 **/
public with sharing class CaseTriggerHandler extends TriggerHandler {
  public override void beforeInsert() {
    List<Case> objects = (List<Case>) Trigger.new;
    Case request = objects[0];

    // Testing if the content of case is null or not to avoid NPE ;)
    if (request == null || request.AccountId == null) {
      request.addError(
        'You cannot create a request without attaching an account'
      );
      Log.error('Case is null or doesn\'t contains an account attached');
      return;
    }

    Account account = [
      SELECT ID, (SELECT ID FROM contacts)
      FROM Account
      WHERE ID = :request.AccountId
      LIMIT 1
    ];

    Integer contactsSize = account.Contacts.size();

    if (contactsSize == 0) {
      request.addError(
        'You cannot create a request for accounts without contacts'
      );
      return;
    }

    switch on request.Origin.toUppercase() {
      when 'Web' {
        if (contactsSize >= 2) {
          request.addError('Web request are only allowed to have one attendee');
        }
      }
      when 'Phone' {
        if (contactsSize >= 4) {
          request.addError(
            'Phone request are only allowed to have three attendee'
          );
        }
      }
    }
  }

  public override void afterUpdate() {
    Case firstRequest = (Case) Trigger.new[0];

    Case request = [
      SELECT AccountId, Status
      FROM Case
      WHERE id = :firstRequest.ID
    ];
    if (request.Status == 'Closed') {
      ExternalSystemService.registerAttendees(request.Id);
    }
  }
}
