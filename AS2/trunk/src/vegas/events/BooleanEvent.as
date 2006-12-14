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
 * The {@code BooleanEvent} to dispatch an event with a boolean object.
 * @author eKameleon
 */
class vegas.events.BooleanEvent extends DynamicEvent 
{
	
	/**
	 * Creates a new BooleanEvent instance.
	 */
	public function BooleanEvent(type:String, b:Boolean, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		
		super(type, target, context, bubbles, eventPhase, time, stop);
		_b = b ;
		
	}

	/**
	 * Creates and returns a shallow copy of this instance.
	 */
	public function clone() 
	{
		return new BooleanEvent(getType(), getBoolean(), getTarget(), getContext()) ;
	}
	
	/**
	 * Returns the boolean instance.
	 */
	public function getBoolean():Boolean
	{
		return _b ;	
	}
	
	/**
	 * Sets the boolean instance.
	 */
	public function setBoolean(b:Boolean):Void
	{
		_b = b ;	
	}
	
	/**
	 * The internal boolean instance.
	 */
	private var _b:Boolean ;

}