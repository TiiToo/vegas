import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.AllTests extends TestCase 
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
        
        var suite:TestSuite = new TestSuite( "Tests" );
        
        //suite.simpleTrace = true;
        
        suite.addTest( Tests.vegas.core.AllTests.suite() ) ;
        // suite.addTest( Tests.vegas.data.AllTests.suite() ) ;
        // suite.addTest( Tests.vegas.errors.AllTests.suite() ) ;
        // suite.addTest( Tests.vegas.events.AllTests.suite() ) ;
        // suite.addTest( Tests.vegas.logging.AllTests.suite() ) ;
        // suite.addTest( Tests.vegas.maths.AllTests.suite() ) ;
        // suite.addTest( Tests.vegas.string.AllTests.suite() ) ;
        // suite.addTest( Tests.vegas.util.AllTests.suite() ) ;
        
        return suite ;
    
    }

}