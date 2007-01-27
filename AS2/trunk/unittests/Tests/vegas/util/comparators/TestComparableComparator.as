import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.ComparableImplementation;

import vegas.core.CoreObject;
import vegas.core.IComparable;
import vegas.errors.ClassCastError;
import vegas.errors.NullPointerError;
import vegas.util.comparators.ComparableComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.util.comparators.TestComparableComparator extends TestCase 
{
	
	function TestComparableComparator(name : String) 
	{
		super(name);
	}
	
	public var comp:ComparableComparator ;
	
	public function setUp():Void
	{
		comp = ComparableComparator.getInstance() ;		
	}
	
	public function testConstructor()
	{
		assertNotNull( comp, "COMP_COMP_00_01 - constructor is null") ;
		assertTrue( comp instanceof ComparableComparator , "COMP_COMP_00_02 - constructor is an instance of ComparableComparator.") ;
	}
	
	public function testInherit()
	{
		assertTrue( comp instanceof CoreObject , "COMP_COMP_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		var n:Number = comp.hashCode() ;
		assertTrue( !isNaN(n) , "COMP_COMP_02 - hashCode failed : " + n ) ;
	}
	
	public function testToSource():Void
	{
		var s:String = comp.toSource() ;
		assertEquals( s , "new vegas.util.comparators.ComparableComparator()", "COMP_COMP_03 - toSource failed : " + s ) ;
	}

	public function testToString():Void
	{
		var s:String = comp.toString() ;
		assertEquals( s , "[ComparableComparator]", "COMP_COMP_04 - toString failed : " + s ) ;
	}

	public function testCompare()
	{
		var o:IComparable = new ComparableImplementation() ;
		
		assertEquals( comp.compare( o, 2 ) , 1, "COMP_COMP_05_01 - compare method failed." ) ;
		assertEquals( comp.compare( o, -10) , -1, "COMP_COMP_05_02 - compare method failed." ) ;
		assertEquals( comp.compare(o, 0) , 0, "COMP_COMP_05_03 - compare method failed." ) ;

		var isNullPointer:Boolean = false ;
		try
		{
			comp.compare(null, o) ;
		}
		catch(e:Error)
		{
			isNullPointer = e instanceof NullPointerError ;
		}
		assertTrue( isNullPointer, "COMP_COMP_05_04 - compare method failed with NullPointerError test : " + isNullPointer) ;
		
		var isClassCast:Boolean = false ;
		try
		{
			comp.compare(new CoreObject(), 2) ;
		}
		catch(e:Error)
		{
			isClassCast = e instanceof ClassCastError ;
		}
		assertTrue( isClassCast, "COMP_COMP_05_05 - compare method failed with ClassCastError test.") ;
		
	}

}