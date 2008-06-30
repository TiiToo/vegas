package test.pool 
{
	
	import andromeda.util.pool.ObjectPoolBuilder ;
	import vegas.core.CoreObject ;
	
	public class MyBuilder implements ObjectPoolBuilder
	{
		
		public function MyBuilder()
		{
			
		}
		
		public function build():*
		{
			return new CoreObject() ;
		}
	}
	
}