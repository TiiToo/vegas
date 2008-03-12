package test
{
	
	import andromeda.process.InitProcess ;

	/**
	 * Little class to test the InitProcess implementation.
	 */
	public class InitTest extends InitProcess
	{
		
	    /**
    	 * Creates a new InitProcess instance.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code>bGlobal</code> argument is <code>true</code>.
    	 */
		public function InitTest( bGlobal:Boolean = false , sChannel:String = null ) 
    	{
		    super( bGlobal, sChannel);
		}

		/**
		 * Invoked when the process is run. Overrides this method.
		 */
		public override function init():void
		{
			trace( this + " custom initialize") ;
		}	
	}	
	
}