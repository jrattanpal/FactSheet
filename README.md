# SFDX  App

## Dev, Build and Test


## Resources


## Description of Files and Directories
sfdx force:org:create -f config/project-scratch-def.json -s -d 30
sfdx force:source:push
sfdx force:package:install --package 04t80000000jZjl
sfdx force:org:open


{
    "object":"Account",
    "fields":{"Name","Type"},
    "layout":"fieldset",
    "childObjects":
        [
            "Custom_Object__c":
            {
                "object": "Custom_Object__c",
                "fields":{"Name","Account__c"},
                "parentField":"Account__c",
                "layout":"datatable"
            }            
        ]
}
## Issues


