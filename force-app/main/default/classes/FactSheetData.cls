public with sharing class FactSheetData {

    public static List<FactSheet__c> getFactSheetListByObject(String sObjectName){
        List<FactSheet__c> factSheetList = [select id, name  from FactSheet__c where Object__c=:sObjectName];
        
        return factSheetList;
    }
    
    //Get List of FactSheets
    public static List<FactSheet__c> getFactSheetListById(id factSheetId){
        return [select id, name, Object__c, Fields__c, Where__c,  (select id, name, Fields__c, Object__c, Where__c, RelationshipName__c  from FactSheets__r) from FactSheet__c where Id=:factSheetId];
    }
    
    //Generate SOQL List
    public static String genSoql(List<FactSheet__c> factSheetList, id mainRecordId){
        List<String> soqlList = new List<String>();
        String soql = '';
        for(FactSheet__c factSheet: factSheetList){
            //select for main object
            soql = ' SELECT ' + String.escapeSingleQuotes(factSheet.Fields__c);
            for(FactSheet__c factSheetChild: factSheet.FactSheets__r){
                //select for nested query
                soql += ',(SELECT ' + String.escapeSingleQuotes(factSheetChild.Fields__c) + 
                    ' FROM ' + String.escapeSingleQuotes(factSheetChild.RelationshipName__c);
                if(null !=factSheet.Where__c) {
                    soql += ' WHERE ' + String.escapeSingleQuotes(factSheetChild.Where__c);
                }
                soql += ') ';
                //soqlList.add(createSoql(factSheetChild.Fields__c,factSheetChild.Object__c, factSheetChild.Where__c));
            }
            //From and where for main object
            soql += ' FROM ' + String.escapeSingleQuotes(factSheet.Object__c) + 
					' WHERE ID=:mainRecordId ';
            if(null !=factSheet.Where__c) {
                soql += ' AND (' + String.escapeSingleQuotes(factSheet.Where__c) + ' )';
            }
        }
        return soql;
    }
}