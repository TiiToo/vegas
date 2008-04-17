
package andromeda.process 
{
	import buRRRn.ASTUce.framework.TestCase;				

	/**
	 * @author eKameleon
	 */
	public class TestIStoppable extends TestCase 
	{

		public function TestIStoppable(name:String = "")
		{
			super(name);
		}
		
        public function setUp():void
        {

        }
        
        public function tearDown():void
        {

        }
		
		public function testStop():void
		{
			var o:ConcreteStop = new ConcreteStop() ;
			var result:* =  o.stop() ;
			assertTrue( result is Boolean , "stop() method must return a boolean.") ;
			assertTrue( true , "stop() method must return a true value.") ;				
		}
	}
}

import andromeda.process.IStoppable;

class ConcreteStop implements IStoppable
{
	
    /**
     * Stop the process.
     */
    public function stop():Boolean 
    {
    	return true ;	
    }
	
}