public with sharing class sObjectUtils {
    
    // typeName must be a valid API name (i.e. custom objects should be suffixed with "__c"):
    public static SObjectType getSObjectType(String typeName) {
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
        
        if (targetType == null) {
            // calling code should usually handle this exception:
            throw new CustomException.sObjectTypeUndefinedException('The requested SObject type [' + typeName + '] cannot be constructed; it is not configured on this org.');
        }
        //Check if sObject is accessible
        if(!targetType.getDescribe().isAccessible()){ throw new CustomException.sObjectNotAccessibleException('The requested SObject type [' + typeName + '] is not accessible for this user.');
                                                    }        
        return targetType;
    }
    
    public static SObject newSObject(String typeName) {
        Schema.SObjectType targetType = getSObjectType(typeName);
        
        //Check if sObject is createable
        if(!targetType.getDescribe().isCreateable()){ throw new CustomException.sObjectNotCreateableException('The requested SObject type [' + typeName + '] is not createable for this user.');
                                                    }
        // SObjects offer the only way in Apex to instantiate an object with a type determined at 
        // runtime -- you can optionally pass an Id argument to instantiate an SObject for an 
        // existing record:
        return targetType.newSObject();
    }  
    
    //Return childObjects for specified object
    public static String getChildObjects(String typeName){
        Schema.SObjectType targetType = getSObjectType(typeName);
        Schema.DescribeSObjectResult R = targetType.getDescribe();
        
        Map<Schema.SObjectType, Map<String, Object>> childObjects = new Map<Schema.SObjectType, Map<String, Object>>();
        List<Schema.ChildRelationship> CList = R.getChildRelationships(); 
        for(Schema.ChildRelationship c: CList){
            //If relationship name is null then it won't work in query
            if(c.getRelationshipName() != null && c.getChildSObject().getDescribe().isAccessible()){
                Map <String, Object> objInfo = new Map<String, Object>();
                objInfo.put('field', String.valueOf(c.getField()));
                objInfo.put('relName', String.valueOf(c.getRelationshipName()));
                
                childObjects.put(c.getChildSObject(), objInfo);
            }
        }
        return JSON.serialize(childObjects);
    }
    
    //Return fields for specified object
    public static String getSObjectFields(String typeName){
        Schema.SObjectType targetType = getSObjectType(typeName);
        
        Map<String, String> fieldList = new Map<String, String>();
        
        Map <String, Schema.SObjectField> fieldMap = targetType.getDescribe().fields.getMap();
        
        for(Schema.SObjectField sfield : fieldMap.Values()){
            Schema.DescribeFieldResult dfield = sfield.getDescribe();
            if(dfield.isAccessible()){
                fieldList.put(dfield.getName(), dfield.getLabel());
            }
        }
        
        return JSON.serialize(fieldList);
    }
}