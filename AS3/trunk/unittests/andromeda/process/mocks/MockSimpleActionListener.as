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
package andromeda.process.mocks 
{
	import flash.events.IEventDispatcher;
	
	import andromeda.events.ActionEvent;	

	/**
     * This Mock object listen all events dispatched from a Action object.
     */
	public class MockSimpleActionListener 
    {
    
        /**
         * Creates a new MockSimpleActionListener instance.
         */
        public function MockSimpleActionListener()
        {
        
        }
          
        /**
         * Indicates if the ActionEvent.FINISH event is invoked.
         */
        public var finishCalled:Boolean ;
        
        /**
         * Indicates the type of the finish event notification.
         */     
        public var finishType:String ;
        
        /**
         * Indicates if the ActionEvent.CALLED event is invoked.
         */
        public var startCalled:Boolean ;
        
        /**
         * Indicates the type of the start event notification.
         */     
        public var startType:String ;
        
        /**
         * Invoked when the ActionEvent.FINISH event is dispatched.
         */
        public function onFinish( e:ActionEvent ):void
        {
            finishCalled = true ;
            finishType   = e.type ;
        }
       
        /**
         * Invoked when the ActionEvent.FINISH event is dispatched.
         */
        public function onStart( e:ActionEvent ):void
        {
            startCalled = true ;
            startType   = e.type ;
        }
        
        /**
         * Registers all events of the object.
         */
        public function register( dispatcher:IEventDispatcher ):void
        {
        	dispatcher.addEventListener( ActionEvent.FINISH , onFinish , false , 0 , true ) ;
        	dispatcher.addEventListener( ActionEvent.START  , onStart , false , 0 , true ) ;
        }
                
        /**
         * Unregisters all events of the object.
         */
        public function unregister( dispatcher:IEventDispatcher ):void
        {
            dispatcher.removeEventListener( ActionEvent.FINISH , onFinish , false ) ;
            dispatcher.removeEventListener( ActionEvent.START  , onStart  , false ) ;
        }
        
    }

}
