import buRRRn.ASTUce.TestCase;

import vegas.core.types.Bit;
import vegas.core.types.Byte;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestByte extends TestCase 
{
	
	/**
	 * Creates a new TestByte instance.
	 */
	function TestByte( name:String ) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:Byte = new Byte(1) ;
		assertNotNull( o, "BYTE_00 - constructor is null") ;
		assertTrue( o instanceof Byte , "BYTE_00 - constructor is an instance of Byte.") ;
	}
	
	public function testInherit()
	{
		var o:Byte = new Byte(1) ;
		assertTrue( o instanceof Bit , "BYTE_01 - inherit Bit failed.") ;
	}	
	
	public function testHashCode():Void
	{
		var o:Byte = new Byte(1) ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "BYTE_02 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new Byte(1) ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.Byte(1,2)", "BYTE_03 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var result:String ;
		
		var o:Byte ;
		
		o = new Byte(1) ;
		assertEquals( o.toString() , "1B", "BYTE_04_01 - toString failed : " + o.toString()) ;
		
		o = new Byte(1234) ;
		assertEquals( o.toString() , "1.21KB", "BYTE_04_02 - toString failed : " + o.toString()) ;
		
		o = new Byte(15002344) ;
		assertEquals( o.toString() , "14.31MB", "BYTE_04_03 - toString failed : " + o.toString()) ;
		
	}


}