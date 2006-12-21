
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.FormatImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIFormat extends TestCase
{
	
	function TestIFormat( name:String ) 
	{
		super(name);
	}

	public function testFormat():Void
	{
		var o:FormatImplementation = new FormatImplementation() ;
		assertEquals( o.formatToString(this), toString(), "IFT formatToString method failed.") ;
	}


}