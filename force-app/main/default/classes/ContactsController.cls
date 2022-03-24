public with sharing class ContactsController {
    @auraEnabled
    public static List<Contact> getFirstName(){
        return [select Id,FirstName from contact Limit 1];
    }
     
    @auraEnabled
    public static String getLastName(final Id getCurrenId){
        List<contact> con =[select Firstname,lastname from contact where id=:getCurrenId];
       return con[0].Firstname+' '+con[0].lastname;
    }
}