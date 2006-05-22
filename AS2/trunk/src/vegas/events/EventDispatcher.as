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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** EventDispatcher

	AUTHOR
	
		Name : EventDispatcher
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new EventDispatcher(target:IEventDispatcher) ;

	PROPERTY SUMMARY
	
		- parent:EventDispatcher

	METHOD SUMMARY
	
		- addChild(child:EventDispatcher):Void
		
		- addEventListener(eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean)
		
			PARAMS
			
				- eventName:String
					
					String : corresponding of the event type's name
				
					PS : if eventName value is "ALL" addEventListener use addGlobalListener
				
				- listener:EventListener
					
					EventListener object
				
				- useCapture:Boolean
				
				- priority:Number
				
					Determines the priority level of the event listener.
					
				- autoRemove:Boolean
				
					Apply a removeEventListener after the first trigger		
		
		- addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean)
		
			DESCRIPTION 
			
				apply a global broadcast 
		

		- dispatchEvent( event , [isQueue], [target], [context])
			
			DESCRIPTION
				
				dispatch event
			
			PARAMS
				
				- event : 
				
					- a string 
					- a Event Object
					- a basic object with properties
						- type [obligatory]
						- target [optional]
						- context [optional]
				
				- isQueue [Boolean] [optional]
				
				- target [optional]
				
				- context [optional]
			
			RETURNS 
			
				an Event object or null

		- static flush():Void 
		
			remove all singleton instances
		
		- getEventListeners(eventName:String) : EventListenerCollection
		
			return an EventListenerCollection object for a specific type of event.

		- getGlobalEventListeners()
		
			return a EventListenerCollection object for global events listeners.

		- static getInstance(name:String):EventDispatcher

		- getRegisteredEventNames()
			
			return a HashSet object
	
		- hasEventListener(eventName:String)
		
			Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
			This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
			To determine whether a specific event type will actually trigger an event listener, use EventDispatcher.willTrigger(). 
		
		- static release(name:String):EventDispatcher
		
		- removeChild(child:EventDispatcher):Void
		
		- removeEventListener(eventName:String, listener )
		
			Removes a listener from the EventDispatcher object.
			If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect. 
		
			Parameters :
			
				- eventName :String -> Specifies the type of event.
				
				- listener -> the class name(string) or a EventListener object.
				
		
		- removeGlobalEventListener( listener ) 

			Removes all "Global" listeners from the EventDispatcher object.

		- static removeInstance(name:String):Boolean
		
		- toString():String

	INHERIT
	
		CoreObject > EventDispatcher

	IMPLEMENTS 
	
		EventTarget, IEventDispatcher, IFormattable, IHashable

	THANKS
	
		EventDispatcher is a AS2 port of the Java.schst.net EventDispatcher. Inspired by the NotificationCenter of Apple's Cocoa-Framework.
		
			- EventDispatcher JAVA : Stephan Schmid - http://schst.net/
			- Cocoa-Framework : http://developer.apple.com/cocoa/
			- Notification center : http://developer.apple.com/documentation/Cocoa/Conceptual/Notifications/index.html

	HISTORY
	
		CHANGE      : [2005-11-07] change method name triggerEvent -> dispatchEvent (use AS3 trigger event method name)
		CHANGE      : [2005-11-08] priority in addEventListener method
		CHANGE      : [2005-12-11] static removeInstance Method
		ADD         : [2006-01-19] target parameter in constructor
		ADD         : [2006-01-19] Bubbling Event v.alpha ! 
		ADD         : [2006-01-22] Capturing Event v.alpha !
		REFACTORING : [2006-01-22] Change params in addEventListener Method
		ADD         : [2006-03-11] add static release(name:String) method.
	
**/

import vegas.core.CoreObject;
import vegas.data.map.HashMap;
import vegas.data.Queue;
import vegas.data.Set;
import vegas.data.set.HashSet;
import vegas.events.Event;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;
import vegas.events.EventListenerContainer;
import vegas.events.EventPhase;
import vegas.events.EventQueue;
import vegas.events.IEventDispatcher;
import vegas.util.factory.EventFactory;
import vegas.util.TypeUtil;

class vegas.events.EventDispatcher extends CoreObject implements IEventDispatcher {

	// ----o Constructor
	
	public function EventDispatcher( target:IEventDispatcher , parent:EventDispatcher ) {
		_globalListeners = new EventListenerCollection() ;
		_captures = new HashMap() ;
		_listeners = new HashMap() ;
		_queue = new EventQueue() ;
		_target = target || this ;
		this.parent = parent || null ;
	}

	// ----o Public Properties
	
	public var parent:EventDispatcher ;

	// ----o Public Methods

	public function addChild( child:EventDispatcher ):Void {
		child.parent = this ;
	}

	public function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void {
		priority = isNaN(priority) ? 0 : priority ;
		if (eventName == "ALL") {
			addGlobalEventListener(listener, priority, autoRemove) ;
		} else {
			var map:HashMap = (!useCapture) ? _listeners : _captures ;
			if (!map.containsKey(eventName)) map.put(eventName, new EventListenerCollection()) ;
			var col:EventListenerCollection = map.get(eventName) ;
			col.addListener(listener, autoRemove, priority) ;	
			_dispatchQueuedEvents() ;
		}
	}
	
	public function addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void {
		_globalListeners.addListener(listener, autoRemove, priority ) ;
        _dispatchQueuedEvents() ;
    }

	public function dispatchEvent( event , isQueue:Boolean, target, context):Event {
		if (!event) return null ;
		var e:Event = EventFactory.create(event, target || this, context) ;
		if (e == null) return null ;
		var phase:Number = e.getEventPhase() ;
		if (phase == EventPhase.AT_TARGET) {
			_capture(e) ; // CAPTURING_PHASE
			e.setEventPhase(EventPhase.AT_TARGET) ;
			e.setCurrentTarget(this) ;
			_propagate(e, isQueue || false ) ; // AT_TARGET
			_bubble(e) ; // BUBBLING_PHASE
			e.setEventPhase(EventPhase.AT_TARGET) ; // TODO inclure cette initialisation dans initEvent ??
		} else if (phase == EventPhase.BUBBLING_PHASE) {
			_propagateBubble(e) ;
		} else if (phase == EventPhase.CAPTURING_PHASE) {
			_propagateCapture(e) ;
		}
		return e ;
	}

	static public function flush():Void {
		EventDispatcher.instances.clear() ;
	}

	public function getEventListeners(eventName:String):EventListenerCollection {
		if ( _listeners.containsKey(eventName) ) return _listeners.get(eventName) ;
		return new EventListenerCollection() ;
	}

	public function getGlobalEventListeners():EventListenerCollection {
        return _globalListeners ;
    }

	static public function getInstance(name:String):EventDispatcher {
		if (!name) name = "__default__" ;
		if (!EventDispatcher.instances.containsKey(name)) {
			EventDispatcher.instances.put(name, new EventDispatcher) ;
		}
		return EventDispatcher(EventDispatcher.instances.get(name));
	}
	
	public function getRegisteredEventNames():Set {
    	return new HashSet(_listeners.getKeys()) ;
    }
	
	public function getTarget() {
		return _target ;	
	}
	
	public function hasEventListener(eventName:String):Boolean {
		return _listeners.containsKey(eventName) ;
	}

	static public function release(name:String):EventDispatcher {
		if (!name) name = "__default__" ;
		return EventDispatcher.instances.remove(name) ;
	}

	public function removeChild( child:EventDispatcher ):Void {
		child.parent = null ;
	}

    public function removeEventListener(eventName:String, listener , useCapture:Boolean):EventListener {
		if (eventName == "ALL") return removeGlobalEventListener(listener) ;
		if (listener instanceof EventListener || TypeUtil.typesMatch(listener, String))  {
			var map:HashMap = (!useCapture) ? _listeners : _captures ;
			if (!map.containsKey(eventName) ) return null ;
			var col:EventListenerCollection = map.get(eventName) ;
			var container:EventListenerContainer = col.removeListener(listener) ;
			if (container != null) return container.getListener() ;
		}
        return null ;
    }

	public function removeGlobalEventListener( listener ):EventListener {
		if (listener instanceof EventListener || typeof(listener) == "string") {
			var container:EventListenerContainer = EventListenerContainer(_globalListeners.removeListener(listener));
			if (container != null) 	return container.getListener();
			return null;
		}
	}
	
	static public function removeInstance(name:String):Boolean {
		if (!EventDispatcher.instances.containsKey(name)) {
			return EventDispatcher.instances.remove(name) != null ;
		} else {
			return false ;
		}
	}
	
    // ----o Private Properties
	
	static private var instances:HashMap = new HashMap() ;
	private var _globalListeners:EventListenerCollection ;
	private var _captures:HashMap ;
	private var _listeners:HashMap ;
	private var _queue:EventQueue ;
	private var _target:IEventDispatcher ;
	
    // ----o Private Methods
	
	private function _bubble(e:Event):Boolean {
		if (e["stop"] >= EventPhase.STOP ) return false ;
		var parents:Array = _getParents() ;
		if (parents != null) {
			var l:Number = parents.length ;
			var i:Number = 0 ;
			var current:EventDispatcher ;
			while (i<l) {
				if (e.getBubbles()) {
					current = parents[i] ;
					e.setCurrentTarget(current.getTarget()) ;
					e.setEventPhase(EventPhase.BUBBLING_PHASE) ;
					current.dispatchEvent(e) ;
					if (e["stop"] >= EventPhase.STOP ) return false ;
				}
				i++ ;
			}
		}
		return true ;
	}
	
	private function _capture(e:Event):Boolean {
		var parents:Array = _getParents() ;
		if (parents != null) {
			var l:Number = parents.length ;
			var current:EventDispatcher ;
			while (--l > -1) {
				current = parents[l] ;
				e.setCurrentTarget(current.getTarget()) ;
				e.setEventPhase(EventPhase.CAPTURING_PHASE) ;
				current.dispatchEvent(e) ;
				if (e["stop"] >= EventPhase.STOP ) return false ;
			}
		}
		return true ;
	}
	
	private function _dispatchQueuedEvents():Void {
		var q:Queue = _queue.getQueuedEvents();
		if (q.size() > 0) {
			var ar:Array = q.toArray() ;
			var len:Number = ar.length ;
			for (var i:Number = 0 ; i<len ; i++) {
				var e:Event = ar[i] ;
				dispatchEvent(e, e.isQueued()) ;
			}
		}
	}

	private function _getParents():Array {
		if (parent == null) return null ;
		var ar:Array = [] ;
		var tmp:EventDispatcher = parent ;
		while(tmp != null) {
			ar.push(tmp) ;
			tmp = tmp.parent ;
		}
		return ar ;
	}

	private function _propagateBubble(e:Event):Void {
		if (e.getEventPhase(EventPhase.BUBBLING_PHASE)) {
			e.setCurrentTarget(getTarget()) ;
			_propagate(e) ;
		}
	}
	
	private function _propagateCapture(e:Event):Void {
		if (_captures.containsKey(e.getType())) {
			e.getEventPhase(EventPhase.CAPTURING_PHASE) ;
            var col:EventListenerCollection = EventListenerCollection(_captures.get(e.getType())) ;
            col.propagate(e) ;
        }
	}
	
	private function _propagate(e:Event, isQueue:Boolean):Event {
		if (e["stop"] >= EventPhase.STOP ) return e ;
		if (_listeners.containsKey(e.getType())) {
            var col:EventListenerCollection = EventListenerCollection(_listeners.get(e.getType())) ;
            col.propagate(e) ;
        }
        if (e.isCancelled()) return e ;
        _globalListeners.propagate(e);
        if (isQueue == false || e.isCancelled()) return e ;
        _queue.enqueue(e) ;
        return e;
	}
	
	
}