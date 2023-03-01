public with sharing class CaseTriggerHandler extends TriggerHandler {

    List<Case> cases;

    public CaseTriggerHandler() {
        cases = (List<Case>) Trigger.new;
    }

    public override void beforeInsert() {
        CaseService.validateCases(cases);
    }

    public override void afterUpdate() {
        CaseService.manageRegestrations(cases);
    }
}
