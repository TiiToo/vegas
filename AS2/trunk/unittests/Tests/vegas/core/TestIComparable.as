import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.ComparableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIComparable extends TestCase
{
	
	/**
	 * Creates a new TestIComparable instance.
	 */
	function TestIComparable( name:String ) 
	{
		super(name);
	}

	public function testCompareTo():Void
	{
		var o:ComparableImplementation = new ComparableImplementation() ;
		assertEquals( o.compareTo(this), 0 , "ICOMP_TO compareTo method failed.") ;
	}


}