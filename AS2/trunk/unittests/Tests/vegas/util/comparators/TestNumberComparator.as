import buRRRn.ASTUce.TestCase;

import vegas.core.CoreObject;
import vegas.util.comparators.NumberComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.util.comparators.TestNumberComparator extends TestCase 
{
	
	function TestNumberComparator(name : String) 
	{
		super(name);
	}

	public var comp:NumberComparator ;

	public function setUp():Void
	{
		comp = new NumberComparator() ;
	}

	public function testConstructor()
	{
		assertNotNull( comp, "NUMB_COMP_00_01 - constructor is null") ;
		assertTrue( comp instanceof NumberComparator , "NUMB_COMP_00_02 - constructor is an instance of NumberComparator.") ;
	}
	
	public function testInherit()
	{
		assertTrue( comp instanceof CoreObject , "NUMB_COMP_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(comp.hashCode()) , "NUMB_COMP_02 - hashCode failed : " + comp.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( comp.toSource() , "new vegas.util.comparators.NumberComparator()", "NUMB_COMP_03 - toSource failed : " + comp.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( comp.toString() , "[NumberComparator]", "NUMB_COMP_04 - toString failed : " + comp.toString() ) ;
	}

	public function testCompare()
	{
		assertEquals( comp.compare( 0, 0) , 0, "NUMB_COMP_05_01 - compare method failed." ) ;
		assertEquals( comp.compare( 1, 1) , 0, "NUMB_COMP_05_02 - compare method failed." ) ;
		assertEquals( comp.compare( -1, -1) , 0, "NUMB_COMP_05_03 - compare method failed." ) ;
		assertEquals( comp.compare( 0.1, 0.1) , 0, "NUMB_COMP_05_04 - compare method failed." ) ;
		
		// test Math method or float number operations.
		assertEquals( comp.compare( Math.cos(25) , 0.991202811863474 ) , 0, "NUMB_COMP_05_05 - compare method failed." ) ;
		
		assertEquals( comp.compare(1, 0) , 1, "NUMB_COMP_05_06 - compare method failed." ) ;
		assertEquals( comp.compare(0, 1) , -1, "NUMB_COMP_05_07 - compare method failed." ) ;
		
	}

}