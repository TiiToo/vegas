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
 * The {@code BooleanEvent} to dispatch an event with an Boolean object.
 * @author eKameleon
 */
if (vegas.events.BooleanEvent == undefined) 
{
	
	/**
	 * Creates a new {@code BooleanEvent} instance.
	 * @param type the string type of the instance.
	 * @param b The Boolean object of this event. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	vegas.events.BooleanEvent = function 
	(
		type/*String*/ , b /*Boolean*/, target/*Object*/ , context/*Object*/ , 
			p_bubbles /*Boolean*/ , p_eventPhase /*Number*/ , p_time /*Number*/ , p_stop /*Number*/
	) 
	{
		vegas.events.BasicEvent.apply(this, Array.fromArguments(arguments)) ;
		this._b = b ;
	}
	
	/**
	 * @extends vegas.events.BasicEvent
	 */
	proto = vegas.events.BooleanEvent.extend( vegas.events.BasicEvent ) ;

 	/**
 	 * Returns a new clone reference.
	 * @return a new clone reference.
	 */
	proto.clone = function () 
	{
		return new vegas.events.BooleanEvent(this.getType(), this.getBoolean(), this.getTarget(), this.getContext()) ;
	}
 
	/**
	 * Returns the Boolean instance.
	 * @return the Boolean instance.
	 */
	proto.getBoolean = function () /*Boolean*/ 
	{
		return this._b ;
	}

	/**
	 * Sets the Boolean instance.
	 */
	proto.setBoolean = function ( b /*Boolean*/ ) /*void*/ 
	{
		this._b = b ;
	}

 	// encapsulate
	
	delete proto ;
	
}
