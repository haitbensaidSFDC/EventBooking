public with sharing class ExternalSystemService implements Database.AllowsCallouts{
        
        @future(callout=true)
        public static void registerAttendees(Set<Id> accountIds){
            String webServiceURL = 'https://th-apex-http-callout.herokuapp.com/animals';
            List<Contact> contacts = [SELECT Id, Name, Email FROM Contact WHERE accountid IN :accountIds];
            Map<String, Object> reqBody = new Map<String, Object>();
            for(Contact contact : contacts){
                reqBody.put('name', contact.name +'-'+contact.email);
            }
            
            CalloutUtils callout = new CalloutUtils();
            callout.endPoint(webServiceURL)        	      
                    .method('POST')            
                    .addHeader('Content-Type', 'application/json;charset=UTF-8')
                    .body(JSON.serialize(reqBody))    
                    .timeout(10000);
    
            HttpResponse response = callout.send();
            // Parse the JSON response
            if (response.getStatusCode() != 201) {
                System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
                Log.error('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
            } else {
                // Everything went as expected.
                notifyAttendeeByEmail(contacts);
            }
        } 
    
        public static void notifyAttendeeByEmail(List<Contact> contacts){
            insertTask(contacts);
            sendEmail(contacts);
        } 
    
        
        public static void insertTask(List<Contact> contacts){
            List<Task> taskToCreate = new List<Task>();
            
            
            for(Contact contact : contacts)
            {
                Task task = new Task();
                task.Subject = 'Send Email To' + contact.name;
                task.Status = 'Open';
                task.Priority = 'Normal';
                task.WhatId = contact.Id;
                taskToCreate.add(task);
                
            }
            if(taskToCreate!=null && taskToCreate.size()>0)
                
                insert taskToCreate;
        }
            

        public static void sendEmail(List<Contact> contacts){
            List<String> toAddress = new List<String>();
            for(Contact contact : contacts){
                if(contact.email != null)
                    toAddress.add(contact.email);
            }
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddress);
            mail.setSenderDisplayName('Trade Show Support');
            mail.setTargetObjectId(UserInfo.getUserId());
            mail.setSubject('Reservation for the International Trade Show 2022');
            mail.setPlainTextBody('Reservation for the International Trade Show 2022');
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
          
    }