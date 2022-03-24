public virtual with sharing class Controller {
    
    public static AuraHandledException wrapException(final String message) {
        //If needed classify the Exception message 
        AuraHandledException ex = new AuraHandledException(message);
        ex.setMessage(message);
        return ex;
        
        /*ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
        conVer.PathOnClient = 'ionicLogo.png'; // The files name, extension is very important here which will help the file in preview.
        conVer.Title = 'Proposal '; // Display name of the files
        conVer.VersionData = EncodingUtil.base64Decode(yourFiles); // converting your binary string to Blog
       
        insert conVer;
       
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [select ContentDocumentId from ContentVersion where Id =: conVer.Id ].ContentDocumentId;
        cdl.LinkedEntityId = art.Id;
        cdl.ShareType = 'V';
        insert cdl;*/
    }
    
}