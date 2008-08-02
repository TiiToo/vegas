﻿/*

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
	import andromeda.events.ActionEvent;
	import andromeda.process.mocks.MockAction;
	import andromeda.process.mocks.MockActionListener;
	import andromeda.process.mocks.MockSimpleActionListener;
	
	import buRRRn.ASTUce.framework.TestCase;	

	/**
     * @author eKameleon
     */
    public class ActionTest extends TestCase 
    {

        public function ActionTest(name:String = "")
        {
            super(name);
        }

        public var action:MockAction ;
        
		public var mockListener:MockActionListener ;	        
        
        public function setUp():void
        {

            action = new MockAction() ;

			mockListener = new MockActionListener(action) ;
			
			action.notifyAll() ;

		}

		public function tearDown():void
        {
        	mockListener.unregister() ;
			mockListener = undefined ;
			action       = undefined ;
        }
        
        public function testClone():void
        {
            var clone:Action = action.clone() as Action ;
            assertNotNull( clone , "Action clone 01 method failed." ) ;
            assertFalse( clone == action  , "Action 02 clone method failed." ) ;
        }

        public function testNotifyChanged():void
        {
            assertTrue   ( mockListener.changeCalled , "notify event method failed, the ActionEvent.CHANGE event isn't notify" ) ;
            assertEquals ( mockListener.changeType   , ActionEvent.CHANGE  , "notify event method failed, bad type found when the process is changed." );
        }

        public function testNotifyCleared():void
        {
            assertTrue   ( mockListener.clearCalled , "notify event method failed, the ActionEvent.CLEAR event isn't notify" ) ;
            assertEquals ( mockListener.clearType   , ActionEvent.CLEAR  , "notify event method failed, bad type found when the process is cleared." );
        }
        
        public function testNotifyFinished():void
        {
			assertTrue   ( mockListener.finishCalled , "notify event method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals ( mockListener.finishType   , ActionEvent.FINISH  , "notify event method failed, bad type found when the process is finished." );
        }

        public function testNotifyInfo():void
        {
            assertTrue   ( mockListener.infoCalled , "notify event method failed, the ActionEvent.INFO event isn't notify" ) ;
            assertEquals ( mockListener.infoType   , ActionEvent.INFO  , "notify event method failed, bad type found when the process info change." );
            assertEquals ( mockListener.infoObject , "hello world"  , "notify event method failed, bad info object." );
        }

        public function testNotifyLooped():void
        {
            assertTrue   ( mockListener.loopCalled , "notify event method failed, the ActionEvent.LOOP event isn't notify" ) ;
            assertEquals ( mockListener.loopType   , ActionEvent.LOOP  , "notify event method failed, bad type found when the process is looped." );
        }

        public function testNotifyProgress():void
        {
            assertTrue   ( mockListener.progressCalled , "notify event method failed, the ActionEvent.PROGRESS event isn't notify" ) ;
            assertEquals ( mockListener.progressType   , ActionEvent.PROGRESS  , "notify event method failed, bad type found when the process is in progress." );
        }

        public function testNotifyResumed():void
        {
            assertTrue   ( mockListener.resumeCalled , "notify event method failed, the ActionEvent.RESUME event isn't notify" ) ;
            assertEquals ( mockListener.resumeType   , ActionEvent.RESUME  , "notify event method failed, bad type found when the process is resumed." );
        }
        
	    public function testNotifyStarted():void
	    {       
    		assertTrue   ( mockListener.startCalled , "notify event method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals ( mockListener.startType   , ActionEvent.START   , "notify event method failed, bad type found when the process is started." );                    
        }

	    public function testNotifyStopped():void
	    {       
    		assertTrue   ( mockListener.stopCalled , "notify event method failed, the ActionEvent.STOP event isn't notify" ) ;
            assertEquals ( mockListener.stopType   , ActionEvent.STOP   , "notify event method failed, bad type found when the process is stopped." );                    
        }

	    public function testNotifyTimeOut():void
	    {       
    		assertTrue   ( mockListener.timeoutCalled , "notify event method failed, the ActionEvent.TIMEOUT event isn't notify" ) ;
            assertEquals ( mockListener.timeoutType   , ActionEvent.TIMEOUT   , "notify event method failed, bad type found when the process is out of time." );                    
        }
        
        public function testRun():void
        {
        	action.run() ;
            assertEquals( MockAction.COUNT , 1 , "Action run failed." ) ;
        }         
        
    }

            
}

