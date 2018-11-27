global class FactSheetListPicklist extends VisualEditor.DynamicPickList{
    VisualEditor.DesignTimePageContext context;
    List<FactSheet__c> factSheetList = new List<FactSheet__c>();
    
    global FactSheetListPicklist(VisualEditor.DesignTimePageContext context) {
        this.context = context;
        if (context.pageType == 'RecordPage') {
       	 	factSheetList = FactSheetData.getFactSheetListByObject(context.entityName);
        }
    }
    
    global override VisualEditor.DataRow getDefaultValue(){
        System.debug('factSheetList 1: ' + factSheetList);
        VisualEditor.DataRow defaultValue;
        if((context.pageType == 'RecordPage' || context.pageType == 'AppPage') && factSheetList.size() > 0){
	        defaultValue = new VisualEditor.DataRow(factSheetList[0].Name, (String)factSheetList[0].Id);
        }
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        System.debug('factSheetList 2: ' + factSheetList);
        VisualEditor.DynamicPickListRows myValues = new VisualEditor.DynamicPickListRows();
        if ((context.pageType == 'RecordPage' || context.pageType == 'AppPage')) {
       	 	for(FactSheet__c factSheet: factSheetList){
                VisualEditor.DataRow value = new VisualEditor.DataRow(factSheet.Name, (String)factSheet.Id);
                myValues.addRow(value);
            }
        	System.debug('myValues:'+myValues);
        }
        
        return myValues;
    }
}