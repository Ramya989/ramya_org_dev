({
    click : function(cmp, event, helper) {
        var childCmp = cmp.find("childComponent");
        cmp.set('v.add',cmp.get('v.add')+1);
        childCmp.sampleMethod(cmp.get('v.add'));
    },
    parentAction : function(cmp, event, helper) {
       cmp.set('v.aura_action',cmp.get('v.aura_action')+1);
    }
})