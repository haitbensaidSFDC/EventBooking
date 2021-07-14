public  class ExternalSystemService {

    private String webServiceURL;

    public ExternalSystemService(){
        this.webServiceURL = 'https://th-apex-http-callout.herokuapp.com/animals';
    }

    public void registerAttendees(Case r){
            for(Account a : [SELECT id FROM Account where id = :r.AccountId]){
                for(Contact c : [SELECT id,name, email FROM Contact where accountid =: a.id ]){
                    Http http = new Http();
                    HttpRequest request = new HttpRequest();
                    request.setEndpoint(this.webServiceURL);
                    request.setMethod('POST');
                    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    // Set the body as a JSON object
                    request.setBody('{"name":"'+ c.name + '-' + c.email  +'}');
                    HttpResponse response = http.send(request);
                    // Parse the JSON response
                    if (response.getStatusCode() != 201) {
                        System.debug('The status code returned was not expected: ' +
                            response.getStatusCode() + ' ' + response.getStatus());
                    } else {
                       // Everything went as expected.
                       notifyAttendeeByEmail(c);
                    }
                }
            
        }
    } 

    public void notifyAttendeeByEmail(Contact account){
      
        Task tk = new Task();
        tk.Subject = 'Send Email To' + account.name;
        tk.Status = 'Open';
        tk.Priority = 'Normal';
        tk.WhatId = account.ID;
        insert tk;
    } 


}
