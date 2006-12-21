import buRRRn.ASTUce.TestCase;

import vegas.core.HashCode;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestHashCode extends TestCase 
{
	
	/**
	 * Creates a new TestHashCode instance.
	 */
	function TestHashCode( name:String ) 
	{
		super(name);
	}
	
	public function testEquals()
	{
		var o = {} ;
		var value = HashCode.equals(o, o) ;
		assertTrue( value , "HASH_01 - equals method failed : " + value) ;
	}

	public function testIdentify():Void 
	{
		var o = {} ;
		var value = HashCode.identify(o) ;
		assertTrue( !isNaN(value) , "HASH_02 - identifiy method failed : " + value) ;
	}
	
	public function testNext():Void 
	{
		var value = HashCode.next() ;
		assertTrue( !isNaN(value) , "HASH_03 - next method failed, the value is not a number : " + value) ;
	}

	public function testNextName():Void 
	{
		var o = {} ;
		var previous = HashCode.identify(o) ;
		var next = HashCode.nextName() ;
		assertTrue( Number(next) > previous , "HASH_04 - nextName method failed, previous:" + previous + ", next:" + next ) ;
	}
	
	public function initialize():Void 
	{
		var o = {} ;
		var b = HashCode.initialize(o) ;
		assertTrue( b , "HASH_05 - initialize method failed : " + b ) ;
	}	

}