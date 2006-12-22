
import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.data.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.data" );
        
        //suite.simpleTrace = true;

		suite.addTest(  Tests.vegas.data.array.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.bag.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.collections.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.iterator.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.list.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.map.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.queue.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.set.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.stack.AllTests.suite() ) ;
		
        // suite.addTest( new TestSuite( Tests.vegas.data.TestIBag ) ) ;
        
        return suite ;
    
    }

}