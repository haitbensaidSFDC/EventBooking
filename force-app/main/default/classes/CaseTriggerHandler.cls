public with sharing class CaseTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        // we get the case first
        Case r = (Case) Trigger.new[0];
        
        // Testing if the content of case is null or not to avoid NPE ;) 
        if(r != null && r.AccountId != null){

            Account account =  [SELECT ID, (select id from contacts) FROM Account where id = :r.AccountId LIMIT 1];

            Integer s = account.Contacts.size();

            if(s ==0){
                r.addError('You cannot create a request for accounts without contacts');
            } else {
            switch on r.Origin {
                when 'Web' {
                    if(s >= 2 ){
                        r.addError('Web request are only allowed to have one attendee');
                    }
                }
                when 'Phone'{
                    if(s >= 4 ){
                        r.addError('Phone request are only allowed to have three attendee');
                    }
                }
            }   
        }

        } else {
            r.addError('You cannot create a request without attaching an account');
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
