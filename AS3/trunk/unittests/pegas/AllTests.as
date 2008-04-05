
package pegas  
{
	import buRRRn.ASTUce.framework.ITest;
	import buRRRn.ASTUce.framework.TestSuite;
	
	import pegas.geom.AllTests;	

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
            var suite:TestSuite = new TestSuite( "pegas" );

            suite.addTest( pegas.geom.AllTests.suite()  ) ;
            
            return suite;
        }
	}
}

