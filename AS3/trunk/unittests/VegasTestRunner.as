
package  
{
	import flash.display.Sprite;
	
	import buRRRn.ASTUce.Runner;
	import buRRRn.ASTUce.config;	

	/**
	 * The main VEGAS TestRunner launcher.
	 * @author eKameleon
	 */
	public class VegasTestRunner extends Sprite
	{
		
            public function VegasTestRunner()
            {

                buRRRn.ASTUce.config.showConstructorList = false ;
                //buRRRn.ASTUce.config.verbose             = true ;                         

                // testing all.
                
                Runner.main( AllTests );

            
        }
	}
}
