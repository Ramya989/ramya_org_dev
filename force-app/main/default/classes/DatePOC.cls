public with sharing class DatePOC {
    
     public class lineitemwrapper
    {
      @AuraEnabled public  Date startdate;
      @AuraEnabled public  String weekday;

    }
    
    public static void method(){
        
        Date startDate = date.today();
        Date endDate = date.today()+3;
        
          List<lineitemwrapper> listoflineitems  =new List<lineitemwrapper>();
         do{
            datetime dt =  DateTime.newInstance(startDate, Time.newInstance(0, 0, 0, 0));
            lineitemwrapper lm = new lineitemwrapper(); 
            lm.startdate=startDate;
            startDate = startDate.addDays(1);
            lm.weekday = dt.format('EEEE');
            listoflineitems.add(lm); 
        } while(startDate < endDate); 
       
        System.debug(listoflineitems); 
        
    }
}