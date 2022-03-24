({
	onInit : function(component, event, helper) {
		var action = component.get('c.getFirstName');
          action.setCallback(this, function (response) {
            if (response.getState() === 'SUCCESS') {
              var results = response.getReturnValue();
              component.set('v.getFirstNameResult', results); debugger;
                console.log(JSON.stringify(component.get('v.getFirstNameResult')))
            }
          });
     
          $A.enqueueAction(action);
         var childCmp = component.find("cComp");
        childCmp.sampleMethod();
      
	}
})