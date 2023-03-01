public with sharing class CaseTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        Case r = (Case) Trigger.new[0];
        if (r.AccountId == null) {
            r.addError('You cannot create a request without attaching an account');
            return;
        }
        Account account = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id = :r.AccountId LIMIT 1];
        if (account.Contacts.isEmpty()) {
            r.addError('You cannot create a request for accounts without contacts');
            return;
        }
        Integer numAttendees = account.Contacts.size();
        switch on r.Origin {
            when 'Web' {
                if (numAttendees > 1) {
                    r.addError('Web request are only allowed to have one attendee');
                }
            }
            when 'Phone'{
                if (numAttendees > 3) {
                    r.addError('Phone request are only allowed to have three attendee');
                }
            }
            when else {
                // handle other origin values if needed
            }
        }
    }

    public override void afterUpdate() {

        Case request = (Case) Trigger.new[0];

        Case r = [SELECT Status FROM Case where id=:request.ID];

        if(r.Status == 'Closed'){
            ExternalSystemService.registerAttendees(r.Id);
        }
    }
}
