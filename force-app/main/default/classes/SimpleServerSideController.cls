public with sharing class SimpleServerSideController {
    @AuraEnabled
    public static List<String> serverEcho(Boolean setValue) {
        List<String> str=new List<String>();
        for(contact con:[select FirstName,LastName from Contact limit 100]){
            if(setValue) { str.add(con.FirstName);}
            else {str.add(con.LastName);}
        }   
        return str;
    }
}