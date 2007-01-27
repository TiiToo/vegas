import buRRRn.ASTUce.TestCase;

import vegas.core.CoreObject;
import vegas.util.comparators.DateComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.util.comparators.TestDateComparator extends TestCase 
{
	
	function TestDateComparator(name : String) 
	{
		super(name);
	}

	public var comp:DateComparator ;

	public function setUp():Void
	{
		comp = new DateComparator() ;
	}

	public function testConstructor()
	{
		assertNotNull( comp, "DAT_COMP_00_01 - constructor is null") ;
		assertTrue( comp instanceof DateComparator , "DAT_COMP_00_02 - constructor is an instance of DateComparator.") ;
	}
	
	public function testInherit()
	{
		assertTrue( comp instanceof CoreObject , "DAT_COMP_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(comp.hashCode()) , "DAT_COMP_02 - hashCode failed : " + comp.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( comp.toSource() , "new vegas.util.comparators.DateComparator()", "DAT_COMP_03 - toSource failed : " + comp.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( comp.toString() , "[DateComparator]", "DAT_COMP_04 - toString failed : " + comp.toString() ) ;
	}

	public function testCompare()
	{
		var d1:Date   = new Date(2007, 1, 1) ;
		var d2:Number =  1170284400000 ;
		var d3:Date   = new Date(2007, 2, 2) ;
		var d4:Number = 1172790000000 ;
		assertEquals( comp.compare(d1, d1) , 0, "DAT_COMP_05_01 - compare method failed." ) ;
		assertEquals( comp.compare(d1, d2) , 0, "DAT_COMP_05_02 - compare method failed." ) ;
		assertEquals( comp.compare(d2, d1) , 0, "DAT_COMP_05_03 - compare method failed." ) ;
		assertEquals( comp.compare(d1, d3) , -1, "DAT_COMP_05_04 - compare method failed." ) ;
		assertEquals( comp.compare(d1, d4) , -1, "DAT_COMP_05_05 - compare method failed." ) ;
		assertEquals( comp.compare(d3, d1) , 1, "DAT_COMP_05_06 - compare method failed." ) ;
		assertEquals( comp.compare(d4, d1) , 1, "DAT_COMP_05_07 - compare method failed." ) ;			
	}

}