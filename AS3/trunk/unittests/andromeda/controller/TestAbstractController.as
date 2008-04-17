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
	public class TestAbstractController extends TestCase 
	{

		public function TestAbstractController(name:String = "")
		{
			super(name);
		}
		
		public var controller:ConcreteAbstractController ;
		
        public function setUp():void
        {
			controller = new ConcreteAbstractController() ;
        }
        
        public function tearDown():void
        {
			controller = null ;
        }			

		public function testInherit():void
		{
			assertNotNull( controller , "AbstractController 01 test instance not must be null." ) ;
			assertTrue( controller is IController	, "AbstractController 02 IController implementation failed." ) ;
			assertTrue( controller is EventListener	, "AbstractController 032 EventListener implementation failed." ) ;
		}

		public function testHandleEvent():void
		{
			try
			{
				controller.handleEvent( new Event("type") ) ;
				fail("AbstractController 01 handleEvent method failed.") ;
			}
			catch( e:Error )
			{
				assertEquals(e.message, "handleEvent" , "AbstractController 02 handleEvent method failed.") ;
			}
		}			
		
	}
}

import flash.events.Event;

import andromeda.controller.AbstractController;

class ConcreteAbstractController extends AbstractController
{

	/**
	 * Handles the event.
	 */
	public override function handleEvent(e:Event):void
	{
		throw new Error("handleEvent") ;
	}
}
