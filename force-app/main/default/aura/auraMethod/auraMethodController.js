/* auraMethodController.js */
({
    echo : function(cmp, event) {
        var params = event.getParam('arguments');
        var callback;
     
        if (params) {
            callback = params.callback;
        }
        var action = cmp.get("c.serverEcho");
        action.setParams({
                setValue: false
              });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + response.getReturnValue());
                cmp.set('v.getFirstNameResult', response.getReturnValue());
                response.getReturnValue().foreach(function (f) {
                    if (callback)
                     callback(response.getReturnValue());
                });
            }
        });
        $A.enqueueAction(action);
    },
    
    
    doinit:function(component, event,helper) {
        var someAction = component.get('c.serverEcho');
        var accAction = component.get("c.serverEcho");
        var params={"setValue":false};
        accAction.setParams(params);
        
        var accountPromise = helper.executeAction(component, accAction);
        accountPromise.then(
        $A.getCallback(function(result){
            // We have the account - set the attribute
           var params1={"setValue":true};
        accAction.setParams(params1);
        var accountPromise1 = helper.executeAction(component, accAction);
        }),
        $A.getCallback(function(error){
            // Something went wrong
            alert('An error occurred getting the account : ' + error.message);
        })
     );
    }
})