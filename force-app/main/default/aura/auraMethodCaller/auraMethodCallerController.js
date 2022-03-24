/* auraMethodCallerController.js */
({    
    callAuraMethodServerTrip : function(component, event, helper) {
        var childCmp = component.find("child");
        // call the aura:method in the child component
        childCmp.echo(function(result) {
            var action = component.get("c.serverEcho");
            action.setParams({
                setValue: true
            });
            action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                 console.log("callback for aura:method was executed");
                 console.log("result: " + response.getReturnValue());
                var s=result; var e=response.getReturnValue(); var a=[];
                for(var i=0;i <s.length;i++){
                    for(var j=0;j<e.length;j++){
                        if(i==j){
                            a.push(s[i]+'==='+e[j])
                        }
                        
                    }       
                }component.set('v.GgetFirstNameResult',a);
            }
            }); 
            $A.enqueueAction(action);
           
           
          
        });
    },
})