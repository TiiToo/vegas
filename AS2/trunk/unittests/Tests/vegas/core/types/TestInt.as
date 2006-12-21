
import buRRRn.ASTUce.TestCase;

import vegas.core.types.Int;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestInt extends TestCase 
{
	
	/**
	 * Creates a new TestInt instance.
	 */
	function TestInt(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:Int = new Int(1) ;
		assertNotNull( o, "INT_00 - constructor is null") ;
		assertTrue( o instanceof Int , "INT_00 - constructor is an instance of Int.") ;
	}
	
	public function testInherit()
	{
		var o:Int = new Int(1) ;
		assertTrue( o instanceof Number , "INT_01 - inherit String failed.") ;
	}	
	
	public function testValueOf():Void
	{
		var value:Number ;
		
		value = (new Int(12.4)).valueOf() ;
		assertEquals( value , 12, "INT_02_01 - valueOf method failed : " + value) ;
		
		value = (new Int(0)).valueOf() ;
		assertEquals( value , 0, "INT_02_02 - valueOf method failed : " + value) ;
		
		value = (new Int(-12.4)).valueOf() ;
		assertEquals( value , -12, "INT_02_03 - valueOf method failed : " + value) ;
		
		value = (new Int()).valueOf() ;
		assertEquals( value , NaN, "INT_02_03 - valueOf method failed : " + value) ;
		
	}
	
	public function testHashCode():Void
	{
		var o:Int = new Int(12) ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "INT_03 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new Int(15.5) ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.Int(15)", "INT_04 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var result:String ;
		
		var o:Int ;
		
		o = new Int(24.2) ;
		assertEquals( o.toString() , "24", "INT_05 - toString failed : " + o.toString()) ;

		
	}


}