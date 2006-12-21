
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.FactoryImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIFactory extends TestCase
{
	
	function TestIFactory( name:String ) 
	{
		super(name);
	}

	public function testCreate():Void
	{
		var o:FactoryImplementation = new FactoryImplementation() ;
		assertTrue( o.create() instanceof FactoryImplementation, "IFACT create method failed.") ;
	}

}