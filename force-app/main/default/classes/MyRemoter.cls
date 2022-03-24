global with sharing class MyRemoter {
    
    public String accountName { get; set; }
    
    public static Account account { get; set; }
    
   // public AccountRemoter() {}
    
    @RemoteAction
    
    global static Account getAccount(String accountName) {
        
        account = [SELECT Id, Name, NumberOfEmployees
                   
                   FROM Account WHERE Name = :accountName];
        
        return account;
        
    }
    
}