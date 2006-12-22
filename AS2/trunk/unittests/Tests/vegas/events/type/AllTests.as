import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.events.type.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.events.type" );
        
        //suite.simpleTrace = true;

        return suite ;
    
    }

}