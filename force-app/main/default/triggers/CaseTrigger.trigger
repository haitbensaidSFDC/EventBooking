trigger CaseTrigger on Case(before insert, after update) {
    new CaseTriggerHandler().run();
}