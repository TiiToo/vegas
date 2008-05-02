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
package andromeda.controller 
{
	import flash.events.Event;
	
	import buRRRn.ASTUce.framework.TestCase;
	
	import vegas.events.EventListener;	

	/**
	 * @author eKameleon
	 */
	public class IControllerTest extends TestCase 
	{
		
		public function IControllerTest(name:String = "")
		{
			super(name);
		}

		public var controller:ConcreteController ;
		
        public function setUp():void
        {
			controller = new ConcreteController() ;
        }
        
        public function tearDown():void
        {
			controller = null ;
        }			

		public function testInherit():void
		{
			assertNotNull( controller , "IController 01 test instance not must be null." ) ;
			assertTrue( controller is EventListener	, "IController 02 EventListener implementation failed." ) ;
		}

		public function testHandleEvent():void
		{
			try
			{
				controller.handleEvent( new Event("type") ) ;
				fail("IController 01 handleEvent method failed.") ;
			}
			catch( e:Error )
			{
				assertEquals(e.message, "handleEvent" , "IController 02 handleEvent method failed.") ;
			}
		}		
		
	}
}

import flash.events.Event;

import andromeda.controller.IController;

class ConcreteController implements IController
{

	/**
	 * Handles the event.
	 */
	public function handleEvent(e:Event):void
	{
		throw new Error("handleEvent") ;
	}
}

