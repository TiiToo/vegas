
package  
{
	import buRRRn.ASTUce.framework.ITest;
	import buRRRn.ASTUce.framework.TestSuite;
	
	import pegas.AllTests;	

	/**
	 * This class launch all tests.
	 * @author eKameleon
	 */
	public class AllTests
	{
		
        /**
         * Creates the Test list.
         */		
        public static function suite():ITest
        {
            var suite:TestSuite = new TestSuite( "VEGAS v1RC4 unit tests" );
            
            suite.addTest( pegas.AllTests.suite() );
            
            return suite;
        }
        
	}
}
