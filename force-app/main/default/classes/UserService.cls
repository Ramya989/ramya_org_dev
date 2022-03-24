public with sharing class UserService {
    //static variables declarations should be final
    private static final SObjectType ACCOUNT_TYPE = Account.getSObjectType();
    
	public static List<User> getUsers(final Boolean isActive) {
        /* 
         * Check Logged in user have enough permission to read getUsers() method
         * If needed do neccessary customizations go with Private Methods
         * Do not reinvent the wheel. Check to see if someone has already implemented same or all of your code and reuse.
         * **AVOID** dynamic SOQL unless absolutely necessary.
         * 
         */
        //Schema 
        //getAccount
       return Database.Query('SELECT Id FROM User WHERE IsActive =: isActive');
    }
    
    /*
     * 
    Methods should do one thing and one thing only. If it is doing two things, it should be broken into two methods

    private static type properMethodName(){
        
        return type;
    }
    *
    */

    
    /*
     * | Bad Naming | Good Naming |
        | --- | ---- |
        | `reSpaceListController` | `ListController` |
        | `mySourceId` | `sourceId` |
        | `theEnvelope` | `envelope` |
        | `isSetFlag` | `isSet` |
        | `templatte` | `template` |
        | `SomeTYPe` | `SomeType` |
        | `SomeProperty` | `someProperty` |
        | `someConstant` | `SOME_CONSTANT` |
	*/
}