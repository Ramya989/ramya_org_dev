({
    getToggleValueForBHApproval:function(component,event,helper){
        var checkCmp = component.find("BHapprovalId").get("v.checked");
        component.set("v.BHApprovalStatus",checkCmp);
        if(checkCmp == false){
           component.set("v.accountSubDispositionValue", null);
        } component.set("v.displayReadOnly",true); 
        
    },
    getChecklistDoc:function(component,event,helper){
        var checkCmp =component.find("accountSubDispositionType") == undefined ? '' : component.find("accountSubDispositionType").get("v.value");
        //  var checkCmp1 = component.find("BHapprovalId").get("v.checked");
        //component.set("v.accountSubDispositionValue", 'Resolved');
        //alert(component.find("accountSubDispositionType").get("v.value"))
        alert(component.get("v.accountSubDispositionValue"));
        
        
        /*component.set("v.BHapprovalToggle",true);
        if(component.get("v.BHapprovalToggle")){
            component.set("v.BHApprovalStatus",true);
        }*/
    },
    
})