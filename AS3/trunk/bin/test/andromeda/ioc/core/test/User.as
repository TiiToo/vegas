
package test
{
		
	import vegas.core.CoreObject ;

	public class User extends CoreObject
	{
		
		public function User() 
		{
		
		}
	
		public var pseudo:String ;
	
		public var url:String ;
	
		public function initialize():void
		{
			trace( "# " + this + " initialize") ;
		}
	
	}
	
}