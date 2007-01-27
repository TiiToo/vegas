import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.ComparableImplementation;

import vegas.core.CoreObject;
import vegas.core.IComparable;
import vegas.util.comparators.DateComparator;
import vegas.util.comparators.NullComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.util.comparators.TestNullComparator extends TestCase 
{
	
	function TestNullComparator(name : String) 
	{
		super(name);
	}

	public function testConstructor()
	{
		var comp:NullComparator = new NullComparator() ;
		assertNotNull( comp, "NULL_COMP_00_01 - constructor is null") ;
		assertTrue( comp instanceof NullComparator , "NULL_COMP_00_02 - constructor is an instance of NullComparator.") ;
	}
	
	public function testInherit()
	{
		var comp:NullComparator = new NullComparator() ;
		assertTrue( comp instanceof CoreObject , "NULL_COMP_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		var comp:NullComparator = new NullComparator() ;
		assertTrue( !isNaN(comp.hashCode()) , "NULL_COMP_02 - hashCode failed : " + comp.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		var comp:NullComparator = new NullComparator( new DateComparator(), true) ;
		assertEquals( comp.toSource() , "new vegas.util.comparators.NullComparator(new vegas.util.comparators.DateComparator(),true)", "NULL_COMP_03 - toSource failed : " + comp.toSource() ) ;
	}

	public function testToString():Void
	{
		var comp:NullComparator = new NullComparator() ;
		assertEquals( comp.toString() , "[NullComparator]", "NULL_COMP_04 - toString failed : " + comp.toString() ) ;
	}

	public function testCompare()
	{
		var o:IComparable = new ComparableImplementation() ;
		var d1:Date = new Date(2006,1,1) ;
		var d2:Date = new Date(2006,1,2) ;
		var comp:NullComparator ;
		
		comp = new NullComparator( new DateComparator(), true) ;
		assertEquals( comp.compare(null, null) , 0, "NULL_COMP_05_01 - compare method failed." ) ;
		assertEquals( comp.compare(null, 2) ,  1  , "NULL_COMP_05_02 - compare method failed." ) ;
		assertEquals( comp.compare(2, null) , -1  , "NULL_COMP_05_03 - compare method failed." ) ;
		assertEquals( comp.compare(d1, d2) , -1   , "NULL_COMP_05_04 - compare method failed." ) ;
		
		comp = new NullComparator( null, true) ;
		assertEquals( comp.compare( o, 12) , 1  , "NULL_COMP_05_05 - compare method failed." ) ;
		
	}

}