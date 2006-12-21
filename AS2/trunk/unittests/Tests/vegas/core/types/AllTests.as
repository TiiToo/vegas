import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.AllTests extends TestCase 
{

	/**
	 * Creates a new AllTests instance.
	 */	
	function AllTests(name : String) 
	{
		super(name);
	}

	/**
	 * Creates the Test list.
	 */
    static function suite():TestSuite
	{
        var suite:TestSuite = new TestSuite( "Tests.vegas.core.types" );
        
        //suite.simpleTrace = true;

		suite.addTest( new TestSuite( Tests.vegas.core.types.TestBit  ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.core.types.TestByte ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.core.types.TestChar ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.core.types.TestInt  ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.core.types.TestNullObject ) ) ;
		
        
        return suite ;
    
    }

}