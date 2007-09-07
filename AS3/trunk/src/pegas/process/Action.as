/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.process
{
    
	import pegas.events.ActionEvent;
	
    /**
     * This class simplify a full implementation of the {@code Action} interface.
     * @author eKameleon
     */
	public class Action extends SimpleAction
	{
		
		/**
		 * Creates a new Action instance.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
		public function Action( bGlobal:Boolean = false , sChannel:String = null )
		{
			super( bGlobal, sChannel ) ;	
		}

	    /**
    	 * The flag to determinate if the Action object is looped.
    	 */
		public var looping:Boolean ;
	
    	/**
    	 * Returns a shallow copy of this object.
    	 * @return a shallow copy of this object.
    	 */
		public override function clone():*
		{
			return new Action() ;
		}
		
		/**
		 * Returns the event name use in the notifyChanged method.
		 * @return the event name use in the notifyChanged method.
		 */
		public function getEventTypeCHANGE():String
		{
			return _eChange.type ;
		}
        
		/**
		 * Returns the event name use in the notifyCleared method.
		 * @return the event name use in the notifyCleared method.
		 */
		public function getEventTypeCLEAR():String
		{
			return _eClear.type ;
		}
        
		/**
		 * Returns the event name use in the notifyInfo method.
		 * @return the event name use in the notifyInfo method.
		 */
		public function getEventTypeINFO():String
		{
			return _eInfo.type ;
		}
        
        /**
		 * Returns the event name use in the notifyLooped method.
		 * @return the event name use in the notifyLooped method.
		 */
		public function getEventTypeLOOP():String
		{
			return _eLoop.type ;
		}
        
        /**
		 * Returns the event name use in the notifyProgress method.
		 * @return the event name use in the notifyProgress method.
		 */
		public function getEventTypePROGRESS():String
		{
			return _eProgress.type ;
		}
		
		/**
		 * Returns the event name use in the notifyResumed method.
		 * @return the event name use in the notifyResumed method.
		 */
		public function getEventTypeRESUME():String
		{
			return _eResume.type ;
		}
		
		/**
		 * Returns the event name use in the notifyStopped method.
		 * @return the event name use in the notifyStopped method.
		 */
		public function getEventTypeSTOP():String
		{
			return _eStop.type ;
		}
		
		/**
		 * Returns the event name use in the notifyTimeOut method.
		 * @return the event name use in the notifyTimeOut method.
		 */
		public function getEventTypeTIMEOUT():String
		{
			return _eTimeout.type ;
		}
		
        /**
         * Initialize the internal events of this process.
         */
        public override function initEvent():void
        {
            super.initEvent() ;
			_eChange   = new ActionEvent( ActionEvent.CHANGE   , this ) ;
			_eClear    = new ActionEvent( ActionEvent.CLEAR    , this ) ;
			_eInfo     = new ActionEvent( ActionEvent.INFO     , this ) ;
			_eLoop     = new ActionEvent( ActionEvent.LOOP     , this ) ;
			_eProgress = new ActionEvent( ActionEvent.PROGRESS , this ) ;
			_eResume   = new ActionEvent( ActionEvent.RESUME   , this ) ;
			_eStop     = new ActionEvent( ActionEvent.STOP     , this ) ;
			_eTimeout  = new ActionEvent( ActionEvent.TIMEOUT  , this ) ;
        }

	    /**
	     * Notify an ActionEvent when the process is changed.
	     */
		protected function notifyChanged():void 
		{
			dispatchEvent(_eChange) ;
		}

	    /**
	     * Notify an ActionEvent when the process is cleared.
	     */
		protected function notifyCleared():void 
		{
			dispatchEvent(_eClear) ;
		}	

	    /**
	     * Notify an ActionEvent when the process info is changed.
	     */
		protected function notifyInfo( info:* ):void
		{
		    _eInfo.setInfo( info ) ;
			dispatchEvent(_eInfo) ;
		}

	    /**
	     * Notify an ActionEvent when the process is looped.
	     */
		protected function notifyLooped():void 
		{
			dispatchEvent(_eLoop) ;
		}

	    /**
	     * Notify an ActionEvent when the process is in progress.
	     */
		protected function notifyProgress():void
		{
			dispatchEvent(_eProgress) ;
		}

	    /**
	     * Notify an ActionEvent when the process is resumed.
	     */
		protected function notifyResumed():void
		{
			dispatchEvent(_eResume) ;
		}

	    /**
	     * Notify an ActionEvent when the process is stopped.
	     */
		protected function notifyStopped():void
		{
			dispatchEvent(_eStop) ;
		}

	    /**
	     * Notify an ActionEvent when the process is out of time.
	     */
		protected function notifyTimeOut():void
		{
			dispatchEvent(_eTimeout) ;
		}
		
		/**
		 * Sets the event name use in the notifyChanged method.
		 */
		public function setEventTypeCHANGE( type:String ):void
		{
			_eChange.type = type || ActionEvent.CHANGE ;
		}
        
		/**
		 * Sets the event name use in the notifyCleared method.
		 */
		public function setEventTypeCLEAR( type:String ):void
		{
			_eClear.type = type || ActionEvent.CLEAR ;
		}
        
		/**
		 * Sets the event name use in the notifyInfo method.
		 */
		public function setEventTypeINFO( type:String ):void
		{
			_eInfo.type = type || ActionEvent.INFO ;
		}
        
        /**
		 * Sets the event name use in the notifyLooped method.
		 */
		public function setEventTypeLOOP( type:String ):void
		{
			_eLoop.type = type || ActionEvent.LOOP ;
		}
        
        /**
		 * Sets the event name use in the notifyProgress method.
		 */
		public function setEventTypePROGRESS( type:String ):void
		{
			_eProgress.type = type || ActionEvent.PROGRESS ;
		}
		
		/**
		 * Sets the event name use in the notifyResumed method.
		 */
		public function setEventTypeRESUME( type:String ):void
		{
			_eResume.type = type || ActionEvent.RESUME ;
		}
		
		/**
		 * Sets the event name use in the notifyStopped method.
		 */
		public function setEventTypeSTOP( type:String ):void
		{
			_eStop.type = type || ActionEvent.STOP ;
		}
		
		/**
		 * Sets the event name use in the notifyTimeOut method.
		 */
		public function setEventTypeTIMEOUT( type:String ):void
		{
			_eTimeout.type = type || ActionEvent.TIMEOUT ;
		}

    	private var _eChange:ActionEvent ;

    	private var _eClear:ActionEvent ;

    	private var _eInfo:ActionEvent ;

    	private var _eLoop:ActionEvent ;

    	private var _eProgress:ActionEvent ;

    	private var _eResume:ActionEvent ;

    	private var _eStop:ActionEvent ;

    	private var _eTimeout:ActionEvent ;

	}

}