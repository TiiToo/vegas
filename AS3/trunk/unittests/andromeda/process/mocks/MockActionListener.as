﻿/*

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
package andromeda.process.mocks 
{
	import flash.events.IEventDispatcher;
	
	import andromeda.events.ActionEvent;
	import andromeda.process.IAction;	

	/**
     * This Mock object listen all events dispatched from a Action object.
     */
	public class MockActionListener extends MockSimpleActionListener
    {
        
        /**
         * Creates a new MockActionListener instance.
         * @param action The IAction of this mock to register.
         */
        public function MockActionListener( action:IAction=null )
		{
        	super( action ) ;
        }
        
        /**
         * Indicates if the ActionEvent.CHANGE event is invoked.
         */
        public var changeCalled:Boolean ;
        
        /**
         * Indicates the type of the change event notification.
         */        
        public var changeType:String ;
        
        /**
         * Indicates if the ActionEvent.CLEAR event is invoked.
         */
        public var clearCalled:Boolean ;

        /**
         * Indicates the type of the clear event notification.
         */     
        public var clearType:String ;

        /**
         * Indicates if the ActionEvent.INFO event is invoked.
         */
        public var infoCalled:Boolean ;
		
		/**
		 * The info object in the ActionEvent dispatched in the notifyInfo method of the Action.
		 */
		public var infoObject:* ;
		
        /**
         * Indicates the type of the info event notification.
         */     
        public var infoType:String ;

        /**
         * Indicates if the ActionEvent.LOOP event is invoked.
         */
        public var loopCalled:Boolean ;

        /**
         * Indicates the type of the loop event notification.
         */     
        public var loopType:String ;

        /**
         * Indicates if the ActionEvent.PAUSE event is invoked.
         */
        public var pauseCalled:Boolean ;

        /**
         * Indicates the type of the pause event notification.
         */     
        public var pauseType:String ;

        /**
         * Indicates if the ActionEvent.PROGRESS event is invoked.
         */
        public var progressCalled:Boolean ;           

        /**
         * Indicates the type of the progress event notification.
         */     
        public var progressType:String ;

        /**
         * Indicates if the ActionEvent.RESUME event is invoked.
         */
        public var resumeCalled:Boolean ;           

        /**
         * Indicates the type of the resume event notification.
         */     
        public var resumeType:String ;
        
        /**
         * Indicates if the ActionEvent.STOP event is invoked.
         */
        public var stopCalled:Boolean ;

        /**
         * Indicates the type of the stop event notification.
         */     
        public var stopType:String ;

        /**
         * Indicates if the ActionEvent.TIMEOUT event is invoked.
         */
        public var timeoutCalled:Boolean ;

        /**
         * Indicates the type of the timeout event notification.
         */     
        public var timeoutType:String ;

        /**
         * Invoked when the ActionEvent.CHANGED event is dispatched.
         */
        public function onChange( e:ActionEvent ):void
        {
            changeCalled = true ;
            changeType   = e.type ;
        }

        /**
         * Invoked when the ActionEvent.CLEAR event is dispatched.
         */
        public function onClear( e:ActionEvent ):void
        {
            clearCalled = true ;
            clearType   = e.type ;
        }
       
        /**
         * Invoked when the ActionEvent.INFO event is dispatched.
         */
        public function onInfo( e:ActionEvent ):void
        {
            infoCalled = true ;
            infoType   = e.type ;
            infoObject = e.info ;
        }       
        
        /**
         * Invoked when the ActionEvent.INFO event is dispatched.
         */
        public function onLoop( e:ActionEvent ):void
        {
            loopCalled = true ;
            loopType   = e.type ;
        }              
       
        /**
         * Invoked when the ActionEvent.PAUSE event is dispatched.
         */
        public function onPause( e:ActionEvent ):void
        {
            pauseCalled = true ;
            pauseType   = e.type ;
        }          
       
        /**
         * Invoked when the ActionEvent.PROGRESS event is dispatched.
         */
        public function onProgress( e:ActionEvent ):void
        {
            progressCalled = true ;
            progressType   = e.type ;
        }          

        /**
         * Invoked when the ActionEvent.RESUME event is dispatched.
         */
        public function onResume( e:ActionEvent ):void
        {
            resumeCalled = true ;
            resumeType   = e.type ;
        }
               
        /**
         * Invoked when the ActionEvent.STOP event is dispatched.
         */
        public function onStop( e:ActionEvent ):void
        {
            stopCalled = true ;
            stopType   = e.type ;
        }
        
        /**
         * Invoked when the ActionEvent.TIMEOUT event is dispatched.
         */
        public function onTimeOut( e:ActionEvent ):void
        {
            timeoutCalled = true ;
            timeoutType   = e.type ;
        }        
            
        /**
         * Registers all events of the object.
         */
        public override function register( action:IAction ):void
        {
        	
        	super.register( action ) ;
        	
            action.addEventListener( ActionEvent.CHANGE    , onChange    , false , 0 , true ) ;
            action.addEventListener( ActionEvent.CLEAR     , onClear     , false , 0 , true ) ;
            action.addEventListener( ActionEvent.INFO      , onInfo      , false , 0 , true ) ;
            action.addEventListener( ActionEvent.LOOP      , onLoop      , false , 0 , true ) ;
            action.addEventListener( ActionEvent.PAUSE     , onPause     , false , 0 , true ) ;
            action.addEventListener( ActionEvent.PROGRESS  , onProgress  , false , 0 , true ) ;
            action.addEventListener( ActionEvent.RESUME    , onResume    , false , 0 , true ) ;
            action.addEventListener( ActionEvent.STOP      , onStop      , false , 0 , true ) ;
            action.addEventListener( ActionEvent.TIMEOUT   , onTimeOut   , false , 0 , true ) ;
            
        }
                
        /**
         * Unregisters all events of the action register in this mock.
         */
        public override function unregister():void
        {
        	if ( action != null )
        	{
            	action.removeEventListener( ActionEvent.CHANGE    , onChange   , false ) ;
            	action.removeEventListener( ActionEvent.CLEAR     , onClear    , false ) ;
            	action.removeEventListener( ActionEvent.INFO      , onInfo     , false ) ;
            	action.removeEventListener( ActionEvent.LOOP      , onLoop     , false ) ;
            	action.removeEventListener( ActionEvent.PAUSE     , onPause    , false ) ;
            	action.removeEventListener( ActionEvent.PROGRESS  , onProgress , false ) ;
            	action.removeEventListener( ActionEvent.RESUME    , onResume   , false ) ;
            	action.removeEventListener( ActionEvent.STOP      , onStop     , false ) ;
            	action.removeEventListener( ActionEvent.TIMEOUT   , onTimeOut  , false ) ;
            	super.unregister() ;
        	}
        }    
    
	}

}