
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.ConvertibleImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIConvertible extends TestCase
{
	
	/**
	 * Creates a new TestIConvertible instance.
	 */
	function TestIConvertible( name:String ) 
	{
		super(name);
	}

	public var imp:ConvertibleImplementation ;

	public function setUp():Void
	{
		imp = new ConvertibleImplementation() ;
	}	

	public function testToBoolean():Void
	{
		assertTrue( imp.toBoolean(), "ICONVERT_01 toBoolean method failed.") ;
	}

	public function testToNumber():Void
	{
		assertTrue( imp.toNumber() == 1, "ICONVERT_02 toNumber method failed.") ;
	}

	public function testToObject():Void
	{
		assertTrue( imp.toObject().prop, "ICONVERT_03 toObject method failed.") ;
	}

}