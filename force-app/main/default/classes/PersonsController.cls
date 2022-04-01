public with sharing class PersonsController {
    @AuraEnabled(Cacheable = true)
    public static  List<Account>  PersonsData() {
        List<Account> acc =[select Id,name from Account limit 10];
            return acc;       
    }
}