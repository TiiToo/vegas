import buRRRn.ASTUce.TestCase;

import vegas.core.types.NullObject;
import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestNullObject extends TestCase 
{
	
	/**
	 * Creates a new TestNullObject instance.
	 */
	function TestNullObject(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:NullObject = new NullObject() ;
		assertTrue( o instanceof NullObject , "NULLO_00 - constructor is an instance of NullObject.") ;
	}
	
	public function testInherit()
	{
		var o:NullObject = new NullObject() ;
		assertTrue( o instanceof CoreObject , "NULLO_01 - inherit CoreObject failed.") ;
	}	
	
	public function testValueOf():Void
	{
		var value:Number = (new NullObject()).valueOf() ;
		assertEquals( value , null, "NULLO_02 - valueOf method failed : " + value) ;	
	}
	
	public function testHashCode():Void
	{
		var o:NullObject = new NullObject() ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "NULLO_03 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new NullObject() ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.NullObject()", "NULLO_04 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var o:NullObject = new NullObject() ;
		assertEquals( o.toString() , "null", "NULLO_05_01 - toString failed : " + o.toString()) ;
	}


}