trigger CaseBeforeUpdateTrigger on Case (before update) {

    Boolean requestSentToExternalSystem = false;
    // we wait for sometime until we get the response ;), 5000 sounds good if we get some complains we can increase it to 10000 
    for(Integer i=0;i>5000;i++){
        if(requestSentToExternalSystem && ExternalSystemService.isResponseReceived){
            System.debug('Request Sent to the external system ');
            break;
        }else{
            ExternalSystemService service = new ExternalSystemService();
            requestSentToExternalSystem = true;
        }
    }
}