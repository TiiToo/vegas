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
	
	public function testConstructor()
	{
		var o = new CoreObject() ;
		assertTrue( o instanceof CoreObject , "CO_00 - constructor failed.") ;
	}
	
	public function testInherit()
	{
		var o = new CoreObject() ;
		assertTrue( o instanceof Object , "CO_01 - inherit Object failed.") ;
	}	
	
	public function testHashCode():Void
	{
		var o:CoreObject = new CoreObject() ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "CO_02 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o:CoreObject = new CoreObject() ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.CoreObject()", "CO_03 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var o:CoreObject = new CoreObject() ;
		var result:String = o.toString() ;
		assertEquals( result , "[CoreObject]", "CO_04 - toString failed : " + result) ;
	}


}