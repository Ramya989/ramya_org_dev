public class OpportunityContactRole {
    
@InvocableMethod
public static void opportunityContactRoleMethod(List<opportunity> id) {
   
   String a = id[0].id;
    opportunity opp = new opportunity();
   
    System.debug(a);
    opp = [select id,name,Contact__c,(select contactId from OpportunityContactRoles) from Opportunity where id =: a];
       System.debug(opp);
    if(opp.OpportunityContactRoles[0].contactId != null){
        System.debug('opp123===<'+opp);
        opp.Contact__c = opp.OpportunityContactRoles[0].contactId;
        update opp;
        System.debug('opp===<'+opp);
    }   
    System.debug('opp===<'+opp);
  
}
}