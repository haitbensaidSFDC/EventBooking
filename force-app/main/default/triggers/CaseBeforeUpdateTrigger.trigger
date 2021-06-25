trigger CaseBeforeUpdateTrigger on Case (before update) {

    Boolean requestSentToExternalSystem = false;
    Integer i=0;
    
    Case request = Trigger.new[0];

    Case r = [SELECT Status FROM Case where id=:request.ID ];
    if(r.Status == 'Closed'){
        // we wait for sometime until we get the response 5000 sounds good for now ... if we get some complains we can increase it to 10000 
        while(true){
            if(requestSentToExternalSystem && ExternalSystemService.isResponseReceived){
                System.debug('Request Sent to the external system ');
                break;
            } else if(!requestSentToExternalSystem) {
                ExternalSystemService service = new ExternalSystemService();
                service.sendValidationRequest(request);
                
                requestSentToExternalSystem = true;
            }else if (i == 5000){
                break;
            }
            i++;
        }
    }
}