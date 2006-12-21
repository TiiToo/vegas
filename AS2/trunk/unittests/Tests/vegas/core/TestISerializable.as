
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.RunnableImplementation;
import Tests.vegas.core.TestInterfaces.SerializableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestISerializable extends TestCase
{
	
	function TestISerializable( name:String ) 
	{
		super(name);
	}

	public function testToSource():Void
	{
		var o:SerializableImplementation = new SerializableImplementation() ;
		assertEquals( o.toSource(), "SerializableImplementation", "ITO_SOUR toSource method failed." ) ;
	}


}