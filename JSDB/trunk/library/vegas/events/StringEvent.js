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
 * The {@code StringEvent} to dispatch an event with an String object.
 * @author eKameleon
 */
if (vegas.events.StringEvent == undefined) 
{
	
	/**
	 * Creates a new {@code StringEvent} instance.
	 * @param type the string type of the instance.
	 * @param s The String object of this event. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	vegas.events.StringEvent = function 
	(
		type/*String*/ , s /*String*/, target/*Object*/ , context/*Object*/ , 
			p_bubbles /*String*/ , p_eventPhase /*String*/ , p_time /*String*/ , p_stop /*String*/
	) 
	{
		vegas.events.BasicEvent.apply(this, String.fromArguments(arguments)) ;
		this._str = s ;
	}
	
	/**
	 * @extends vegas.events.BasicEvent
	 */
	proto = vegas.events.StringEvent.extend( vegas.events.BasicEvent ) ;

 	/**
 	 * Returns a new clone reference.
	 * @return a new clone reference.
	 */
	proto.clone = function () 
	{
		return new vegas.events.StringEvent(this.getType(), this.getString(), this.getTarget(), this.getContext()) ;
	}
 
	/**
	 * Returns the String instance.
	 * @return the String instance.
	 */
	proto.getString = function () /*String*/ 
	{
		return this._str ;
	}

	/**
	 * Sets the String instance.
	 */
	proto.setString = function ( s /*String*/ ) /*void*/ 
	{
		this._str = s ;
	}

 	// encapsulate
	
	delete proto ;
	
}
