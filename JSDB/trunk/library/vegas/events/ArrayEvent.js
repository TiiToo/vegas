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
 * The {@code ArrayEvent} to dispatch an event with an array object.
 * @author eKameleon
 */
if (vegas.events.ArrayEvent == undefined) 
{
	
	/**
	 * Creates a new {@code ArrayEvent} instance.
	 * @param type the string type of the instance.
	 * @param ar The array object of this event. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	vegas.events.ArrayEvent = function 
	(
		type/*String*/ , ar /*Array*/, target/*Object*/ , context/*Object*/ , 
			p_bubbles /*Boolean*/ , p_eventPhase /*Number*/ , p_time /*Number*/ , p_stop /*Number*/
	) 
	{
		vegas.events.BasicEvent.apply(this, Array.fromArguments(arguments)) ;
		this._ar = ar ;
	}
	
	/**
	 * @extends vegas.events.BasicEvent
	 */
	proto = vegas.events.ArrayEvent.extend( vegas.events.BasicEvent ) ;

 	/**
 	 * Returns a new clone reference.
	 * @return a new clone reference.
	 */
	proto.clone = function () 
	{
		return new vegas.events.ArrayEvent(this.getType(), this.getArray(), this.getTarget(), this.getContext()) ;
	}
 
	/**
	 * Returns the array instance.
	 * @return the array instance.
	 */
	proto.getArray = function () /*Array*/ 
	{
		return this._ar ;
	}

	/**
	 * Sets the array instance.
	 */
	proto.setArray = function ( ar /*Array*/ ) /*void*/ 
	{
		this._ar = ar ;
	}
	
	/**
	 * The array of this event.
	 */
	proto._ar /*Array*/ = null ;

 	// encapsulate
	
	delete proto ;

	// ----o Register the class to AMF exchange.
 
 	/**
 	 * The ArrayEvent class (since the namespace) is used to register the ArrayEvent class and shared the event between the server and the client.
 	 * Adds the same implementation in all event class if you want use a typed shared event in your AMF call methods. 
 	 */
 	function ArrayEvent( type /*String*/  )
	{
		vegas.events.ArrayEvent.apply(this, Array.fromArguments(arguments) ) ;
	}

	ArrayEvent.extend( vegas.events.ArrayEvent )  ;

	/**
	 * This method is invoqued to register the BasicEvent class if you use a shared instance between the server and the client.
	 */
	ArrayEvent.register = function()
	{
		return application.registerClass("ArrayEvent", ArrayEvent) ;
	}

}