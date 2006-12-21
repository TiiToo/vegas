
import buRRRn.ASTUce.TestCase;

import Tests.vegas.core.TestInterfaces.CloneableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestICloneable extends TestCase
{
	
	function TestICloneable( name:String ) 
	{
		super(name);
	}

	public function testClone():Void
	{
		var o:CloneableImplementation = new CloneableImplementation() ;
		assertTrue( o.clone()instanceof CloneableImplementation , "ICLONE_00 clone method failed.") ;	
	}

}