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
 * The EventPhase class provides values for the eventPhase property of the Event class. This class used a polymorphism with AS3 API flash.events.EventPhase class.
 * @author eKameleon
 */
class vegas.events.EventPhase 
{

	/**
	 * The target phase, which is the second phase of the event flow (2).
	 */
	public static var AT_TARGET:Number = 2 ;
	
	/**
	 * The bubbling phase, which is the third phase of the event flow (3).
	 */
	public static var BUBBLING_PHASE:Number = 3 ;
	
	/**
	 * The capturing phase, which is the first phase of the event flow (1).
	 */
	public static var CAPTURING_PHASE:Number = 1 ;
	
	/**
	 * The default phase(0)
	 */
	public static var NONE:Number = 0 ;
	
	/**
	 * Stop the phase in progress (8). Use only by the Event and EventDispatcher class.
	 */
	public static var STOP:Number = 8 ;
	
	/**
	 * Stop the phase immediately (10). Use only by the Event and EventDispatcher class.
	 */
	public static var STOP_IMMEDIATE:Number = 10 ;
	
	
	private static var __ASPF__ = _global.ASSetPropFlags(EventPhase, null , 7, 7) ;
	
}

