
import buRRRn.ASTUce.Config;
import buRRRn.ASTUce.TestSuite;

/**
 * The main Unit Tests application.
 * @author eKameleon
 */
class Application 
{
   
   	/**
   	 * Launch the Unit Tests.
   	 */
    static public function main():Void
	{
        
        // ASTUce configuration
           
        Config.verbose = false;
        
        // Config.showObjectSource = true;
        // Config.invertExpectedActual = false;
        // Config.testPrivateMethods = false;
        // Config.testInheritedTests = true;
        //Config.testMyself = true ;
		
		Config.showConstructorList = true ;
        Config.testMyself = true ;

		//var suite:TestSuite = new TestSuite("Units Test");
		//suite.addTest( Tests.AllTests.suite() );

		//suite = new TestSuite( Tests.vegas.core.TestCoreObject ) ;

        buRRRn.ASTUce.Application.main( );
        
	}
	
}