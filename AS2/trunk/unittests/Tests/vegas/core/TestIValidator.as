
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.ValidatorImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIValidator extends TestCase
{
	
	function TestIValidator( name:String ) 
	{
		super(name);
	}
	
	public var i:ValidatorImplementation ;
	
	public function setUp():Void
	{
		i = new ValidatorImplementation() ;
	}

	public function TestSupports():Void 
	{
		assertTrue( i.supports(this), "IVALID_01 supports method failed.") ;
	}

	function TestValidate():Void 
	{
		i.validate() ;
		assertTrue( i.isValidate, "IVALID_02 validate method failed.") ;
	}


}