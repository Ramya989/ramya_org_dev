@isTest
public class DailyLeadProcessorTest {
    static testMethod void testDaily(){
        String CRON='0 0 1 * * ?';
        List<Lead> lList = new List<Lead>();
        for(Integer i=0;i<=200;i++){
            lList.add(new Lead(LastName='Dreamforce'+i,Company='dsd',Status = 'Open - Not Contacted'));
            
        } insert lList;
        Test.startTest();
        String job =	System.schedule('DailyLeadProcessor',CRON, new DailyLeadProcessor());
    }

}