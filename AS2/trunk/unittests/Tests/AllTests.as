
import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.AllTests extends TestCase 
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
        
        // suite.simpleTrace = true;
        
      	// suite.addTest(  Tests.ASTUce.AllTests.suite() ) ; // OK full testing.
		// suite.addTest(  Tests.eden.AllTests.suite()   ) ; // FIXME 2 errors for the moment in this library
        
        suite.addTest(  Tests.vegas.AllTests.suite()  ) ;
        
        return suite ;
    
    }

}