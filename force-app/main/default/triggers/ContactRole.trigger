trigger ContactRole on Lead ( after insert, after update,  before insert, before update) {
    System.debug('LeadsToUpd');
       ContactRolehandler handler = new ContactRolehandler();
   
           System.debug('LeadsToUpd');
           handler.OnBeforeUpdate(Trigger.old,Trigger.oldMap, Trigger.new, Trigger.newMap);
   
}