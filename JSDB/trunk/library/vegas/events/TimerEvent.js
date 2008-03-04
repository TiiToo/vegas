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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * The {@code TimerEvent} to dispatch an event with a ITimer representation.
 * @author eKameleon
 * @see vegas.util.FrameTimer
 * @see vegas.util.Timer
 */
if (vegas.events.TimerEvent == undefined) 
{
	
	/**
	 * Creates a new TimerEvent instance.
	 */
	vegas.events.TimerEvent = function(type/*String*/, target/*Object*/, context/*Object*/) 
	{
		vegas.events.DynamicEvent.apply(this, Array.fromArguments(arguments)) ;
	}
	
	/**
	 * @extends vegas.events.DynamicEvent
	 */
	vegas.events.TimerEvent.extend( vegas.events.DynamicEvent ) ;
 
	/**
	 * The name of the event when the ITimer instance restart.
	 */
 	vegas.events.TimerEvent.RESTART /*String*/ = "restart" ;

	/**
	 * The name of the event when the ITimer instance start.
	 */
	vegas.events.TimerEvent.START /*String*/ = "start" ;

	/**
	 * The name of the event when the ITimer instance stop.
	 */
	vegas.events.TimerEvent.STOP /*String*/ = "stop" ;

	/**
	 * The name of the event when the ITimer instance complete this timer.
	 */
	vegas.events.TimerEvent.TIMER /*String*/ = "timer" ;
 
	/**
	 * Returns the shallow copy of this event.
	 * @return the shallow copy of this event.
	 */
	vegas.events.TimerEvent.prototype.clone = function () 
	{
		return new vegas.events.TimerEvent(this.getType() , this.getTarget()) ;
	}
	
}
