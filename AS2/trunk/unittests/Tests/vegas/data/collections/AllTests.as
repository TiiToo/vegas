import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.data.collections.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.data.collections" );
        
        //suite.simpleTrace = true;

		//suite.addTest( new TestSuite( Tests.vegas.data.collections.TestSimpleCollection  ) ) ;
        
        return suite ;
    
    }

}