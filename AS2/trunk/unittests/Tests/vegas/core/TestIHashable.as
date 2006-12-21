
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.HashableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIHashable extends TestCase
{
	
	function TestIHashable( name:String ) 
	{
		super(name);
	}

	public function testHashCode():Void
	{
		var o:HashableImplementation = new HashableImplementation() ;
		assertEquals( o.hashCode(), 0, "IHASH hashCode method failed." ) ;
	}

}