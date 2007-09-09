﻿/*

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

package pegas.events
{
	
	import flash.events.Event ;
	import vegas.events.BasicEvent ;

    /**
     * The ActionEvent is notify by all the objects who implements the Action interface.
     * @author eKameleon
     */
    public class ActionEvent extends BasicEvent
	{
		
		/**
		 * Creates a new {@code BasicEvent} instance.
		 * {@code
		 * var e:BasicEvent = new BasicEvent( type:String, [target:Object, [context:*, [bubbles:Boolean, [cancelable:Boolean, [time:Number]]]]]) ;
	 	 * }
		 * @param type the string type of the instance. 
		 * @param target the target of the event.
		 * @param info The information object of this event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 	 */
		public function ActionEvent( type:String , target:Object = null, info:* = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			super(type, target, context, bubbles, cancelable, time) ;
			_oInfo = info ;
		}
        
        /**
         * The name of the event when the process is changed.
         */
		static public const CHANGE:String = "onChanged" ;

        /**
         * The name of the event when the process is cleared.
         */
		static public const CLEAR:String = "onCleared" ;
        
        /**
         * The name of the event when the process is finished.
         */
		static public const FINISH:String = "onFinished" ;

        /**
         * The name of the event when the process info is changed.
         */
		static public const INFO:String = "onInfo" ;

        /**
         * The name of the event when the process is looped.
         */
		static public const LOOP:String = "onLooped" ;

        /**
         * The name of the event when the process is in progress.
         */
		static public const PROGRESS:String = "onProgress" ;

        /**
         * The name of the event when the process is resumed.
         */
		static public const RESUME:String = "onResumed" ;

        /**
         * The name of the event when the process is started.
         */		
		static public const START:String = "onStarted" ;

        /**
         * The name of the event when the process is stopped.
         */		
		static public const STOP:String = "onStopped" ;	

        /**
         * The name of the event when the process is cleared.
         */		
		static public const TIMEOUT:String = "onTimeOut" ;
	    
	    /**
    	 * (read-only) Returns the info object of this event.
    	 * @return the info object of this event.
    	 */
	    public function get info():*
	    {
	        return getInfo() ;
	    }
	    
	    /**
    	 * Returns the shallow copy of this object.
    	 * @return the shallow copy of this object.
    	 */
		public override function clone():Event 
		{
			return new ActionEvent( type, target, getInfo(), context ) ;
		}

    	/**
    	 * Returns the info object of this event.
    	 * @return the info object of this event.
    	 */
		public function getInfo():* 
		{
			return _oInfo ;
		}

        /**
	     * Sets the info object of this event.
	     */
		public function setInfo( oInfo:* ):void 
		{
			_oInfo = oInfo ;	
		}
		
		private var _oInfo:* ;
		
	}
}