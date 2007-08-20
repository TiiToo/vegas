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

package vegas.events 
{
    
    import flash.events.Event ;
    
    /**
     * The {@code NumberEvent} to dispatch an event with a Number object.
     * @author eKameleon
     */
	public class NumberEvent extends BasicEvent 
	{
        
		/**
		 * Creates a new {@code NumberEvent} instance.
		 * @param type the string type of the instance. 
		 * @param n the Number object of this event. 
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 	 */
		public function NumberEvent(type : String, n:Number = NaN ,target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			super(type, target, context, bubbles, cancelable, time) ;
			_n = n ;
		}
        
		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new NumberEvent(type, getNumber(), target, context) ;
		}
		
        /**
    	 * Returns the Number value.
    	 * @return the Number value.
    	 */
    	public function getNumber():Number
	    {
    		return _n ;	
    	}
        
        /**
         * Sets the Number value.
         */
        public function setNumber(n:Number):void
        {
            _n = n ;	
        }
        
        /**
         * The internal Number value.
         */
		private var _n:Number ;	
        
    }
		
}
