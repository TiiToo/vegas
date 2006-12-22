
import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.events.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.events" );
        
        //suite.simpleTrace = true;

		suite.addTest( Tests.vegas.events.type.AllTests.suite() ) ;

        // suite.addTest( new TestSuite( Tests.vegas.events.TestAbstractCoreEventDispatcher ) ) ;
        
        return suite ;
    
    }

}