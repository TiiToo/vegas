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

/* ------- 	FastDispatcher

	AUTHOR
	
		Name : FastDispatcher
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var dispatcher:FastDispatcher = new FastDispatcher( ar:Array ) ;
		
	USE
	
		import vegas.events.Event ;
		import vegas.events.FastDispatcher ;
	
		function onTest( ev:Event ):Void {
			trace ("--------") ;
			trace ("type : " + ev.getType()) ;
			trace ("target : " + ev.getTarget()) ;
			trace ("context : " + ev.getContext()) ;
			trace ("this : " + this) ;
		}	

		var oFD:FastDispatcher = new FastDispatcher() ;
		
		trace ("addListener this : " + oFD.addListener(this)) ;
		trace ("hasListeners : " + oFD.hasListeners()) ;
		trace ("size : " + oFD.size()) ;
		oFD.dispatch( { type : "onTest", target : this } ) ;
		oFD.removeAllListeners() ;
		oFD.dispatch( { type : "onTest", target : this } ) ;
 
	METHOD SUMMARY
	
		- addListener(listener):Boolean
		
			Registers an object to receive event notification messages. 
			This method is called on the broadcasting object and the listener object is sent as an argument.
		
		- broadcastMessage(eventName:String, [param1, param2, .., paramN]) ;

			Sends an event message to each object in the list of listeners.
			When the message is received by the listening object, Flash Player attempts to invoke a function of the same name on the listening object.
					
		- dispatch(event)

			Sends an Event Object to each object in the list of listeners. 
			When the Event is received by the listening object, Flash Player attempts to invoke a function of the same name on the Event.type property.

		- isEmpty():Boolean
		
			Return true is the listeners list is empty.
		
		- iterator():Iterator
		
			Return an iterator of _listeners list.
		
		- removeAllListeners():Boolean
			
			clear listeners list.
		
		- removeListener()
		
			Removes an object from the list of objects that receive event notification messages. 
		
		- size():Number

			Return count of listeners.
		
		- toString():String

	INHERIT
	
		CoreObject
			|
			FastDispatcher

	IMPLEMENTS
	
		Iterable, IFormattable, IHashable

	CHANGE :: 2005-12-15 constructor more easy with [].concat(ar) 
	
	TODO   :: 2006-01-19 modifier la m�thode dispatch et utiliser _getEvent comme dans EventDispatcher
----------  */

import vegas.core.CoreObject;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.events.DynamicEvent;
import vegas.events.Event;
import vegas.util.Mixin;

class vegas.events.FastDispatcher extends CoreObject implements Iterable {

	// ----o Constructor
	
	public function FastDispatcher( ar:Array ) {
		_listeners = (ar.length > 0) ? [].concat(ar) : [] ;
	}

	// ----o Mixin
	
	static public function initialize ( target ):Void {
		var properties:Array = [
			"addListener" , "broadcastMessage", "dispatch", "iterator" ,
			"removeAllListeners" , "removeListener" , "size"
		] ;
		var mix:Mixin = new Mixin( FastDispatcher, target, properties ) ; 
		mix.run() ;
	}

	// ----o Inject AsBroadcaster
	
	static private var _initBroadcaster = AsBroadcaster.initialize(FastDispatcher.prototype) ;

	// ----o static public Method
	
	public function addListener(listener):Boolean {
		return null ; // Mixin
	}
	
	public function clone() {
		return new FastDispatcher(_listeners) ;
	}
	
	public function dispatch(event):Event {
		if (!event) return null ;
		var e:Event ;
		var tof:String = typeof(event) ;
		if (event instanceof Event) e = event ;
		else if (tof == "string") e = new DynamicEvent(event) ;
		else if (tof == "object") {
			if (event.type == undefined) return null ;
			e = new DynamicEvent(event) ;
			e.setType(event.type) ;
			e.setTarget(event.target) ;
			e.setContext(event.context) ;
		}
		broadcastMessage(e.getType(), e) ;
		return e ;
	}
	
	public function getListeners():Array {
		return [].concat(_listeners) ;
	}
	
	public function isEmpty():Boolean {
		return _listeners.length == 0 ;
	}
	
	public function iterator():Iterator {
		return new ArrayIterator(_listeners) ;
	}

	public function removeAllListeners():Void {
		_listeners.splice(0) ;
	}
	
	public function removeListener(listener):Boolean {
		return null ; // Mixin
	}
	
	public function size():Number {
		return _listeners.length ;
	}
	
	// ----o Private Properties
	
	private var _listeners:Array ;
	private var broadcastMessage:Function ;
	
}