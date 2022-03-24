({
	doAction : function(cmp, event) {
        var params = event.getParam('arguments');
        if (params) {
          
          cmp.set('v.add',params.param);
        }
        return "";
    }
})