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
 * The {@code ValidatorEvent} to dispatch an event with a IValidator representation.
 * @author eKameleon
 */
if (vegas.events.ValidatorEvent == undefined) 
{

	/**
	 * Creates a new ValidatorEvent instance.
	 */
	vegas.events.ValidatorEvent = function(type/*String*/, target/*Object*/) 
	{
		vegas.events.DynamicEvent.apply(this, Array.fromArguments(arguments)) ;
	}

	/**
	 * The name of the event invoqued when the IValidator is invalid.
	 */
	vegas.events.ValidatorEvent.INVALID /*String*/ = "invalid" ;

	/**
	 * The name of the event invoqued when the IValidator is valid.
	 */
	vegas.events.ValidatorEvent.VALID /*String*/ = "valid" ;

	/**
	 * @extends vegas.events.DynamicEvent
	 */
	vegas.events.ValidatorEvent.extend( vegas.events.DynamicEvent ) ;
 
	/**
	 * Returns the shallow copy of this event.
	 * @return the shallow copy of this event.
	 */
	vegas.events.ValidatorEvent.prototype.clone = function () 
	{
		return new vegas.events.ValidatorEvent(this.getType() , this.getTarget()) ;
	}
	
}
