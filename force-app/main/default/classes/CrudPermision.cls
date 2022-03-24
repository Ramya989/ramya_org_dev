public virtual with sharing class CrudPermision { 
    //define org namespace without __    
    Private static final String ORGNAMESPACE = '';    
    Private static Map<String,List<String>> relatedObjects=new Map<String,List<String>>();
    public enum CRUDOperation {CREATE,MODIFY,READ,REMOVE}
    
    /*@Aim:Check object permision along with fls
    *@Param:query that needs to be cheked
    *@Return:Boolean value for permisson
    */
    public static Boolean checkPermission(String queryOrObjectName,CRUDOperation opration){ 
     //   System.debug(opration+'<queryOrObjectName '+queryOrObjectName);
        try{
            queryOrObjectName = queryOrObjectName.replaceAll('select','SELECT').replaceAll('from','FROM').replaceAll('where','WHERE');        
            queryOrObjectName = queryOrObjectName.replaceAll('Select','SELECT').replaceAll('From','FROM').replaceAll('Where','WHERE');     
            
            Map<String,List<String>> allFields = formateQuery(queryOrObjectName,opration);
          //   System.debug('allFields '+allFields);
            Boolean isAccess = true;
            for(String objectName:allFields.keySet()){
                Schema.DescribeSObjectResult objSchema = getSchema(objectName.trim()); 
              
                if(objSchema != null){         
                    if(opration == CRUDOperation.CREATE){  
                         
                        if(objSchema.isCreateable()){
                            List<String> fields = allFields.get(objectName);          
                            for(String fName:fields){                            
                                if(( objSchema.fields.getMap().containsKey(fName.trim()))){
                                    if(!((objSchema.fields.getMap().get(fName.trim())).getDescribe().isCreateable())){
                                        System.debug('Object '+objectName+' Not enough access on '+fName+' for Opration CREATE');
                                       
                                        isAccess = false;
                                        break;
                                    }
                                }
                            }                         
                        }
                        else{
                           
                            isAccess=false;
                        }
                    }
                    else if(opration == CRUDOperation.MODIFY){                    
                        if(objSchema.isUpdateable()){                        
                            List<String> fields = allFields.get(objectName);                        
                            for(String fName:fields){                            
                                if(( objSchema.fields.getMap().containsKey(fName.trim()))){
                                    if(!((objSchema.fields.getMap().get(fName.trim())).getDescribe().isUpdateable())){
                                        System.debug('Object '+objectName+' Not enough access on '+fName+' for Opration MODIFY');
                                        isAccess = false;
                                        break;
                                    }
                                }
                            }
                        }                    
                        else{                        
                            isAccess = false;                        
                        }
                    }                
                    else if(opration == CRUDOperation.READ){   System.debug('field ');      
                        if(objSchema.isAccessible()){  
                            List<String> fields = allFields.get(objectName);      System.debug('field '     );               
                            for(String fName:fields){
                               System.debug('field '+fName+' of '+objSchema.getName() );
                                for (SObjectField f : objSchema.fields.getMap().values()) {
                                    DescribeFieldResult field = f.getDescribe();
                                    //listOfObjectFields.put(field.getName(),field);
                                    System.debug(field.getName()+'===========================');
                                    
                                }
                                if((objSchema.fields.getMap().containsKey(fName.trim()))){ 
                                    if(!(objSchema.fields.getMap().get(fName.trim())).getDescribe().isAccessible()){
                                        System.debug('Object '+objectName+' Not enough access on '+fName+' for Opration READ');
                                        isAccess=false;
                                        break;
                                    }
                                }
                            }
                        }                    
                        else{           
                            isAccess=false;                        
                        }                    
                    }                
                    else if(opration == CRUDOperation.REMOVE){                    
                        if(!(objSchema.isAccessible() && objSchema.isDeletable())){
                            System.debug('Object '+objectName+' Not enough  for Opration REMOVE');                                                
                            isAccess=false;                        
                        }
                    }
                }            
            }
            relatedObjects.clear();
            return isAccess;
        }
        catch(Exception e){
          //  System.debug(e.getMessage());
           // System.debug(e.getStackTraceString());
            return true;
           
           
            
            
        }
    }
    
    //return schema of object    
    public static Schema.DescribeSObjectResult getSchema(String objectName){     
        try{
            Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(new String[]{objectName});                 
            if(descResult.size() > 0){                
                return descResult[0];                
            }
            else{
                return null;
            }            
        }        
        catch(exception e){            
            return null;            
        }        
    }    
    //returns fieldnames and its object    
    private static Map<String,List<String>> formateQuery(String query,CRUDOperation opration){        
        query =removeAggrigateFunction(query);
        Map<String,List<String>> validate=new  Map<String,List<String>>();        
        if(query.contains('FROM')){            
            Integer numberOfQuerys = query.countMatches('FROM');            
            if(numberOfQuerys == 1){                
                String ObjectName = getObjectName(query);                
                List<String> fields = getFields(query,ObjectName,opration);                
                validate.put(ObjectName.trim(),fields);
            }            
            if(numberOfQuerys == 2){                
                //finding index of inner query                
                Integer startIndex = query.indexOf('(');                
                Integer endIndex = query.indexOf(')');                
                String innerQuery = query.substring(startIndex-1, endIndex+1);                
                String orignalString = query.remove(innerQuery);                
                
                //geting inner query object name                 
                String innerQueryObjectName = getObjectName(innerQuery);
                
                // geting inner query  fields                
                List<String> innerQueryfields = getFields(innerQuery,innerQueryObjectName,opration);                
                validate.put(innerQueryObjectName.trim(),innerQueryfields);
                
                //geting object name                 
                String ObjectName = getObjectName(orignalString);
                
                // geting all fields                
                List<String> fields = getFields(orignalString,ObjectName,opration);                
                validate.put(ObjectName.trim(),fields);        
                System.debug('validate '+validate);
            }            
            if(numberOfQuerys == 3){                
                //finding index of inner query                 
                Integer startIndex = query.lastIndexOf('(');                
                Integer endIndex = query.lastIndexOf(')');                
                String innerQuery = query.substring(startIndex-1, endIndex+1);                
                String orignalString = query.remove(innerQuery);
                
                //finding index of related query                
                startIndex = query.IndexOf('(');                
                endIndex = query.IndexOf(')');                
                String realatedQuery = orignalString.substring(startIndex-1, endIndex+1);
                
                //orignal query                
                orignalString = orignalString.remove(realatedQuery);
                
                //geting object name                 
                String innerQueryObjectName = getObjectName(innerQuery);                
                List<String> innerQueryfields = getFields(innerQuery,innerQueryObjectName,opration);                
                validate.put(innerQueryObjectName.trim(),innerQueryfields);
                
                //geting object name                 
                String relatedObjectName = getObjectName(realatedQuery);                
                List<String> relatedQueryfields = getFields(realatedQuery,relatedObjectName,opration);                
                validate.put(relatedObjectName.trim(),relatedQueryfields);
                
                //geting object name                 
                String ObjectName = getObjectName(orignalString);                
                List<String> fields = getFields(orignalString,ObjectName,opration);                
                validate.put(ObjectName.trim(),fields);                
            }            
        }        
        else{
            
            validate.put(addNameSpace(query),new List<String>());            
        }        
        //cheking for related object
        if(relatedObjects.size()>0){
            for(String rObjName:relatedObjects.keySet()){
                validate.put(rObjName.trim(),relatedObjects.get(rObjName));
            }
        }
        System.debug(JSON.serializePretty(validate));
        return validate;        
    }
    
    //returns object Name from query    
    private static String getObjectName(String query){        
        String ObjectName = '';        
        
        //geting object name         
        if(query.contains('WHERE')){            
            ObjectName = query.substringBetween('FROM', 'WHERE');            
        }        
        else{            
            ObjectName = query.substringAfter('FROM');            
            List<String> temp = ObjectName.split(' ');            
            for(String s:temp){                
                if(!String.isEmpty(s)){                    
                    ObjectName=s;                        
                    break;                   
                }                
            }            
        }        
        ObjectName=ObjectName.remove('(');        
        ObjectName=ObjectName.remove(')');        
        ObjectName=addNameSpace(ObjectName); 
        return ObjectName.trim();        
    }
    
    //if org has namespace adds it to filed    
    private static String addNameSpace(String value){        
        if(!String.isEmpty(ORGNAMESPACE.trim())){            
            if(value.contains('__')){                
                List<String> parts = value.split('__');                
                if(parts.size() == 2){                    
                    value = ORGNAMESPACE.trim()+'__'+parts.get(0).trim()+'__'+parts.get(1).trim();
                }                
            }            
        }        
        return value;       
    }
    
    private static String getAggrigateFunction(String query,String functionName){
        Integer index=query.indexOfIgnoreCase(functionName+'(');
        Integer aFunctionIndex=query.indexOf(functionName+'(');
        String firstQuery=query.substring(0,aFunctionIndex);
        
        String temp=query.substring(aFunctionIndex);
        Integer firstBrac=temp.indexOf(')');
        
        String aggrigatFunction=temp.substring(0,firstBrac);
        aggrigatFunction=aggrigatFunction.substring(aggrigatFunction.indexOf('(')+1);
        
        String lastQuery=temp.substring(temp.indexOf(')')+1);
        String q=firstQuery+aggrigatFunction+lastQuery;
        
        if(q.contains(functionName+'(')){
            return getAggrigateFunction(q,functionName);
        }
        
        return q;
    }
    
    //remove aggrigate function from query
    private static String removeAggrigateFunction(String query){
        
        if(query.contains('format(')){
            query=getAggrigateFunction(query,'format');    
        }
        if(query.contains('count(')){
            query=getAggrigateFunction(query,'count');    
        }
        if(query.contains('sum(')){
            query=getAggrigateFunction(query,'sum');    
        }
        if(query.contains('avg(')){
            query=getAggrigateFunction(query,'avg');    
        }
        if(query.contains('max(')){
            query=getAggrigateFunction(query,'max');    
        }
        
        /*query=query.replaceAll('( ', '(');
      query=query.replaceAll(' )', ')');*/
        
        
        
        return query;
    }
    
    //returns list of fields form select part of query    
    private static List<String> getFields(String query,String objectName,CRUDOperation opration){        
        // geting all fields        
        String filedsString = query.substringBetween('SELECT', 'FROM');        
        List<String> filds = filedsString.split(',');        
        List<String> temp = new List<String>();        
        for(String f:filds){
            //ignoring relation ship fields as we dont know there parent object            
            if(!f.contains('.') && !String.isEmpty(f) && !f.contains('__s')){                
                
                temp.add(addNameSpace(f.trim()));                
            }
            else{
                if(f.contains('.') && opration==CRUDOperation.READ){
                    String relatedObj=checkRefrence(objectName,f);
                    if(relatedObj!=null){
                        String field=f.split('\\.')[1];
                        if(relatedObjects.get(relatedObj)!=null){
                            relatedObjects.get(relatedObj).add(addNameSpace(field));
                        }
                        else{
                            relatedObjects.put(relatedObj,new List<String>{addNameSpace(field)});
                        }
                    }
                }
            }            
        } 
        return temp;      
    }

    private static string checkRefrence(String objName,String fieldName){
        if(fieldName.contains('.')){
            Schema.DescribeSObjectResult[] parentObjectSchema = Schema.describeSObjects(new String[]{objName});                 
            if(parentObjectSchema.size()>0){
                List<String> objFild=fieldName.split('\\.');
                if(objFild[0].contains('__r')){
                    objFild[0]=objFild[0].substringBeforeLast('__')+'__c';
                }
                else if(!objFild[0].contains('__r')){
                    objFild[0]=objFild[0]+'Id';
                }
                if(parentObjectSchema[0].fields.getMap().containsKey(addNameSpace(objFild.get(0)))){
                    Schema.SObjectType[] reference =parentObjectSchema[0].fields.getMap().get(addNameSpace(objFild.get(0))).getDescribe().getReferenceTo();
                    if(reference.size()>0){
                        return reference[0].getDescribe().getName();
                    }
                }
            }
            
        }
        return null;
    }
    

}