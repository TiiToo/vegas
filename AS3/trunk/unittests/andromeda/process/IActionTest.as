/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
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
	public class IActionTest extends TestCase 
	{

		public function IActionTest(name:String = "")
		{
			super(name);
		}
		
		public var action:ConcreteAction ;
		
        public function setUp():void
        {
			action = new ConcreteAction() ;
        }
        
        public function tearDown():void
        {
			action = null ;
        }		

		public function testClone():void
		{
			assertNotNull( action.clone() as IAction , "IAction clone method failed." ) ;
		}
		
		public function testNotifyFinished():void
		{
			try
			{
				action.notifyFinished() ;
				fail("IAction 01 notifyFinished method failed.") ;
			}	
			catch( e:Error )
			{
				assertEquals(e.message, "finished" , "IAction 02 notifyFinished method failed.") ;	
			}
		}
	
		public function testNotifyStarted():void
		{
			try
			{
				action.notifyStarted() ;
				fail("IAction 01 notifyStarted method failed.") ;
			}	
			catch( e:Error )
			{
				assertEquals(e.message, "started" , "IAction 02 notifyStarted method failed.") ;	
			}
	
		}	
		
		public function testRun():void
		{
			try
			{
				action.run() ;
			}	
			catch( e:Error )
			{
				assertEquals(e.message, "run" , "IAction run method failed.") ;	
			}
		}			
		
	}
}

import flash.events.EventDispatcher;

import andromeda.process.IAction;

class ConcreteAction extends EventDispatcher implements IAction
{

	public function clone():*
	{
		return new ConcreteAction() ;
	}
	
	public function notifyFinished():void
	{
		throw new Error("finished") ;
	}
	
	public function notifyStarted():void
	{
		throw new Error("started") ;
	}

	public function run(...arguments:Array):void
	{
		throw new Error("run") ;
	}
}