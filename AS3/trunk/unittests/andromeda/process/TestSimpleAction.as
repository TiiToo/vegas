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
	import flash.events.Event;
	
	import andromeda.events.ActionEvent;
	
	import buRRRn.ASTUce.framework.TestCase;
	
	import vegas.events.AbstractCoreEventDispatcher;	

	/**
	 * @author eKameleon
	 */
	public class TestSimpleAction extends TestCase 
	{

		public function TestSimpleAction(name:String = "")
		{
			super(name);
		}
		
		public var action:SimpleAction ;
		
        public function setUp():void
        {
            action = new SimpleAction() ;
        }
        
        public function tearDown():void
        {
            action = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( action, "Action constructor failed, the instance not must be null.") ;
            assertTrue( action is SimpleAction, "Action is SimpleAction failed.") ;
        }
        
        public function testInherit():void
        {
            assertTrue( action is AbstractCoreEventDispatcher , "Action inherit AbstractCoreEventDispatcher failed.") ;
            assertTrue( action is IAction , "Action implements the IAction interface" ) ;    	
        }   
                
        
        public function testClone():void
        {
            var clone:SimpleAction = action.clone() as SimpleAction ;
            assertNotNull( clone , "Action clone 01 method failed." ) ;
            assertFalse( clone == action  , "Action 02 clone method failed." ) ;
        }
        
        public function testRunning():void
        {
            assertFalse( action.running  , "Action running failed, default property value must be false." ) ;
        }	           
        
        public function testGetEventTypeFINISH():void
        {
            assertEquals( action.getEventTypeFINISH(), ActionEvent.FINISH,  "Action getEventTypeFINISH failed." ) ;
        }
        
        public function testGetEventTypeSTART():void
        {
            assertEquals( action.getEventTypeSTART(), ActionEvent.START,  "Action getEventTypeSTART failed." ) ;
        }	        
        
        public function testNotifyFinished():void
        {
            var isEvent:Boolean     = false ;
            var isDispatch:Boolean  = false ;
            var type:String         = null  ;
            
            var someHandler:Function = function( event:Event ):void 
            {
                   isDispatch  = true ;
                   isEvent     = event is ActionEvent ;
                   type        = event.type ;                   
               } ;
                   
            action.addEventListener( ActionEvent.FINISH , someHandler , false , 0 , true )  ;
            action.notifyFinished() ;
            action.removeEventListener( ActionEvent.FINISH, someHandler , false )  ;
                    
            assertTrue( isDispatch , "Action notifyFinished 01 failed, the ActionEvent.START event isn't notify" ) ;
            assertTrue( isEvent    , "Action notifyFinished 02 failed, the dispatched event isn't a ActionEvent" ) ;
            assertEquals( type , ActionEvent.FINISH , "Action notifyFinished 03 failed, the dispatched event type must be ActionEvent.FINISH." ) ;
        }
    
        public function testNotifyStarted():void
        {
            
            var isEvent:Boolean     = false ;
            var isDispatch:Boolean  = false ;
            var type:String         = null  ;
            
            var someHandler:Function = function( event:Event ):void 
            {
                isDispatch  = true ;
                isEvent     = event is ActionEvent ;
                type        = event.type ;                   
            };
                
            action.addEventListener( ActionEvent.START , someHandler , false , 0 , true )  ;
            action.notifyStarted() ;
            action.removeEventListener( ActionEvent.START, someHandler , false )  ;
                    
            assertTrue( isDispatch , "Action notifyStarted failed, the ActionEvent.START event isn't notify" ) ;
            assertTrue( isEvent    , "Action notifyStarted failed, the dispatched event isn't a ActionEvent" ) ;
            assertEquals( type , ActionEvent.START , "Action notifyStarted failed, the dispatched event type must be ActionEvent.START." ) ;
                    
        }    
        
        public function testRun():void
        {
            assertTrue( "run" in action           , "Action run 01 method exist." ) ;
            assertTrue( action["run"] is Function , "Action run 02 method exist." ) ;
        }     		
		

        public function testSetEventTypeFINISH():void
        {
        	action.setEventTypeFINISH( "type" );
            assertEquals( action.getEventTypeFINISH(), "type" ,  "Action setEventTypeFINISH failed." ) ;
            action.setEventTypeFINISH( ActionEvent.FINISH );
        }
        
        public function testSetEventTypeSTART():void
        {
        	action.setEventTypeSTART( "type" );
            assertEquals( action.getEventTypeSTART(), "type" ,  "Action setEventTypeSTART failed." ) ;
            action.setEventTypeSTART( ActionEvent.START );
        }		
		
	}
}
