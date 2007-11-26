/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.events.DynamicEvent;

/**
 * The SystemEvent dispatched by the SystemAnalyser singleton.
 * @author eKameleon
 */
class asgard.system.SystemEvent extends DynamicEvent 
{

	/**
	 * Creates a new SystemEvent instance.
	 * @param target the target of the event.
	 * @param property The property name.
	 * @param value The property value.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	public function SystemEvent(target, property, value, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number)
	{
		super( VIEW_SYSTEM_EVENT , target, context, bubbles, eventPhase, time, stop) ;
		_property = property || null ;
		_value = value || null ;
	}

	/**
	 * The name of the event dispatched by the run method of the SystemAnalyser singleton.
	 */
	public static var VIEW_SYSTEM_EVENT:String = "viewSystem" ;
	
	/**
	 * Returns a shallow copy of this event.
	 * @return a shallow copy of this event.
	 */
	public function clone() 
	{
		return new SystemEvent( getTarget() , getProperty(), getValue(), getContext() ) ;
	}
	
	/**
	 * Returns the system property.
	 * @return the system property.
	 */
	public function getProperty():String
	{
		return _property ;
	}

	/**
	 * Returns the sytem value.
	 * @return the sytem value.
	 */
	public function getValue() 
	{
		return _value ;
	}

	private var _property:String ;
	
	private var _value ;
	
}
