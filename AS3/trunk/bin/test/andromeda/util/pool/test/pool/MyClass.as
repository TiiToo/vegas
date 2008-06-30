package test.pool 
{
	
	public class MyClass 
	{
		
		public function MyClass()
		{
			id = CPT ++ ;
		}
		
		public static var CPT:uint = 0 ;
		
		public var id:* ;
		
		public function init( ...args:Array ):void
		{
			trace( this + " init " + id + " args:" + args ) ;
		}
	}
	
}