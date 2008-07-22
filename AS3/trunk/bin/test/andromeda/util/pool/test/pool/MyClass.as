package test.pool 
{
	
	public class MyClass 
	{
		
		public function MyClass( label:String=null )
		{
			id = CPT ++ ;
			this.label = label ;
		}
		
		public static var CPT:uint = 0 ;
		
		public var id:* ;
		
		public var label:String ;
		
		public function init( ...args:Array ):void
		{
			trace( this + " init id:" + id + " label:" + label + " args:" + args ) ;
		}
	}
	
}