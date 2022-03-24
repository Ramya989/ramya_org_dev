({
    childSave : function(component, event, helper) {
        var inputEmail = component.find("inputEmail");
        var varEmail = inputEmail.get("v.Id");
       debugger;
        
        var action = component.get('c.getLastName');
   		 action.setParams({
            getCurrenId: component.get('v.getLastNameId')
          });

          action.setCallback(this, function (response) {
            if (response.getState() === 'SUCCESS') { debugger;
              var results = response.getReturnValue();
              component.set('v.CurrentLastName', results);
            }
          });
        //  $A.enqueueAction(action);
    }
})