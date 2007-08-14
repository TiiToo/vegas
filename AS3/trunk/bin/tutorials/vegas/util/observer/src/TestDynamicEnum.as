package
{
	
	import flash.display.Sprite;
	
	import test.User;
	
	public class TestDynamicEnum extends Sprite
	{
		
		/**
		 * Creates a new TestDynamicEnum instance.
		 */
		public function TestDynamicEnum()
		{
		
			var u:User = new User("eka", 29) ;
	
			u.setPropertyIsEnumerable("name", false) ;
	        	
			for ( var prop:String in u )
			{
				trace( prop + " : " + u[prop] ) ;	
			}
			
  		}	    	
	
	}

}