trigger DeleteAcc on Account (before delete) {
    
    //To store parent ids
    list<id> AccountIds=new list<id>();
    for(Account accountVar:trigger.old)
    {
        AccountIds.add(accountVar.id);
    }  
    //Collecting all child records related to Parent records
    list<contact> listOfContacts=[select id from Contact where accountid in :AccountIds];
    system.debug('listOfContacts'+listOfContacts);
    //deleting child records
    delete listOfContacts;
}