package test
{

	dynamic public class User
	{
		
		/**
		 * Creates a new User instance.
		 */
		public function User( name:String , age:int)
		{
			this.age = age ;
			this.name = name ;
		}
				
		public function speak( msg:String ):void
		{
			trace(this + " speak : " + msg) ;
		}

		public function toString():String
		{
			return "[User " + this.name + "]" ;	
		}
		
	}
}