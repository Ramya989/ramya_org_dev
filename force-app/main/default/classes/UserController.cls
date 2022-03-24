/**
 * Description for class
 */
public with sharing class UserController extends Controller {

	@AuraEnabled
	public static void getUsers() {
       
        Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(new String[]{'Account'});                 
           
        
       Map<String,DescribeFieldResult> listOfObjectFields=new Map<String,DescribeFieldResult>();
 
        for (SObjectField f : descResult[0].fields.getMap().values()) {
            DescribeFieldResult field = f.getDescribe();
            listOfObjectFields.put(field.getName(),field);
            //System.debug(field.getName()+'===========================');
        }
        
        
        Map<String, SObjectField> fields = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
        Boolean checkFieldsExistsonObject = false;
        if(fields.containsKey('TestFielddddd__c')) {
            System.debug('IS_AUTOMATE_INVOICE');
              
        } else { 
            System.debug('checkFieldsExistsonObject');
            //checkFieldsExistsonObject = checkFieldsExistsonObject('dfsle__GenTemplate__c', new List<String>{ IS_AUTOMATE_INVOICE, INVOICE_MAPPINGS});
        }
    }    
}