trigger CaseTrigger on Case (before insert, before update) {
    new CaseTriggerHandler().run();
}