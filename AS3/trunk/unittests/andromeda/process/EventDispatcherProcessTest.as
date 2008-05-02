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
	import andromeda.process.mocks.MockSimpleActionListener;
	
	import buRRRn.ASTUce.framework.TestCase;
	
	import vegas.errors.IllegalArgumentError;
	import vegas.events.BasicEvent;
	import vegas.events.FrontController;	

	/**
	 * @author eKameleon
	 */
	public class EventDispatcherProcessTest extends TestCase 
	{

		public function EventDispatcherProcessTest(name:String = "")
		{
			super(name);
		}
		
        public var action:EventDispatcherProcess ;		
		
		public var channel:String ;
		
		public var mockListener:MockSimpleActionListener ;			
		
        public function setUp():void
        {
        	channel = "myChannel" ;
        	FrontController.getInstance(channel).insert("test" , _testHandleEvent ) ;
            action       = new EventDispatcherProcess("test", channel ) ;
            mockListener = new MockSimpleActionListener( action ) ;
        }
        
        public function tearDown():void
        {
        	FrontController.getInstance().remove("test") ;
            mockListener.unregister() ;
            mockListener = undefined  ;
            action       = undefined  ;
            channel      = null       ;      
        }		
		
		public function testConstructor():void
		{
		
			var p:EventDispatcherProcess ;
		
			try
			{
				p = new EventDispatcherProcess(null) ;
				fail("constructor failed, the event argument not must be 'null' or 'undefined'.") ;
			}
			catch( e1:IllegalArgumentError )
			{
				// do nothing
				
			}
			catch( e2:Error )
			{
				fail("constructor failed, must throw an IllegalArgumentError object : " + e2 ) ;
			}
			
			p = new EventDispatcherProcess("test") ;			
			
			assertNotNull ( p , "constructor failed, The instance not must be null") ;
			assertTrue    ( p is SimpleAction , "constructor failed, the EventDispatcherProcess class must inherit SimpleAction.") ;
			assertNotNull ( p.event   , "constructor failed, the EventDispatcherProcess event property not must be null.") ;
			assertNull    ( p.channel , "constructor failed, the EventDispatcherProcess channel property must be null.") ;
			
		}
		
		public function testChannel():void
		{
			assertEquals( action.channel , channel , "The channel property failed.") ;
		}		
		
		public function testEvent():void
		{
			assertTrue( action.event is Event, "The event property failed, must inherit Event class.") ;
			assertTrue( action.event is BasicEvent , "The event property failed, must inherit BasicEvent class.") ;
		}	
		
		public function testClone():void
        {
        	var clone:EventDispatcherProcess = action.clone() ;
        	assertNotNull ( clone  , "clone method failed, with a null shallow copy object." ) ;
        	assertNotSame ( clone  , EventDispatcherProcess  , "clone method failed, the shallow copy isn't the same with the BatchProcess object." ) ;
        	assertSame    ( clone.channel , action.channel , "The channel of the clone must be the same in the EventDispatcherProcess object") ;
        	assertSame    ( clone.event, action.event , "The event of the clone must be the same in the EventDispatcherProcess object") ;
		}
        
        public function testRun():void
        {
        	action.run() ;
        	
        	assertTrue   ( mockListener.isRunning     , "The MockSimpleActionListener.isRunning property failed, must be true." ) ;
        	assertFalse  ( action.running             , "The running property of the BatchProcess must be false after the process." ) ;        
			
			assertTrue   ( mockListener.startCalled   , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals ( mockListener.startType     , ActionEvent.START   , "run method failed, bad type found when the process is started." );
            
            assertTrue   ( mockListener.finishCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals ( mockListener.finishType    , ActionEvent.FINISH  , "run method failed, bad type found when the process is finished." );
            
            assertTrue    ( _testHandleEventCalled , "The global event isn't dispatched in the global event flow with the FrontController") ;
            
        }

		/**
		 * @private
		 */
		private var _testHandleEventCalled:Boolean ;
		
		/**
		 * @private
		 */
		private function _testHandleEvent(e:Event):void
		{
			_testHandleEventCalled = true ;
		}
	
	}

}