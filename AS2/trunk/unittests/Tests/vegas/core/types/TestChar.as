import buRRRn.ASTUce.TestCase;

import vegas.core.types.Char;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestChar extends TestCase 
{
	
	/**
	 * Creates a new TestChar instance.
	 */
	function TestChar(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:Char = new Char("hello") ;
		assertNotNull( o, "CHAR_00 - constructor is null") ;
		assertTrue( o instanceof Char , "CHAR_00 - constructor is an instance of Char.") ;
	}
	
	public function testInherit()
	{
		var o:Char = new Char("hello") ;
		assertTrue( o instanceof String , "CHAR_01 - inherit String failed.") ;
	}	
	
	public function testGetCode():Void
	{
		var code:Number = (new Char("hello")).getCode() ;
		assertEquals( code , 104, "CHAR_02 - getCode method failed : " + code) ;	
	}
	
	public function testHashCode():Void
	{
		var o:Char = new Char("hello") ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "CHAR_03 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new Char("hello") ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.Char(h)", "CHAR_04 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var result:String ;
		
		var o:Char ;
		
		o = new Char() ;
		assertEquals( o.toString() , "", "CHAR_05_01 - toString failed : " + o.toString()) ;
		
		o = new Char("a") ;
		assertEquals( o.toString() , "a", "CHAR_05_02 - toString failed : " + o.toString()) ;
		
		o = new Char("hello") ;
		assertEquals( o.toString() , "h", "CHAR_05_03 - toString failed : " + o.toString()) ;
		
	}


}