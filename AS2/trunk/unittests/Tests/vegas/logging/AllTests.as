
import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.logging.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.logging" );
        
        //suite.simpleTrace = true;

		suite.addTest( Tests.vegas.logging.errors.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.logging.targets.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.logging.tracer.AllTests.suite() ) ;

        // suite.addTest( new TestSuite( Tests.vegas.logging.TestLog ) ) ;
        
        return suite ;
    
    }

}