import buRRRn.ASTUce.TestCase;

import vegas.core.types.Bit ;

// TODO finish methods testing.

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestBit extends TestCase 
{
	
	/**
	 * Creates a new TestBit instance.
	 */
	function TestBit(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:Bit = new Bit(1) ;
		assertNotNull( o, "BIT_00 - constructor is null") ;
		assertTrue( o instanceof Bit , "BIT_00 - constructor is an instance of Bit.") ;
	}
	
	public function testInherit()
	{
		var o:Bit = new Bit(1) ;
		assertTrue( o instanceof Number , "BIT_01 - inherit Number failed.") ;
	}	
	
	public function testHashCode():Void
	{
		var o:Bit = new Bit(1) ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "BIT_02 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new Bit(1) ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.Bit(1,2)", "BIT_03 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var result:String ;
		
		var o:Bit ;
		
		o = new Bit(1) ;
		assertEquals( o.toString() , "1b", "BIT_04_01 - toString failed : " + o.toString()) ;
		
		o = new Bit(1234) ;
		assertEquals( o.toString() , "1.21Kb", "BIT_04_02 - toString failed : " + o.toString()) ;
		
		o = new Bit(15002344) ;
		assertEquals( o.toString() , "14.31Mb", "BIT_04_03 - toString failed : " + o.toString()) ;
		
	}


}