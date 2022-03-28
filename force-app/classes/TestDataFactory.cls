@IsTest
public class TestDataFactory {
    public static Account createAccountData(String accntName) {
        Account accnt = new Account(Name = accntName,   
                                    Phone = '21234567894'
                                   );
        return accnt;  
    }
    
    public static List<Contact> createConData(Id accountId,Integer nbrOfContact) {
        
        List<Contact> contacts =new List<Contact>();
        for(Integer i=0;i<nbrOfContact;i++){
            
            Contact con = new Contact(LastName = 'Fatza Lam'+i,
                                      AccountId=accountId,
                                      MobilePhone = '21234567894' ,
                                      Email='fatri.lamghari@gmail.com'
                                     );
            
            contacts.add(con);
        }
        return contacts; 
    }
    
    public static Case createCaseData(String Origin ,Id accountId) {
        Case cs = new Case(Origin = Origin,
                           Subject = 'Event Booking', 
                           Description = 'Book Spots', 
                           AccountId =accountId
                          );
        return cs;  
    }
    
    public static Case createCaseDataWithoutAccount() {
        Case cs = new Case(Origin = 'Phone',
                           Subject = 'Event Booking', 
                           Description = 'Book Spots',
                           Status='New'
                          );
        return cs;  
    }
    
    
}