package
{
	public class TestDynamicEnum
	{
		
		        	var u:User = new User("eka", 29) ;

        	u.setPropertyIsEnumerable("name", false) ;
        	
        	for (var prop:String in u)
        	{
        		trace(prop + " : " + u[prop]) ;	
        	
        	}
        	
        	u.speak("hello world") ;
            
	}
}