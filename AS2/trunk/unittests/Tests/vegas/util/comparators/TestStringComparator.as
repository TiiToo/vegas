import buRRRn.ASTUce.TestCase;

import vegas.core.CoreObject;
import vegas.errors.ClassCastError;
import vegas.util.comparators.StringComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.util.comparators.TestStringComparator extends TestCase 
{
	
	function TestStringComparator(name : String) 
	{
		super(name);
	}

	public var comp1:StringComparator ;
	public var comp2:StringComparator ;
	public var comp3:StringComparator ;

	public function setUp():Void
	{
		comp1 = new StringComparator() ;
		comp2 = new StringComparator(true) ; // ignore case.
		comp3 = new StringComparator(false) ; // ignore case.
	}

	public function testConstructor()
	{
		assertNotNull( comp1, "STR_COMP_00_01 - constructor is null") ;
		assertTrue( comp1 instanceof StringComparator , "STR_COMP_00_02 - constructor is an instance of StringComparator.") ;
	}
	
	public function testInherit()
	{
		assertTrue( comp1 instanceof CoreObject , "STR_COMP_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(comp1.hashCode()) , "STR_COMP_02 - hashCode failed : " + comp1.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( comp1.toSource() , "new vegas.util.comparators.StringComparator(false)", "STR_COMP_03_01 - toSource failed : " + comp1.toSource() ) ;
		assertEquals( comp2.toSource() , "new vegas.util.comparators.StringComparator(true)", "STR_COMP_03_02 - toSource failed : " + comp2.toSource() ) ;
		assertEquals( comp3.toSource() , "new vegas.util.comparators.StringComparator(false)", "STR_COMP_03_03 - toSource failed : " + comp3.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( comp1.toString() , "[StringComparator]", "STR_COMP_04 - toString failed : " + comp1.toString() ) ;
	}

	public function testCompare()
	{
		assertEquals( comp1.compare( null, null) , 0, "STR_COMP_05_00 - compare method failed." ) ;
		assertEquals( comp1.compare( "a", "a") , 0, "STR_COMP_05_01 - compare method failed." ) ;
		assertEquals( comp1.compare( "hello", "hello") , 0, "STR_COMP_05_02 - compare method failed." ) ;
		assertEquals( comp1.compare( "hello", "world") , -1, "STR_COMP_05_03 - compare method failed." ) ;
		assertEquals( comp1.compare( "world", "hello") , 1, "STR_COMP_05_04 - compare method failed." ) ;
		
		var isClassCast:Boolean = false ;
		try
		{
			comp1.compare( 2, 3) ;
		}
		catch(e)
		{
			isClassCast = e instanceof ClassCastError ;
		}
		assertTrue( isClassCast , "STR_COMP_05_05 - compare method failed the two parameters must be string objects." ) ;
	}

}