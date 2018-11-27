({
    getFields : function(cmp) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        var action = cmp.get("c.getSObjectFields");
        action.setParams({ sObjectAPIName : cmp.get("v.obj") });

        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = JSON.parse(response.getReturnValue());
                //Get field list
                var fields = JSON.parse(data.fields);
                var objFieldList = Array();
                
                for (var i = 0; i < fields.length; i++){
                    objFieldList.push({ id: fields[i].Name, label: fields[i].Label })
                    
                }                
                cmp.set('v.objFieldList', objFieldList);
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });

        // optionally set storable, abortable, background flag here

        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    }
})