
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
        
		Config.showConstructorList = true ;
        Config.testMyself = true ;

		// new TestSuite( Tests.vegas.core.TestCoreObject ) 
		// new TestSuite(Tests.ASTUce.SuiteTest) 
        
        buRRRn.ASTUce.Application.main(  );
        
	}
	
}