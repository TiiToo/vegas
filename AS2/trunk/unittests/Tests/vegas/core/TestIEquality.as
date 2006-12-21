
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.EqualityImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIEquality extends TestCase
{
	
	function TestIEquality( name:String ) 
	{
		super(name);
	}

	public function testEquals():Void
	{
		var o:EqualityImplementation = new EqualityImplementation() ;
		assertTrue( o.equals(), "IEQUAL equals method failed.") ;
	}

}