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

import vegas.events.DynamicEvent;

/**
 * The {@code StringEvent} to dispatch an event with a string object.
 * @author eKameleon
 */
class vegas.events.StringEvent extends DynamicEvent 
{
	
	/**
	 * Creates a new StringEvent instance.
	 * @param type the string type of the instance. 
	 * @param str The string value of this event.
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	public function StringEvent(type:String, str:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		super(type, target, context, bubbles, eventPhase, time, stop);
		if ( str != null )
		{
			_str = str ;
		}
	}

	/**
	 * Creates and returns a shallow copy of this instance.
	 * @return a shallow copy of this instance.
	 */
	public function clone() 
	{
		return new StringEvent(getType(), getString(), getTarget(), getContext()) ;
	}
	
	/**
	 * Returns the string instance.
	 */
	public function getString():String
	{
		return _str ;	
	}
	
	/**
	 * Sets the string instance.
	 */
	public function setString(s:String):Void
	{
		_str = s ;	
	}
	
	/**
	 * The internal string instance.
	 */
	private var _str:String ;

}