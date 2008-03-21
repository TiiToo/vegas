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
 * {@code BasicEvent} is the dynamic event structure to work with {@link EventDispatcher} and {@link FastDispatcher}.
 * <p><b>Example</b></p>
 * {@code
 * var EventType = vegas.events.EventType ;
 * var e = new vegas.events.DynamicEvent(EventType.CHANGE, this, "Hello World") ;
 * trace("> " + e) ;
 * trace("> target : " + e.target) ;
 * trace("> type : " + e.type) ;
 * trace("> context : " + e.context) ;
 * trace("> timeStamp : " + new Date(e.timeStamp) ) ;
 * }
 * @author  eKameleon
 * @see     CoreObject	
 * @see     Event	
 */
if (vegas.events.DynamicEvent == undefined) 
{
	
	/**
	 * @requires vegas.util.factory.PropertyFactory
	 */
	require("vegas.util.factory.PropertyFactory") ;
	
	/**
	 * Constructs a new {@code DynamicEvent} instance.
	 * <p>
	 * {@code
	 *     var e:DynamicEvent = new DynamicEvent(type, target, context, [bubbles:Boolean, [eventPhase:Number, [time:Number, [stop:Boolean]]]]) ;
	 * }
	 * </p>
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	vegas.events.DynamicEvent = function 
	(
		
		type/*String*/ , target/*Object*/ , context/*Object*/ 
		, p_bubbles /*Boolean*/ , p_eventPhase /*Number*/ , p_time /*Number*/ , p_stop /*Number*/
		
	) 
	{
		vegas.events.BasicEvent.apply(this, Array.fromArguments(arguments)) ;
	}
	
	/**
	 * @extends vegas.events.BasicEvent
	 */
	vegas.events.DynamicEvent.extend( vegas.events.BasicEvent ) ;

 	/**
 	 * Returns a new clone reference.
	 * @return a new clone reference.
	 */
	vegas.events.DynamicEvent.prototype.clone = function () {
		return new vegas.events.DynamicEvent(this.getType(), this.getTarget(), this.getContext()) ;
	}
 
	// Virtual Properties
	
	/**
	 * Returns {@code true} if the event is bubbling.
	 * @return {@code true} if the event is bubbling.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.DynamicEvent.prototype, "bubbles") ;

	/**
	 * Returns the optional context of this event.
	 * @return an object, corresponding the optional context of this event.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.DynamicEvent.prototype, "context") ;

	/**
	 * Returns the object that is actively processing the Event object with an event listener.
	 * @return the object that is actively processing the Event object with an event listener.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.DynamicEvent.prototype, "currentTarget") ;

	/**
	 * Returns the current phase in the event flow.
	 * @return the current phase in the event flow.
	 * @see EventPhase
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.DynamicEvent.prototype, "eventPhase") ;

	/**
	 * Returns the event target.
	 * @return the event target.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.DynamicEvent.prototype, "target") ;

	/**
	 * Returns the timestamp of the event.
	 * @return the timestamp of the event.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.DynamicEvent.prototype, "timeStamp", true) ;
	
	/**
	 * Returns the type of event.
	 * @return the type of event.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.DynamicEvent.prototype, "type") ;
	
}