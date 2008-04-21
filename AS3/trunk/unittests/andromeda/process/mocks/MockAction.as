
package andromeda.process.mocks 
{
	import andromeda.process.SimpleAction;				

	/**
	 * This mock simulate an IAction object who increments a static counter "COUNT" when the run method of all instance of this class are called.
	 * @author eKameleon
	 */
	public class MockAction extends SimpleAction 
	{
		
		/**
		 * Creates a new MockAction instance.
		 */
		public function MockAction()
		{
			super() ;
		}
		
		/**
		 * The counter of this class.
		 */
		public static var COUNT:uint = 0 ;
		
		/**
		 * Reset the static counter.
		 */
		public static function reset():void
		{
			COUNT = 0 ;	
		}
		
		/**
		 * Run the process.
		 */
		public override function run(...arguments:Array):void
		{
			notifyStarted() ;
			setRunning(true) ;
			COUNT ++ ;	
			setRunning(false) ;
			notifyFinished() ;
		}
		
	}
}
