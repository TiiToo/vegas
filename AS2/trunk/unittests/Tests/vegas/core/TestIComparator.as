import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.ComparatorImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIComparator extends TestCase
{

	function TestIComparator( name:String ) 
	{
		super(name);
	}
	
	public var c:ComparatorImplementation ;

	public function setUp():Void
	{
		c = new ComparatorImplementation() ;
	}	
	
	public function testCompare():Void
	{
		assertEquals( c.compare( this, this ), 0, "ICOMPAR_01 compare method failed.") ;
	}

	public function testEquals():Void
	{
		assertTrue( c.equals( this ), "ICOMPAR_02 equals method failed.") ;
	}

}