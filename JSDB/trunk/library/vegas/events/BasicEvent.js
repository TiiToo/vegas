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
 * {@code BasicEvent} is the basical event structure to work with {@link EventDispatcher}.
 * {@code
 * var EventType = vegas.events.EventType ;
 * 
 * var e = new vegas.events.BasicEvent(EventType.CHANGE, this, "Hello World") ;
 * trace("> " + e) ;
 * trace("> target : " + e.getTarget()) ;
 * trace("> type : " + e.getType()) ;
 * trace("> context : " + e.getContext()) ;
 * trace("> timeStamp : " + new Date(e.getTimeStamp()) ) ;
 * }
 * @author eKameleon
 */
if (vegas.events.BasicEvent == undefined) 
{
	
	require("vegas.events.Event") ;
	require("vegas.events.EventPhase") ;
	
 	/**
	 * Creates a new {@code BasicEvent} instance.
	 * 
	 * <p>
	 *    <code>
	 *     var e:BasicEvent = new BasicEvent(type, target, context, [bubbles:Boolean, [eventPhase:Number, [time:Number, [stop:Boolean]]]]) ;
	 *    </code>
	 * </p>
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	_global.vegas.events.BasicEvent = function (
		
		type/*String*/
		, target/*Object*/
		, context/*Object*/
		, p_bubbles /*Boolean*/
		, p_eventPhase /*Number*/
		, p_time /*Number*/
		, p_stop /*Number*/
		
	) 
		{
		
		var EventPhase = vegas.events.EventPhase ;
		
		this._context = context || null ;
		this._target = target || null ;
		this._type = type || null ;
		
		this._bubbles = (p_bubbles != null) ? p_bubbles : true ;
		this._eventPhase = isNaN(p_eventPhase) ? EventPhase.AT_TARGET : p_eventPhase ;
		this._time = (p_time > 0) ? p_time : ( (new Date()).valueOf() ) ;
		
		this.stop = isNaN(p_stop) ? EventPhase.NONE : p_stop ;
		
		}

	// Inherit
	vegas.events.BasicEvent.extend(vegas.events.Event) ;
 
	/**
	 * This property indicated in the event model if this event is stopped.
	 */	
	vegas.events.BasicEvent.prototype.stop /*Number*/ = null ;

	/*private*/ vegas.events.BasicEvent.prototype._bubbles /*Boolean*/ = null ;
	/*private*/ vegas.events.BasicEvent.prototype._cancelled /*Boolean*/ = null ;
	/*private*/ vegas.events.BasicEvent.prototype._client /*Client*/ = null  ;
	/*private*/ vegas.events.BasicEvent.prototype._context /*Object*/ = null ;
	/*private*/ vegas.events.BasicEvent.prototype._currentTarget /*Object*/ = null ;
	/*private*/ vegas.events.BasicEvent.prototype._inQueue /*Boolean*/ = null ;
	/*private*/ vegas.events.BasicEvent.prototype._target /*Object*/ = null ;
	/*private*/ vegas.events.BasicEvent.prototype._time /*Number*/ = null ;
	/*private*/ vegas.events.BasicEvent.prototype._type /*String*/ = null ;
 
	/**
	 * Indicates whether the behavior associated with the event can be prevented.
	 */
 	vegas.events.BasicEvent.prototype.cancel = function () /*Void*/ 
 	{
		this._cancelled = true ;
	}

	/**
	 * Returns the shallow copy of this event.
	 * @return the shallow copy of this event.
	 */
	vegas.events.BasicEvent.prototype.clone = function () 
	{
		return new vegas.events.BasicEvent(this.getType(), this.getTarget(), this.getContext()) ;
	}

	/**
	 * Returns {@code true} if the event is bubbling.
	 * @return {@code true} if the event is bubbling.
	 */
 	vegas.events.BasicEvent.prototype.getBubbles = function () /*Boolean*/ 
 	{
		return this._bubbles ;
	}

	/**
	 * Returns the optional Client reference of this event.
	 * @return the optional Client reference of this event.
	 */
 	vegas.events.BasicEvent.prototype.getClient = function () /*Client*/ 
 	{
		return this._client ;
	}

	/**
	 * Returns the optional context of this event.
	 * @return an object, corresponding the optional context of this event.
	 */
 	vegas.events.BasicEvent.prototype.getContext = function () /*Object*/ 
 	{
		return this._context ;
	}

	/**
	 * The object that is actively processing the Event object with an event listener.
	 */
 	vegas.events.BasicEvent.prototype.getCurrentTarget = function () /*Object*/ 
 	{
		return this._currentTarget ;
	}

	/**
	 * Returns the current phase in the event flow.
	 * @return the current phase in the event flow.
	 * @see EventPhase
	 */
 	vegas.events.BasicEvent.prototype.getEventPhase = function () /*Number*/ 
 	{
		return this._eventPhase ;
	}

	/**
	 * The event target.
	 */
 	vegas.events.BasicEvent.prototype.getTarget = function () /*Object*/ 
 	{
		return this._target ;
	}

	/**
	 * Returns the timestamp of the event.
	 */
 	vegas.events.BasicEvent.prototype.getTimeStamp = function () /*Number*/ 
 	{
		return this._time ;
	}

	/**
	 * The type of event.
	 */
 	vegas.events.BasicEvent.prototype.getType = function () /*String*/ 
 	{
		return this._type ;
	}

	/**
	 * Initialize the event with the properties type, bubbles, cancelable.
	 * @param type the type of the event.
	 * @param bubbles a boolean to indicate if the event is a bubbling event.
	 * @param cancelable a boolean to indicate if the event is a capturing event.
	 */
	vegas.events.BasicEvent.prototype.initEvent = function (type /*String*/ , bubbles /*Boolean*/, cancelable /*Boolean*/ ) /*Void*/ 
	{
		this._type = type ;
		this._bubbles = bubbles ;
		this._cancelled = cancelable ;
		this._time = (new Date()).valueOf() ;
	}

	/**
	 * Returns {@code true} if the event is cancelled.
	 * @return {@code true} if the event is cancelled.  
	 */
	vegas.events.BasicEvent.prototype.isCancelled = function() /*Boolean*/ 
	{
		return this._cancelled ;	
	}

	/**
	 * Returns {@code true} if the event is queued.
	 * @return {@code true} if the event is queued.
	 */
	vegas.events.BasicEvent.prototype.isQueued = function() /*Boolean*/ 
	{
		return this._inQueue ;
	}

	/**
	 * Sets if the event is queued.
	 */
	vegas.events.BasicEvent.prototype.queueEvent = function() /*Void*/ 
	{
		this._inQueue = true ;
	}

	/**
	 * Sets if the event is bubbling.
	 */
 	vegas.events.BasicEvent.prototype.setBubbles = function ( b /*Boolean*/ ) /*Void*/ 
 	{
		this._bubbles = b ;
	}
	
	/**
	 * Sets the optional Client reference of this event.
	 * @param c the Client reference.
	 */
 	vegas.events.BasicEvent.prototype.setClient = function ( c /*Client*/ ) /*Void*/ 
 	{
		this._client = c ;
	}

	/**
	 * Sets the optional context object of this event. 
	 */
 	vegas.events.BasicEvent.prototype.setContext = function ( context /*Object*/ ) /*Void*/ 
 	{
		this._context = context || null ;
	}

	/**
	 * Sets the optional context object of this event. 
	 */
 	vegas.events.BasicEvent.prototype.setCurrentTarget = function ( target /*Object*/ ) /*Void*/ 
 	{
		this._currentTarget = target ;
	}

	/**
	 * Sets the current phase in the event flow.
	 */
 	vegas.events.BasicEvent.prototype.setEventPhase = function ( n /*Number*/ ) /*Void*/ {
		this._eventPhase = n ;
	}

	/**
	 * Sets the event target.
	 */
 	vegas.events.BasicEvent.prototype.setTarget = function ( target /*Object*/ ) /*Void*/ 
 	{
		this._target = target || null ;
	}

	/**
	 * Sets the event type.
	 */
 	vegas.events.BasicEvent.prototype.setType = function ( type /*String*/ ) /*Void*/ 
 	{
		this._type = type || null ;
	}

	/**
	 * Prevents processing of any event listeners in the current node and any subsequent nodes in the event flow.
	 */
	vegas.events.BasicEvent.prototype.stopImmediatePropagation = function () /*Void*/ 
	{
		this.stop = vegas.events.EventPhase.STOP_IMMEDIATE ;
	}

	/**
	 * Prevents processing of any event listeners in nodes subsequent to the current node in the event flow.
	 */	
 	vegas.events.BasicEvent.prototype.stopPropagation = function () /*Void*/ 
 	{
		this.stop = vegas.events.EventPhase.STOP ;
	}

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	vegas.events.BasicEvent.prototype.toSource = function () /*String*/ 
	{
		var pattern /*String*/ = "new " + this.getConstructorPath() + "({0}, {1}, {2}, {3}, {4}, {5}, {6})" ;
		var args /*Array*/ = [] ;
		args[0] = (this._type != null ) ? this._type.toSource() : null ;
		args[1] = (this._target == null || this._target == _global) ? null : this._target.toSource() ;
		args[2] = (this._context != null) ? this._context.toSource() : null ;
		args[3] = (this._bubbles != null) ? this._bubbles.toSource() : false ;
		args[4] = isNaN(this._eventPhase) ? 0 : this._eventPhase.toSource() ;
		args[5] = isNaN(this._time) ? 0 : this._time ;
		args[6] = this.stop.toSource() ;
		return String.format.apply(this, [pattern].concat(args)) ;
	}

	/**
	 * Returns the string representation of this event.
	 * @return the string representation of this event.
	 */
	vegas.events.BasicEvent.prototype.toString = function () /*String*/ 
	{
		var EventPhase = vegas.events.EventPhase ;
		
		var phase /*Number*/ = this._eventPhase ;
		var name /*String*/ = this.getConstructorName() ;
		var txt /*String*/ = "[" + name ;
		if (this._type) txt += " " + this._type ;
		switch (phase) 
		{
			case EventPhase.CAPTURING_PHASE :
				txt += ", CAPTURING" ;
				break;
			case EventPhase.AT_TARGET:
				txt += ", AT TARGET" ;
				break ;
			case EventPhase.BUBBLING_PHASE:
				txt += ", BUBBLING" ;
				break ;
			default :
				txt += ", (inactive)" ;
				break;
		}
		if (this._bubbles && phase != EventPhase.BUBBLING_PHASE) 
		{
			txt += ", bubbles" ;
		}
		if (this.isCancelled()) {
			txt += ", can cancel" ;
		}
		txt += "]" ;
		return txt ;
	}

	/**
	 * Sets the timestamp of the event (used this method only in internal in the Event class).
	 */
	/*protected*/ vegas.events.BasicEvent.prototype._setTimeStamp = function ( t/*Number*/ ) 
	{
		this._time = t ;
	}

	// ----o Register the class to AMF exchange.
 
 	/**
 	 * The BasicEvent class (since the namespace) is used to register the BasicEvent class and shared the event between the server and the client.
 	 * Adds the same implementation in all event class if you want use a typed shared event in your AMF call methods. 
 	 */
 	function BasicEvent( type /*String*/  )
	{
		vegas.events.BasicEvent.apply(this, Array.fromArguments(arguments) ) ;
	}

	BasicEvent.extend( vegas.events.BasicEvent )  ;

	/**
	 * This method is invoqued to register the BasicEvent class if you use a shared instance between the server and the client.
	 */
	BasicEvent.register = function()
	{
		return application.registerClass("BasicEvent", BasicEvent) ;
	}

}