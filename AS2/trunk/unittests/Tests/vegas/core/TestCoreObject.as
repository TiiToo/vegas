import buRRRn.ASTUce.TestCase;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestCoreObject extends TestCase 
{
	
	/**
	 * Creates a new TestCoreObject instance.
	 */
	function TestCoreObject(name : String) 
	{
		super(name);
	}
	
	public var o:CoreObject ;
	
	public function setUp():Void
	{
		o = new CoreObject() ;
	}
	
	public function testConstructor()
	{
		assertNotNull( o, "CO_00_01 - constructor is null") ;
		assertTrue( o instanceof CoreObject , "CO_00_02 - constructor is an instance of CoreObject.") ;
	}
	
	public function testInherit()
	{
		assertTrue( o instanceof Object , "CO_01 - inherit Object failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(o.hashCode()) , "CO_02 - hashCode failed : " + o.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( o.toSource() , "new vegas.core.CoreObject()", "CO_03 - toSource failed : " + o.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( o.toString() , "[CoreObject]", "CO_04 - toString failed : " + o.toString() ) ;
	}

}