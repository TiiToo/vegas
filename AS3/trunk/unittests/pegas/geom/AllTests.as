
package pegas.geom  
{
	import buRRRn.ASTUce.framework.ITest;
	import buRRRn.ASTUce.framework.TestSuite;	

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
            
            var suite:TestSuite = new TestSuite( "pegas.geom" );
            
            suite.addTestSuite( TestDimension ) ;
            suite.addTestSuite( TestMatrix4 ) ;
            suite.addTestSuite( TestPlane ) ;
            suite.addTestSuite( TestPoint ) ;
            suite.addTestSuite( TestQuaternion ) ;
            suite.addTestSuite( TestRay ) ;
            suite.addTestSuite( TestUVCoordinate ) ;
            suite.addTestSuite( TestVector2 ) ;
            suite.addTestSuite( TestVector3 ) ;
            suite.addTestSuite( TestVector4 ) ;
            suite.addTestSuite( TestVertex ) ;
                        
            return suite;
            
        }
        
	}
}
