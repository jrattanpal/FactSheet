@istest
private class sObjectUtils_Test {
    @isTest
    private static void getSObjectFields_positive(){
        String data = sObjectUtils.getSObjectFields('Account');
        
        Map <String, Object> convertedData = (Map <String, Object>)JSON.deserializeUntyped(data);
        
        System.assertEquals(true, convertedData.containsKey('Name'));
        System.assertEquals(false, convertedData.containsKey('WrongFieldName'));
    }
    @isTest
    private static void getSObjectFields_negative(){
        Boolean flag = false;
        
        try{
            String data = sObjectUtils.getSObjectFields('ObjectDoesntExist');
        }catch(CustomException.sObjectTypeUndefinedException e){
        }
        System.assertEquals(false, flag);
    }
    
    @isTest
    private static void getChildObjects_positive(){
        String data = sObjectUtils.getChildObjects('Account');
        
        Map <String, Object> convertedData = (Map <String, Object>)JSON.deserializeUntyped(data);
        
        System.assertEquals(true, convertedData.containsKey('Contact'));
        System.assertEquals(false, convertedData.containsKey('ObjectDoesntExist'));
    }
    @isTest
    private static void getChildObjects_negative(){
        Boolean flag = false;
        
        try{
            String data = sObjectUtils.getChildObjects('ObjectDoesntExist');
            
        }catch(CustomException.sObjectTypeUndefinedException e){
        }
        System.assertEquals(false, flag);
    }
    @isTest
    private static void getSObjectType_positive(){
        Schema.SObjectType targetType = sObjectUtils.getSObjectType('Account');
        Schema.DescribeSObjectResult descResult= targetType.getDescribe();
        
        System.assertEquals('Account', descResult.getName());
    }
    @isTest
    private static void newSObject_positive(){
        Boolean flag = false;
        try{
            sObject a = sObjectUtils.newSObject('Account');
            System.assertEquals(false, a instanceof Contact);
            System.assertEquals(true, a instanceof Account);
            flag = true;
        }catch(CustomException.sObjectTypeUndefinedException e){
        }
        System.assertEquals(true, flag);
    }
    @isTest
    private static void newSObject_negative(){
        Boolean flag = false;
        try{
            sObject a = sObjectUtils.newSObject('AccountWrongObject');
            flag = true;
        }catch(CustomException.sObjectTypeUndefinedException e){
        }
        System.assertEquals(false, flag);
        
    }
    /**/
}