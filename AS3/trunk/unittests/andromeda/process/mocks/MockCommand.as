
package andromeda.process.mocks 
{
	import vegas.core.CoreObject;
	import vegas.core.IRunnable;	

	/**
	 * @author eKameleon
	 */
	public class MockCommand extends CoreObject implements IRunnable
	{

		public function MockCommand()
		{
			super();
		}
		
		public static var COUNT:uint = 0 ;
		
		public static function reset():void
		{
			COUNT = 0 ;	
		}
		
		public function run(...arguments:Array):void
		{
			COUNT ++ ;	
		}
	}
}
