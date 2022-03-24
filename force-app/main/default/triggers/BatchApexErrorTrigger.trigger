trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {

    List<BatchLeadConvertErrors__c> batchErrorList=new List<BatchLeadConvertErrors__c>();

    for(BatchApexErrorEvent error :Trigger.new){

        batchErrorList.add(new BatchLeadConvertErrors__c(

            AsyncApexJobId__c=error.AsyncApexJobId,

            Records__c=error.JobScope,

            StackTrace__c=error.StackTrace

        ));

    }

    insert batchErrorList;

}