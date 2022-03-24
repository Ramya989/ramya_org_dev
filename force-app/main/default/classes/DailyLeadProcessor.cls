global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> lList = [SELECT Id, LeadSource
                            FROM Lead
                            WHERE LeadSource =Null];
        if(!lList.isempty()){
            for(Lead l:lList){
                l.LeadSource ='Dreamforce';
                
            }
            update lList;
            
        }
    }
}