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
 * This class is an implementation of the native AsBroadcaster event model but used {@code Event} object to dispatch the message.
 * <p>You can used this class with a simple instance, with an extends class or with the mixin(use initialize static method like AsBroadcaster).</p>
 * <p><b>Example : </b></p>
 * {@code
 * Event = vegas.events.Event ;
 * FastDispatcher = vegas.events.FastDispatcher ;
 * 
 * function onTest( ev ):Void 
 * {
 *     trace ("--------") ;
 *     trace ("type : " + ev.getType()) ;
 *     trace ("target : " + ev.getTarget()) ;
 *     trace ("context : " + ev.getContext()) ;
 *     trace ("this : " + this) ;
 * }
 * 
 * var oFD = new FastDispatcher() ;
 * 
 * trace ("addListener this : " + oFD.addListener(this)) ;
 * trace ("hasListeners : " + oFD.hasListeners()) ;
 * trace ("size : " + oFD.size()) ;
 * oFD.dispatch( { type : "onTest", target : this } ) ;
 * oFD.removeAllListeners() ;
 * oFD.dispatch( { type : "onTest", target : this } ) ;
 * }
 * @author eKameleon
 */
if (vegas.events.FastDispatcher == undefined) 
{
	
	/**
	 * Creates a new FastDispatcher instance.
	 * @param ar an Array of listeners object.
	 */
	vegas.events.FastDispatcher = function( ar /*Array*/ ) 
	{
		this._listeners = (ar instanceof Array && ar.length > 0) ? [].concat(ar) : [] ;
	}
	
	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.events.FastDispatcher.extend(vegas.core.CoreObject) ;
 
	/**
	 * Registers an object to receive event notification messages.
	 * This method is called on the broadcasting object and the listener object is sent as an argument.
 	 */
 	proto.addListener = function ( listener ) /*Boolean*/ 
 	{
		if (this._listeners.contains(listener)) 
		{
			return false ;
		}
		else 
		{
			this._listeners.push(listener) ;
			return true ;
		}
	}
	
	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	proto.clone = function () 
	{
		return new vegas.events.FastDispatcher(this._listeners) ;
	}

	/**
	 * Sends an Event Object to each object in the list of listeners.
	 * When the Event is received by the listening object, Flash Player attempts to invoke a function of the same name on the Event.type property.
	 */
	proto.dispatch = function ( event ) /*Event*/ {
		
		if (event == null || this.isEmpty()) return null ;
		
		var e /*Event*/ = null ;
		
		if (event instanceof vegas.events.Event) 
		{
			e = event ;
		} 
		else if ( vegas.util.TypeUtil.typesMatch( event, String ) )
		{
			e = new vegas.events.DynamicEvent(event) ;
			e.setTarget(arguments[1]) ;
			e.setContext(arguments[2]) ;
		}
		else {
			if (event["type"] == undefined) {
				return null ;
			}
			e = new vegas.events.DynamicEvent() ;
			e.setType(event.type ) ;
			e.setTarget( event.target) ;
			e.setContext(event.context) ;
		}
		this._propagate(e) ;
		return e ;
	}

	/**
	 * Returns an array representation of all listeners.
	 * @return an array representation of all listeners.
	 */
	proto.getListeners = function () /*Array*/ 
	{
		return [].concat(this._listeners) ;
	}

	/**
	 * Returns {@code true} is the listeners list is empty.
	 * @return {@code true} is the listeners list is empty.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return this._listeners.length == 0 ;
	}

	/**
	 * Returns an iterator of the listeners list.
	 * @return an iterator of the listeners list.
	 */
	proto.iterator = function () /*Iterator*/ 
	{
		return new vegas.data.iterator.ArrayIterator(this._listeners) ;
	}

	/**
	 * Removes all listeners.
	 */
	proto.removeAllListeners = function () /*void*/ 
	{
		this._listeners.splice(0) ;
	}

	/**
	 * Removes the specified listener.
	 */
	proto.removeListener = function (listener) /*Boolean*/ {
		
		var index /*Number*/ = this._listeners.indexOf(listener) ;
		
		if ( index != -1 ) 
		{
			this._listeners.splice(index, 1) ;
			return true ;
		}
		
		return false ;
		
	}

	/**
	 * Returns the number of listeners.
	 * @return the number of listeners.
	 */
	proto.size = function () /*Number*/ 
	{
		return this._listeners.length ;
	}

	// ----o Private Properties
	
	proto._listeners = null ;

	proto._propagate = function ( e /*Event*/ ) /*Void*/ 
	{
		var eType /*String*/ = e.getType() ;
		if (eType == null) return ;
		var ar /*Array*/ = this._listeners.concat() ;
		var l /*Number*/ = ar.length ;
		for (var i /*Number*/ = 0 ; i<l ; i++) 
		{
			var listener = ar[i] ;
			listener[eType].apply(listener, Array.fromArguments(arguments)) ;
		}
		
	}

	delete proto ;
	
}
