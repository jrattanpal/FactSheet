({
    init : function(cmp, event, helper) {
        var objLayoutList = [
            { id: 1, label: 'Form' },
            { id: 2, label: 'DataTable' }
        ];

        cmp.set('v.objLayoutList', objLayoutList);

        helper.getFields(cmp);
    }
})