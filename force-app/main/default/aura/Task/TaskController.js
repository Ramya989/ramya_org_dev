({
	onInit : function(component, event, helper) {  alert(1)
		var action = component.get('c.getFirstName');
          action.setCallback(this, function (response) {
            if (response.getState() === 'SUCCESS') {
              var results = response.getReturnValue();
                component.set('v.getFirstNameResult', results); debugger;
            }
          });  $A.enqueueAction(action);
         component.set('v.showBoolean',true);
       
    
	},
    getLastname : function(component, event, helper) {
      
		var action = component.get('c.getLastName');
   		 action.setParams({
            getCurrenId: '0036F00003EpslhQAB'
          });

          action.setCallback(this, function (response) {
            if (response.getState() === 'SUCCESS') { debugger;
              var results = response.getReturnValue();
              component.set('v.getFirstNameResult',  [{'FirstName':results}]);
                                                    alert(JSON.stringify(results));
            }
          });
          $A.enqueueAction(action);
         //component.set('v.getFirstNameResult', [{'FirstName':'ramya sri'}]);
         component.set('v.showBoolean',false);
         component.set('v.isAuthorized',true);
	}
})