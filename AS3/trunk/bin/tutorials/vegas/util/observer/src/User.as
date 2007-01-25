package
{
	import vegas.core.CoreObject;

	dynamic public class User extends CoreObject
	{
		
		public function User( name:String , age:int)
		{
			this.name = name ;
			this.age = age ;
			
			
			
		}
		
		public var age:int ;
		
		public function speak( msg:String ):void
		{
			trace(this + " speak : " + msg) ;
		}

		override public function toString():String
		{
			return "[User " + this.name + "]" ;	
		
		}
		
	}
}