
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.CopyableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestICopyable extends TestCase
{
	
	/**
	 * Creates a new TestIConpyable instance.
	 */
	function TestICopyable( name:String ) 
	{
		super(name);
	}

	public function testCopy():Void
	{
		var o:CopyableImplementation = new CopyableImplementation() ;
		assertTrue( o.copy() instanceof CopyableImplementation, "ICOPY copy method failed.") ;
	}

}