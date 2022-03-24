public with sharing  class ContactRolehandler {
    
    public void OnBeforeUpdate(Lead[] oldLeads,Map<ID, Lead> OldLeadsMap, Lead[] LeadsToUpd, Map<ID, Lead> LeadMap)
    {
        System.debug('LeadsToUpd'); System.debug(LeadsToUpd);
        for(lead ld : LeadsToUpd){
            if(ld.IsConverted == true){
                
              opportunity opp =[select id,contact__c from opportunity where id =: ld.ConvertedOpportunityId];
                
              
                opp.contact__c = ld.ConvertedContactId;
                
                update opp;
            }
            
            
            
        }
    }
}