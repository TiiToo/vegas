import buRRRn.ASTUce.TestCase;

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.util.comparators.NumberComparator;
import vegas.util.comparators.ReverseComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.util.comparators.TestReverseComparator extends TestCase 
{
	
	function TestReverseComparator(name : String) 
	{
		super(name);
	}

	public var comp:ReverseComparator ;

	public function setUp():Void
	{
		comp = new ReverseComparator( new NumberComparator() ) ;
	}

	public function testConstructor()
	{
		assertNotNull( comp, "REV_COMP_00_01 - constructor is null") ;
		assertTrue( comp instanceof ReverseComparator , "REV_COMP_00_02 - constructor is an instance of ReverseComparator.") ;
	}
	
	public function testInherit()
	{
		assertTrue( comp instanceof CoreObject , "REV_COMP_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(comp.hashCode()) , "REV_COMP_02 - hashCode failed : " + comp.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( comp.toSource() , "new vegas.util.comparators.ReverseComparator(new vegas.util.comparators.NumberComparator())", "REV_COMP_03 - toSource failed : " + comp.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( comp.toString() , "[ReverseComparator]", "REV_COMP_04 - toString failed : " + comp.toString() ) ;
	}

	public function testCompare()
	{
		assertEquals( comp.compare( 0, 0) , 0, "REV_COMP_05_01 - compare method failed." ) ;
		assertEquals( comp.compare(1, 0) , -1, "REV_COMP_05_02 - compare method failed." ) ;
		assertEquals( comp.compare(0, 1) , 1, "REV_COMP_05_03 - compare method failed." ) ;
	}

	public function testComparator()
	{
		assertTrue( comp.comparator instanceof IComparator, "REV_COMP_05_04 - comparator property failed." ) ;
	}

}