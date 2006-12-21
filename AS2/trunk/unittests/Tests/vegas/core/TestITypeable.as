
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.TypeableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestITypeable extends TestCase
{
	
	function TestITypeable( name:String ) 
	{
		super(name);
	}
	
	public var i:TypeableImplementation ;
	
	public function setUp():Void
	{
		i = new TypeableImplementation() ;
		i.setType(String) ;	
	}

	public function TestGetType():Void 
	{
		assertEquals(i.getType(), String, "ITYP_01 getType method failed.") ;
	}

	public function TestSetType():Void 
	{
		i.setType(String) ;	
		assertEquals(i.getType(), String, "ITYP_02 setType method failed." ) ;
	}


}