import vegas.core.IRunnable;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.RunnableImplementation implements IRunnable 
{
	
	public var isRunning:Boolean = false ;
	
	public function run():Void 
	{
		isRunning = true ;
	}

}