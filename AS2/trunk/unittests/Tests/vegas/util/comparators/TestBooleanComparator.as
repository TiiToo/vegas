import buRRRn.ASTUce.TestCase;

import vegas.core.CoreObject;
import vegas.errors.ClassCastError;
import vegas.errors.NullPointerError;
import vegas.util.comparators.BooleanComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.util.comparators.TestBooleanComparator extends TestCase 
{
	
	function TestBooleanComparator(name : String) 
	{
		super(name);
	}

	public var falseComparator:BooleanComparator ;

	public var trueComparator:BooleanComparator ;

	public function setUp():Void
	{
		falseComparator = BooleanComparator.getFalseFirstComparator() ;
		trueComparator = BooleanComparator.getTrueFirstComparator() ;
	}

	public function testConstructor()
	{
		assertNotNull( trueComparator, "BOOL_COMP_00_01 - constructor is null") ;
		assertTrue( trueComparator instanceof BooleanComparator , "BOOL_COMP_00_02 - constructor is an instance of BooleanComparator.") ;
	}
	
	public function testInherit()
	{
		assertTrue( trueComparator instanceof CoreObject , "BOOL_COMP_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(trueComparator.hashCode()) , "BOOL_COMP_02 - hashCode failed : " + trueComparator.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( trueComparator.toSource()  , "new vegas.util.comparators.BooleanComparator(true)", "BOOL_COMP_03_01 - toSource failed : " + trueComparator.toSource() ) ;
		assertEquals( falseComparator.toSource() , "new vegas.util.comparators.BooleanComparator(false)", "BOOL_COMP_03_02 - toSource failed : " + trueComparator.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( trueComparator.toString() , "[BooleanComparator]", "BOOL_COMP_04 - toString failed : " + trueComparator.toString() ) ;
	}

	public function testCompare()
	{
		assertEquals( trueComparator.compare( true, true )   ,  0  , "BOOL_COMP_05_01 - compare method failed." ) ;
		assertEquals( trueComparator.compare( false, false ) ,  0  , "BOOL_COMP_05_02 - compare method failed." ) ;
		assertEquals( trueComparator.compare( true, false )  ,  1  , "BOOL_COMP_05_03 - compare method failed." ) ;
		assertEquals( trueComparator.compare( false, true )  , -1  , "BOOL_COMP_05_04 - compare method failed." ) ;
		
		assertEquals( falseComparator.compare( true, true )   ,  0 , "BOOL_COMP_05_05 - compare method failed." ) ;
		assertEquals( falseComparator.compare( false, false ) ,  0 , "BOOL_COMP_05_06 - compare method failed." ) ;
		assertEquals( falseComparator.compare( true, false )  , -1 , "BOOL_COMP_05_07 - compare method failed." ) ;
		assertEquals( falseComparator.compare( false, true )  ,  1 , "BOOL_COMP_05_08 - compare method failed." ) ;

		var isNullPointer:Boolean = false ;
		try
		{
			trueComparator.compare(null, true) ;
		}
		catch(e:Error)
		{
			isNullPointer = e instanceof NullPointerError ;
		}
		assertTrue( isNullPointer, "BOOL_COMP_05_09 - compare method failed with NullPointerError test : " + isNullPointer) ;
		
		var isClassCast:Boolean = false ;
		try
		{
			trueComparator.compare( new CoreObject(), true) ;
		}
		catch(e:Error)
		{
			isClassCast = e instanceof ClassCastError ;
		}
		assertTrue( isClassCast, "COMP_COMP_05_10 - compare method failed with ClassCastError test.") ;

	}

}