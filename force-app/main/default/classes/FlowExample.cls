public class FlowExample {
    public static void test(){
         Map<String, String> params = new Map<String, String>();
        params.put('Oppty_Identifier','test flow');
        params.put('Close_Date',String.valueOf(System.today()));
        params.put('Account',Id.valueOf('0016F00003bAcaDQAS'));
        Flow.Interview.New_oppty myflow = new Flow.Interview.New_oppty(params);
         myflow.start();
    }
}