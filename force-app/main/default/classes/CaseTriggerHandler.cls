public with sharing class CaseTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        Log.error(((List<Case>) Trigger.new).toString());
        CaseService.validateReservationCases((List<Case>) Trigger.new);
        
    }

    public override void afterUpdate() {

        Case request = (Case) Trigger.new[0];

        Case r = [SELECT Status FROM Case where id=:request.ID];

        if(r.Status == 'Closed'){
            ExternalSystemService.registerAttendees(r.Id);
        }
    }
}
