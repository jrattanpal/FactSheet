public class FactSheetUtils {
    public static String genFactSheetData(String factSheetId, String mainRecordId){
        List<FactSheet__c> factSheetList = FactSheetData.getFactSheetListById(factSheetId);
        String soql = FactSheetData.genSoql(factSheetList, mainRecordId);
        System.debug(soql);
        //List<List<sObject>> sObjectDataList = genData(soqlList);
        //System.debug(sObjectDataList);
        return 'test';
    }
    
    //Generate Data for each SOQL
    public static List<List<sObject>> genData(List<String> soqlList){
        List<List<sObject>> retVal = new List<List<sObject>>();
        for(String s: soqlList){
            List<sObject> data = ETLC_SecuredDB.query(s);
            retVal.add(data);
            //List<sObject> sObjectList = Database.query()
        }
        return retVal;
    }
    
    
    
    
}