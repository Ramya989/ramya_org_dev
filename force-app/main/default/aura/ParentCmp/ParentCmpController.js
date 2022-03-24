({
     callAuraMethod : function(component, event, helper) {
            var childCmp = component.find("childComponent");
            var retnMsg = childCmp.GetMessageFromChildMethod('parentName','parentName2');
            component.set("v.message", retnMsg);
     }
})