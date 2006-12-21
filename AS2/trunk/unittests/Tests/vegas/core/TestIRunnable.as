
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.RunnableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIRunnable extends TestCase
{
	
	function TestIRunnable( name:String ) 
	{
		super(name);
	}

	public function testRun():Void
	{
		var o:RunnableImplementation = new RunnableImplementation() ;
		o.run() ;
		assertTrue( o.isRunning, "IRUN run method failed." ) ;
	}


}