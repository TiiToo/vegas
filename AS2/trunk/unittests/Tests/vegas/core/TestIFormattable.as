
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.FormattableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIFormattable extends TestCase
{

	function TestIFormattable( name:String ) 
	{
		super(name);
	}

	public function testFormat():Void
	{
		var o:FormattableImplementation = new FormattableImplementation() ;
		assertEquals( o.toString(), "FormattableImplementation", "IFORMAT toString method failed.") ;
	}


}