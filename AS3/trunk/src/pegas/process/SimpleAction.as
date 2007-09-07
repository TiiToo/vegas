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
	
	import vegas.events.AbstractCoreEventDispatcher;
	
    /**
     * A simple representation of the {@code IAction} interface.
     * @author eKameleon
     */
	public class SimpleAction extends AbstractCoreEventDispatcher implements IAction
	{
	
	    /**
    	 * Creates a new SimpleAction instance.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
    	 */
    	function SimpleAction( bGlobal:Boolean = false , sChannel:String = null ) 
    	{
		    super(bGlobal, sChannel);		
            initEvent() ;
	    }

	    /**
	     * (read-only) Returns {@code true} if the process is in progress.
	     * @return {@code true} if the process is in progress.
	     */
		public function get running():Boolean 
		{
			return getRunning() ;	
		}

	    /**
	     * Returns a shallow copy of this object.
	     * @return a shallow copy of this object.
	     */
		public function clone():*
		{
			return new SimpleAction() ;
		}

		/**
		 * Returns the event name use in the notifyFinished method.
		 * @return the event name use in the notifyFinished method.
		 */
		public function getEventTypeFINISH():String
		{
			return _eFinish.type ;
		}
		
		/**
		 * Returns the event name use in the notifyStarted method.
		 * @return the event name use in the notifyStarted method.
		 */
		public function getEventTypeSTART():String
		{
			return _eStart.type ;
		}
		
		/**
	     * Returns {@code true} if the process is in progress.
	     * @return {@code true} if the process is in progress.
	     */
		public function getRunning():Boolean 
		{
			return _isRunning ;	
		}
        
        /**
         * Initialize the internal events of this process.
         */
        public function initEvent():void
        {
            _eFinish = new ActionEvent(ActionEvent.FINISH , this) ;
		    _eStart  = new ActionEvent(ActionEvent.START  , this) ;
        }
        
	    /**
	     * Notify an ActionEvent when the process is finished.
	     */
		public function notifyFinished():void 
		{
			dispatchEvent(_eFinish) ;
		}

    	/**
	     * Notify an ActionEvent when the process is started.
	     */
		public function notifyStarted():void
		{
			dispatchEvent(_eStart) ;
		}
		
    	/**
	     * Run the process.
	     */
		public function run( ...arguments:Array ):void 
		{
		    // overrides this method.
		}

	    /**
	     * This protected method is an internal method to change the running property value.
	     */
		protected function setRunning(b:Boolean):void
		{
			_isRunning = b ;	
		}

		/**
		 * Sets the event name use in the notifyFinished method.
		 */
		public function setEventTypeFINISH( type:String ):void
		{
			_eFinish.type = type || ActionEvent.FINISH ;
		}
		/**
		 * Sets the event name use in the notifyStarted method.
		 */
		public function setEventTypeSTART( type:String ):void
		{
			_eStart.type = type || ActionEvent.START ;
		}

	    private var _eFinish:ActionEvent ;

	    private var _eStart:ActionEvent ;

	    private var _isRunning:Boolean ;

	}

}