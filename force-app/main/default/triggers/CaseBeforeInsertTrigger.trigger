trigger CaseBeforeInsertTrigger on Case (before insert) {
    // WE GET THE CASE FIRST 
    Case r = Trigger.new[0];
    
    // Testing if the content of case is null or not to avoid NPE ;) 
    if(r != null && r.AccountId != null){

        Account account =  [SELECT ID, (select id from contacts) FROM Account where id = :r.AccountId LIMIT 1];

        Integer s = account.Contacts.size();

        if(s ==0){
            r.addError('You cannot create a request for accounts without contacts');
        }   else {
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

    }else {
        r.addError('You cannot create a request without attaching an account');
    }

}