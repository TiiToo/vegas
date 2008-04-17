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
	public class TestInitProcess extends TestCase 
	{

		public function TestInitProcess(name:String = "")
		{
			super(name);
		}
		
		public var action:SimpleInitProcess ;
		
        public function setUp():void
        {
            action = new SimpleInitProcess() ;
        }
        
        public function tearDown():void
        {
            action = undefined ;
        }
        		
		
		public function testInit():void
		{
			try
			{
				action.init() ;
			}
			catch( e:Error )
			{
				assertEquals(e.message, "init" , "InitProcess init method failed.") ;
			}
		}		
		
	}
}

import andromeda.process.InitProcess;

class SimpleInitProcess extends InitProcess
{


	/**
	 * Invoked when the process is run. Overrides this method.
	 */
	public override function init():void
	{
		throw new Error("init") ;
	}
	
}
