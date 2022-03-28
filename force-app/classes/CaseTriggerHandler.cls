public class CaseTriggerHandler extends TriggerHandler { 
    private List<Case> oldCaseList;
    private List<Case> newCaseList;
    private Map<Id, Case> oldCaseMap;
    private Map<Id, Case> newCaseMap;
  
    public CaseTriggerHandler() {
        oldCaseList = (List<Case>) Trigger.old;
        newCaseList = (List<Case>) Trigger.new;
        oldCaseMap = (Map<Id, Case>) Trigger.oldMap;
        newCaseMap = (Map<Id, Case>) Trigger.newMap;
    }

    public override void beforeInsert(){
        CaseTriggerHelper.validateReservation(newCaseList);
    }
    public override void beforeUpdate(){
        CaseTriggerHelper.registerAttendees(newCaseList);    
    }
}