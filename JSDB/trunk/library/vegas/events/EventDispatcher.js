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
 * Stores the listeners object an notifies them with the DOM Events level 2/3 of the W3C.
 * The EventDispatcher class implements the IEventDispatcher interface. 
 * This object allows any object to be an {@code EventTarget}.
 * <p><b>Example :</b></p>
 * {@code
 * BasicEvent = vegas.events.BasicEvent ;
 * Delegate = vegas.events.Delegate ;
 * EventDispatcher = vegas.events.EventDispatcher ;
 * 
 * var action = function ( e ) 
 * {
 *     if( e != undefined) 
 *     {
 *         trace ("> action : " + e.getType()) ;
 *     }
 *     else 
 *     {
 *         trace ("> action : no event") ;
 *     }
 * }
 * 
 * var EVENT_TYPE = "onEVENT" ;
 * 
 * var listener = new Delegate(this, action) ;
 * 
 * var dispatcher = new EventDispatcher() ;
 * dispatcher.addEventListener( EVENT_TYPE , listener ) ;
 * 
 * var e = new BasicEvent( EVENT_TYPE , this ) ;
 * dispatcher.dispatchEvent(e) ;
 * }
 * <p><b>Thanks</b>:</p>
 * <p>{@code EventDispatcher} is an AS2 port of the <b>Java.schst.net EventDispatcher</b>. Inspired by the NotificationCenter of Apple's Cocoa-Framework.
 * <li>EventDispatcher JAVA : Stephan Schmid - http://schst.net/</li><li>Cocoa-Framework : http://developer.apple.com/cocoa/</li><li>Notification center : http://developer.apple.com/documentation/Cocoa/Conceptual/Notifications/index.html</li>
 * </p>
 * @author eKameleon
 */
if (vegas.events.EventDispatcher == undefined) 
{

	/**
	 * @requires vegas.events.EventListenerCollection
	 */	
	require("vegas.events.EventListenerCollection") ;
	
	/**
	 * @requires vegas.events.EventListenerComparator
	 */	
	require("vegas.events.EventListenerComparator") ;
	
	/**
	 * @requires vegas.events.EventListenerContainer
	 */	
	require("vegas.events.EventListenerContainer") ;
	
	/**
	 * @requires vegas.events.EventQueue
	 */	
	require("vegas.events.EventQueue") ;

	/**
	 * @requires vegas.events.IEventDispatcher
	 */	
	require("vegas.events.IEventDispatcher") ;
	
	/**
	 * @requires vegas.util.factory.PropertyFactory
	 */	
	require("vegas.util.factory.PropertyFactory") ;
	
	/**
	 * Creates a new EventDispatcher instannce.
	 * @param target The IEventDispatcher scope reference of this instance.
	 * @param parent The parent EventDispatcher reference of this instance.
	 * @param name The name value of this instance. 
	 */
	vegas.events.EventDispatcher = function ( target /*IEventDispatcher*/ , parent /*EventDispatcher*/ ) 
	{ 
		this._globalListeners = new vegas.events.EventListenerCollection() ;
		this._captures        = new vegas.data.map.HashMap() ;
		this._listeners       = new vegas.data.map.HashMap() ;
		this._queue           = new vegas.events.EventQueue() ;
		this._target          = target ;
		this.parent           = parent ;
	}

	/**
	 * @extends vegas.events.IEventDispatcher
	 */
	vegas.events.EventDispatcher.extend(vegas.events.IEventDispatcher) ;

	/**
	 * Determinates the default singleton name.
	 */
	vegas.events.EventDispatcher.DEFAULT_SINGLETON_NAME /*String*/ = "__default__" ;
	
	/**
	 * The parent EventDispatcher reference of this EventDispatcher.
	 */
	vegas.events.EventDispatcher.prototype.parent = null ; /*EventDispatcher*/

	/**
	 * Adds a child EventDispatcher reference at this instance.
	 */
	vegas.events.EventDispatcher.prototype.addChild = function ( child /*EventDispatcher*/ ) 
	{
		child.parent = this ;
	}

	/**
	 * Allows the registration of event listeners on the event target.
	 * @param eventName A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 * @param useCapture Determinates if the event flow use capture or not.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	vegas.events.EventDispatcher.prototype.addEventListener = function ( eventName/*String*/, listener/*EventListener*/, useCapture/*Boolean*/, priority/*Number*/, autoRemove/*Boolean*/) /*Void*/ 
	{
		priority = isNaN(priority) ? 0 : priority ;
		if (eventName == "ALL") 
		{
			this.addGlobalEventListener(listener, priority, autoRemove) ;
		}
		else 
		{
			var map /*HashMap*/ = (!useCapture) ? this._listeners : this._captures ;
			if ( !map.containsKey(eventName)) 
			{
				map.put( eventName, new vegas.events.EventListenerCollection() ) ;
			}
			var col /*EventListenerCollection*/ = map.get(eventName) ;
			col.addListener(listener, autoRemove, priority) ;	
			this._dispatchQueuedEvents() ;
		}
	}

	/**
	 * Allows the registration of global event listeners on the event target.
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	vegas.events.EventDispatcher.prototype.addGlobalEventListener = function(listener/*EventListener*/, priority/*Number*/, autoRemove/*Boolean*/) /*Void*/ 
	{
		this._globalListeners.addListener(listener, autoRemove, priority ) ;
        this._dispatchQueuedEvents() ;
	}

	/**
	 * Dispatches an event into the event flow.
	 * @param event The Event object that is dispatched into the event flow.
	 * @param isQueue if the EventDispatcher isn't register to the event type the event is bufferized.
	 * @param target the target of the event.
	 * @param contect the context of the event.
	 * @return the reference of the event dispatched in the event flow.
	 */
	vegas.events.EventDispatcher.prototype.dispatchEvent = function (event, isQueue/*Boolean*/, target, context) /*Event*/ 
	{
		
		if (!event) return null ;
	
		var e /*Event*/ = vegas.util.factory.EventFactory.create(event, (target || this), context) ;
		
		if ( e == null) return null ;
		
		var phase /*Number*/ = e.getEventPhase() ;
		
		var EventPhase = vegas.events.EventPhase ;
		
		if (phase == EventPhase.AT_TARGET) 
		{
		
			this._capture(e) ; // CAPTURING_PHASE

			e.setEventPhase( EventPhase.AT_TARGET ) ;
			
			e.setCurrentTarget(this) ;
			
			this._propagate(e, isQueue || false ) ; // AT_TARGET
			
			this._bubble(e) ; // BUBBLING_PHASE
			
			e.setEventPhase( EventPhase.AT_TARGET ) ; // TODO inclure cette initialisation dans initEvent ??
			
		}
		else if (phase == EventPhase.BUBBLING_PHASE) 
		{
			this._propagateBubble(e) ;
		}
		else if (phase == EventPhase.CAPTURING_PHASE) 
		{
			
			this._propagateCapture(e) ;
			
		}
		return e ;
		
	}

	/**
	 * Flush all global EventDispatcher singleton.
	 */
	vegas.events.EventDispatcher.flush = function () /*Void*/ 
	{
		vegas.events.EventDispatcher.instances.clear() ;
	}

	/**
	 * Returns the {@code EventListenerCollection} of the specified event name.
	 * @return the {@code EventListenerCollection} of the specified event name.
	 */
	vegas.events.EventDispatcher.prototype.getEventListeners = function(eventName/*String*/)/*EventListenerCollection*/ 
	{
		if ( this._listeners.containsKey(eventName) ) 
		{
			return this._listeners.get(eventName) ;
		}
		return new vegas.events.EventListenerCollection() ;
	}

	/**
	 * Returns the global {@code EventListenerCollection} of this EventDispatcher.
	 * @return the global {@code EventListenerCollection} of this EventDispatcher.
	 */
	vegas.events.EventDispatcher.prototype.getGlobalEventListeners = function()/*EventListenerCollection*/ 
	{
		return this._globalListeners ;
	}
	
	/**
	 * Returns a global {@code EventDispatcher} singleton. Uses this method to create [@code FrontController} patterns for example.
	 * @return a global {@code EventDispatcher} singleton.
	 */
	vegas.events.EventDispatcher.getInstance = function ( name /*String*/ ) /*EventDispatcher*/ 
	{
		var EventDispatcher = vegas.events.EventDispatcher ;
		if (!name) 
		{
			name = "__default__" ;
		}
		if (! EventDispatcher.instances.containsKey(name) ) 
		{
			EventDispatcher.instances.put(name, new EventDispatcher(null, null, name)) ;
		}
		return EventDispatcher.instances.get(name) ;
	}

	/**
	 * Returns the name of the display.
	 * @return the name of the display.
	 */
	vegas.events.EventDispatcher.prototype.getName = function() /*String*/
	{
		return this._sName || null ;
	}

	/**
	 * Returns a {@code Set} of all register event's name in this EventListener.
	 * @return a {@code Set} of all register event's name in this EventListener.
	 */
	vegas.events.EventDispatcher.prototype.getRegisteredEventNames = function () /*Set*/ 
	{
    	return new vegas.data.set.HashSet( this._listeners.getKeys() ) ;
    }

	/**
	 * Returns the current target of this EventDispatcher.
	 * @return the current target of this EventDispatcher.
	 */
	vegas.events.EventDispatcher.prototype.getTarget = function () 
	{
		return this._target != null ? this._target : this ;	
	}

	/**
	 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
	 */ 
	vegas.events.EventDispatcher.prototype.hasEventListener = function(eventName/*String*/)/*Boolean*/ 
	{
		return this._listeners.containsKey(eventName) ;
	}

	/**
	 * Release the specified EventDispatcher singleton in your application.
	 */
	vegas.events.EventDispatcher.release = function (name /*String*/ ) /*EventDispatcher*/ 
	{
		if (!name) 
		{
			name = "__default__" ;
		}
		return vegas.events.EventDispatcher.instances.remove(name) ;
	}

	/**
	 * Removes the EventDispatcher child reference of this EventDispatcher instance.
	 */
	vegas.events.EventDispatcher.prototype.removeChild = function ( child /*EventDispatcher*/ ) /*Void*/ 
	{
		child.parent = null ;
	}

	/** 
	 * Removes a listener from the EventDispatcher object.
	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
	 * @param Specifies the type of event.
	 * @param the class name(string) or a EventListener object.
	 */
	vegas.events.EventDispatcher.prototype.removeEventListener = function (eventName/*String*/, listener, useCapture/*Boolean*/)/*EventListener*/ 
	{
		if (eventName == "ALL") 
		{
			return this.removeGlobalEventListener(listener) ;
		}
		if ( (listener instanceof vegas.events.EventListener) || vegas.util.TypeUtil.typesMatch(listener, String) || (listener.handleEvent != null) )  
		{
			var map /*HashMap*/ = (!useCapture) ? this._listeners : this._captures ;
			if (! map.containsKey(eventName) ) 
			{
				return null ;
			}
			var col /*EventListenerCollection*/ = map.get(eventName) ;
			var container /*EventListenerContainer*/ = col.removeListener(listener) ;
			if (container != null) 
			{
				return container.getListener() ;
			}
		}
        return null ;
	}

	/** 
	 * Removes a global listener from the EventDispatcher object.
	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
	 * @param the class name(string) or a EventListener object.
	 */
	vegas.events.EventDispatcher.prototype.removeGlobalEventListener = function( listener )/*EventListener*/ 
	{
		if ( (listener instanceof vegas.events.EventListener) || ( typeof(listener) == "string" ) || (listener.handleEvent != null) )
		{
			var container /*EventListenerContainer*/ = this._globalListeners.removeListener(listener) ;
			if (container != null) 
			{
				return container.getListener() ;
			}
		}
		return null ;
	}

	/**
	 * Removes a global EventDispatcher singleton.
	 */
	vegas.events.EventDispatcher.removeInstance = function (name /*String*/ ) /*Boolean*/ 
	{
		if ( vegas.events.EventDispatcher.instances.containsKey(name) ) 
		{
			return vegas.events.EventDispatcher.instances.remove(name) != null ;
		}
		else 
		{
			return false ;
		}
	}

	/**
	 * The HashMap of all global singletons of this object.
	 */	
	vegas.events.EventDispatcher.instances /*HashMap*/ = new vegas.data.map.HashMap() ;
	
	/**
	 * The internal EventListenerCollection to register all global listeners.
	 */	
	vegas.events.EventDispatcher.prototype._globalListeners /*EventListenerCollection*/ = null ;
	
	/**
	 * The HashMap to put all captures.
	 */	
	vegas.events.EventDispatcher.prototype._captures /*HashMap*/ = null ;
	
	/**
	 * The HashMap of all listeners.
	 */	
	vegas.events.EventDispatcher.prototype._listeners /*HashMap*/ = null ;
	
	/**
	 * The internal EventQueue buffer. 
	 */	
	vegas.events.EventDispatcher.prototype._queue /*EventQueue*/ = null ;
	
	/**
	 * The internal name's property of the instance.
	 */
	vegas.events.EventDispatcher.prototype._sName /*String*/ = null ;	

	/**
	 * The internal IEventDispatcher target.
	 */
	vegas.events.EventDispatcher.prototype._target /*IEventDispatcher*/ = null ;
	
	vegas.events.EventDispatcher.prototype._bubble = function (e /*Event*/ ) /*Boolean*/ 
	{
		var EventPhase = vegas.events.EventPhase ;
		if (e["stop"] >= EventPhase.STOP ) 
		{
			return false ;
		}
		var parents /*Array*/ = this._getParents() ;
		if (parents != null) 
		{
			var l /*Number*/ = parents.length ;
			var i /*Number*/ = 0 ;
			var current /*EventDispatcher*/ ;
			while (i<l) 
			{
				if (e.getBubbles()) 
				{
					current = parents[i] ;
					e.setCurrentTarget(current.getTarget()) ;
					e.setEventPhase( EventPhase.BUBBLING_PHASE ) ;
					current.dispatchEvent(e) ;
					if (e["stop"] >= EventPhase.STOP ) 
					{
						return false ;
					}
				}
				i++ ;
			}
		}
		return true ;
	}
	
	vegas.events.EventDispatcher.prototype._capture = function( e /*Event*/ ) /*Boolean*/
	{
		var parents /*Array*/ = this._getParents() ;
		if ( parents != null ) 
		{
			var l /*Number*/ = parents.length ;
			var current /*EventDispatcher*/ ;
			var EventPhase = vegas.events.EventPhase ;
			while (--l > -1) 
			{
				current = parents[l] ;
				e.setCurrentTarget( current.getTarget() ) ;
				e.setEventPhase(EventPhase.CAPTURING_PHASE) ;
				current.dispatchEvent(e) ;
				if (e["stop"] >= EventPhase.STOP ) 
				{
					return false ;
				}
			}
		}
		return true ;
	}
	
	vegas.events.EventDispatcher.prototype._dispatchQueuedEvents = function() /*Void*/ 
	{
		var q /*Queue*/ = this._queue.getQueuedEvents();
		if (q.size() > 0) 
		{
			var ar /*Array*/ = q.toArray() ;
			var len /*Number*/ = ar.length ;
			for (var i /*Number*/ = 0 ; i<len ; i++) 
			{
				var e /*Event*/ = ar[i] ;
				this.dispatchEvent(e, e.isQueued()) ;
			}
		}
	}

	vegas.events.EventDispatcher.prototype._getParents = function () /*Array*/ 
	{
		if (this.parent == null) return null ;
		var ar /*Array*/ = [] ;
		var tmp /*EventDispatcher*/ = this.parent ;
		while(tmp != null) 
		{
			ar.push(tmp) ;
			tmp = tmp.parent ;
		}
		return ar ;
	}

	vegas.events.EventDispatcher.prototype._propagateBubble = function ( e /*Event*/) /*Void*/ 
	{
		var EventPhase = vegas.events.EventPhase ;
		if ( e.getEventPhase(EventPhase.BUBBLING_PHASE) ) 
		{
			e.setCurrentTarget( this.getTarget() ) ;
			this._propagate(e) ;
		}
	}
	
	vegas.events.EventDispatcher.prototype._propagateCapture = function ( e /*Event*/ ) /*Void*/ 
	{
		var EventPhase = vegas.events.EventPhase ;
		if ( this._captures.containsKey( e.getType() ) ) 
		{
			e.getEventPhase(EventPhase.CAPTURING_PHASE) ;
            var col/*EventListenerCollection*/ = this._captures.get( e.getType() ) ;
            col.propagate(e) ;
        }
	}
	
	vegas.events.EventDispatcher.prototype._propagate = function ( e /*Event*/, isQueue /*Boolean*/ ) /*Event*/ 
	{
		var EventPhase = vegas.events.EventPhase ;
		if (e["stop"] >= EventPhase.STOP ) 
		{
			return e ; // hack the interface limitation
		}
		if ( this._listeners.containsKey(e.getType()) ) 
		{
            var col /*EventListenerCollection*/ = this._listeners.get(e.getType()) ;
            col.propagate(e) ;
        }
        if ( e.isCancelled() ) 
        {
			return e ;
		}
        this._globalListeners.propagate(e) ;
        if (isQueue == false || e.isCancelled()) 
        {
			return e ;
		}
        this._queue.enqueue(e) ;
        return e ;
	}
	
	/**
	 * Internal method to sets the name of the instance.
	 */
	/*protected*/ vegas.events.EventDispatcher.prototype.setName = function( name /*String*/ ) /*void*/ 
	{
		this._sName = name ;
	}
	
	/**
	 * (Read-write) The name value of this EventDispatcher instance.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.events.EventDispatcher.prototype, "name") ;	
	
}