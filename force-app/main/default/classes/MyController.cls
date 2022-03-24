public class MyController {
    
    
    public String mylabel{get; set;}
    
    
    
    public   MyController()
        
    {
        
        mylabel = 'data';   // provide custom label name as you have, in my case it is Test_Label
        
      //  Component.Apex.OutputText output = new Component.Apex.OutputText();
//        output.expressions.value = '{!$Label.'+ myLabel + '}';
//        System.debug(output.value);
       	//mylabel = String.valueOf(output.value );
        
    }
}