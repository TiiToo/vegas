/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process 
{
    import buRRRn.ASTUce.framework.TestCase;    					

    /**
	 * @author eKameleon
	 */
	public class IStoppableTest extends TestCase 
	{

		public function IStoppableTest(name:String = "")
		{
			super(name);
		}
		
		public function testStop():void
		{
			var o:ConcreteStop = new ConcreteStop() ;
			var result:* =  o.stop( true ) ;
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
    public function stop( ...args:Array ):*
    {
    	return args[0] ;	
    }
	
}