public with sharing class customvftolwcController {
    @AuraEnabled(Cacheable = true)
    public static map<String,String> getAccountDetails(final Id accId) {
        map<String,String> accountDetails = new map<String,String>();
        if(accId != null){
            List<Account> accountList = [select id,name from Account where id =: accId];
            accountDetails.put(accountList[0].Id, accountList[0].name);
        }
        return accountDetails;
    }
    @AuraEnabled(Cacheable = true)
    public static string updateAcc(final Id accId, final string accName){
        Account accountupd = new Account();
        accountupd.id = accId;
        accountupd.name = accName;
        update accountupd;
        return 'success';
    }
}