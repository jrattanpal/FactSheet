public with sharing class FactSheetManager {

    //Get Field info ONLY
    @AuraEnabled
    public static String getSObjectFields(String sObjectAPIName){
        return getSObjectInfo(sObjectAPIName, false, true);
    }
    
    //Get Field and Child Object info
    @AuraEnabled
    public static String getSObjectChildObjects(String sObjectAPIName){
        return getSObjectInfo(sObjectAPIName, true, false);
    }
        
    //Fetch Child Objects and Fields for the specified Object
    //@Return JSON string
    @AuraEnabled
    public static String getSObjectInfo(String sObjectAPIName, Boolean getChildObjects, Boolean getFields){
        Map<String, Object> retVal = new Map<String, Object>();
        try{
            if(getChildObjects){
	        	retVal.put('childObjects', sObjectUtils.getChildObjects(sObjectAPIName));
            }
            if(getFields){
	        	retVal.put('fields', sObjectUtils.getSObjectFields(sObjectAPIName));
            }
        }catch(CustomException.sObjectTypeUndefinedException e){
            //throw new AuraHandledException(sObjectAPIName + ' does not exist.');
        }catch(CustomException.sObjectNotAccessibleException e){
            //throw new AuraHandledException(sObjectAPIName + ' is not accessible.');
        }catch(Exception e){
            //throw new AuraHandledException('Exception: ' +e.getMessage());
        }
        return JSON.serialize(retVal);
    }
    
}