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

/**
 * The EventPhase class provides values for the eventPhase property of the IEvent implementations. 
 * @author eKameleon
 */
package vegas.events.dom
{
	public class EventPhase
	{
		
	    /**
	     * The target phase, which is the second phase of the event flow (2).
	     */
		static public const AT_TARGET:uint = 2 ;
	    
	    /**
	     * The bubbling phase, which is the third phase of the event flow (3).
	     */
		static public const BUBBLING_PHASE:uint = 3 ;
	    
	   	/**
	     * The capturing phase, which is the first phase of the event flow (1).
	     */
		static public const CAPTURING_PHASE:uint = 1 ;
	
    	/**
		 * The default phase(0)
		 */
		static public const NONE:uint = 0 ;

    	/**
	     * Stop the phase in progress (8). Use only by the vegas.events.dom.IEvent and vegas.events.dom.EventDispatcher class.
	     */
		static public const STOP:uint = 8 ;

	    /**
	     * Stop the phase immediately (10). Use only by the vegas.events.dom.IEvent and vegas.events.dom.EventDispatcher class.
	     */
		static public const STOP_IMMEDIATE:uint = 10 ;
		
	}
}