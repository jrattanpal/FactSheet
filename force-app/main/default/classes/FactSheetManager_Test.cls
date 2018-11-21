@isTest
private class FactSheetManager_Test {
    @isTest
    private static void getSObjectInfo_negative(){
        Boolean flag = false;
        
        try{
        	String data = FactSheetManager.getSObjectInfo('ObjectDoesntExist', true, false);
        }catch(CustomException.sObjectTypeUndefinedException e){
        }
        System.assertEquals(false, flag);
    }
	@isTest
    private static void getSObjectInfo_positive(){
        //Test for Child Objects
        String data = FactSheetManager.getSObjectInfo('Account', true, false);
        Map <String, Object> convertedData = (Map <String, Object>)JSON.deserializeUntyped(data);

        Map <String, Object> childObjects = (Map<String, Object>)JSON.deserializeUntyped((String)convertedData.get('childObjects'));
        System.assertEquals(true, childObjects.containsKey('Contact'));        
        System.assertEquals(false, childObjects.containsKey('ObjectDoesntExist'));
        
        
        //Test for fields
        data = FactSheetManager.getSObjectInfo('Account', false, true);
        convertedData = (Map <String, Object>)JSON.deserializeUntyped(data);

        Map <String, Object> fields = (Map<String, Object>)JSON.deserializeUntyped((String)convertedData.get('fields'));
        System.assertEquals(true, fields.containsKey('Name'));        
        System.assertEquals(false, fields.containsKey('Contact'));
    }
    
    @isTest
    private static void getSObjectChildObjects_negative(){
        Boolean flag = false;
        
        try{
        	String data = FactSheetManager.getSObjectChildObjects('ObjectDoesntExist');
        }catch(CustomException.sObjectTypeUndefinedException e){
        }
        System.assertEquals(false, flag);
    }
	@isTest
    private static void getSObjectChildObjects_positive(){
        String data = FactSheetManager.getSObjectChildObjects('Account');
        Map <String, Object> convertedData = (Map <String, Object>)JSON.deserializeUntyped(data);
        //Test for Child Objects
        Map <String, Object> childObjects = (Map<String, Object>)JSON.deserializeUntyped((String)convertedData.get('childObjects'));
        System.assertEquals(true, childObjects.containsKey('Contact'));        
        System.assertEquals(false, childObjects.containsKey('ObjectDoesntExist'));
    }
     @isTest
    private static void getSObjectFields_negative(){
        Boolean flag = false;
        
        try{
        	String data = FactSheetManager.getSObjectFields('ObjectDoesntExist');
        }catch(CustomException.sObjectTypeUndefinedException e){
        }
        System.assertEquals(false, flag);
    }
    
    @isTest
    private static void getSObjectFields_positive(){
        String data = FactSheetManager.getSObjectFields('Account');
        Map <String, Object> convertedData = (Map <String, Object>)JSON.deserializeUntyped(data);
        //Test for fields
        Map <String, Object> fields = (Map<String, Object>)JSON.deserializeUntyped((String)convertedData.get('fields'));
        System.assertEquals(true, fields.containsKey('Name'));        
        System.assertEquals(false, fields.containsKey('Contact'));
        
    }
	/**/
}