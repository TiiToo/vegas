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
 * This static enumeration indicated the names of the events in a ITimer instance.
 * @author eKameleon
 * @see Timer
 * @see FrameTimer
 * @see TimerEvent
 */
if (vegas.events.TimerEventType == undefined) 
{
	
	/**
	 * Creates the TimerEventType singleton.
	 */
	vegas.events.TimerEventType = {} ;

	/**
	 * The name of the event when the ITimer instance restart.
	 */
 	vegas.events.TimerEventType.RESTART /*String*/ = "restart" ;

	/**
	 * The name of the event when the ITimer instance start.
	 */
	vegas.events.TimerEventType.START /*String*/ = "start" ;

	/**
	 * The name of the event when the ITimer instance stop.
	 */
	vegas.events.TimerEventType.STOP /*String*/ = "stop" ;

	/**
	 * The name of the event when the ITimer instance complete this timer.
	 */
	vegas.events.TimerEventType.TIMER /*String*/ = "timer" ;

}