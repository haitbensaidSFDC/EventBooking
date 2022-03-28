/**
 * @description       :
 * @author            : melbazi@salesforce.com
 * @group             :
 * @last modified on  : 28-03-2022
 * @last modified by  : melbazi@salesforce.com
 **/
trigger CaseTrigger on Case(before insert, after update) {
  new CaseTriggerHandler().run();
}
