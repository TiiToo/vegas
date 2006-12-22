
import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.util.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.util" );
        
        //suite.simpleTrace = true;

		suite.addTest( Tests.vegas.util.comparators.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.factory.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.format.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.mvc.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.observer.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.serialize.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.visitor.AllTests.suite() ) ;

        // suite.addTest( new TestSuite( Tests.vegas.util.TestArrayUtil ) ) ;
        
        return suite ;
    
    }

}