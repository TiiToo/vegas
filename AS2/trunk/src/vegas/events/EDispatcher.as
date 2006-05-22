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

/** EDispatcher

	AUTHOR
	
		Name : EDispatcher
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-11
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		Private

	METHOD SUMMARY
	
		- addEventListener( eventName:String, obj, func ):Void 
		
		- dispatchEvent(ev):Void 
		
		- eventListenerExists(eventName:String, obj , func):Boolean
		
		- static initialize( target )
		
			Permet d'injecter dans un objet les méthodes définies par l'interface IDispatcher
		
		- removeAllEventListeners(eventName:String):Void 
		
		- removeEventListener( eventName:String, obj , func):Void 
		
		- updateEvent(eventName:String, oInit):Void 

	INSPIRATION & COMPATIBILITY 
	
		GDispatcher by Grant Skinner, http://gskinner.com/

**/

import vegas.events.Delegate;
import vegas.util.Mixin;

class vegas.events.EDispatcher {

	// -----o Constructor

	private function EDispatcher() {
		//
	}
	
	// ----o Mixin
		
	static public function initialize ( target ):Void {
		var attributes:Array = [
			"addEventListener" , "dispatchEvent", "eventListenerExists" ,
			"removeAllEventListeners" , "removeEventListener" , "updateEvent" 
		] ;
		var mix:Mixin = new Mixin( EDispatcher, target, attributes ) ; 
		mix.run() ;
	}
	
	static public function toString() : String {
		return "[EDispatcher]";
	}
	
	// -----o Private Properties

	private var _listeners ;
	
	// -----o Private Methods

	private function addEventListener( eventName:String, obj, func ):Void {
		if (!eventName) return ;
		if (!_listeners) _listeners = {} ;
		var a:Array = _listeners[eventName] ;
		if (!a) _listeners[eventName] = a = [] ;
		if (EDispatcher.indexOf( a , obj , func) == -1) {
			a.push({ o:obj , f:func }) ;
		}
	}
	
	private function dispatchEvent(ev):Void {
		if (ev.type == "ALL") return ;
		var a:Array ; 
		if (ev.target == undefined) ev.target = this ;
		this[ev.type + "_handler"](ev) ;
		a = _listeners[ev.type] ;
		if (a) EDispatcher.dispatch(ev.target, a, ev) ;
		a = _listeners["ALL"] ;
		if (a) EDispatcher.dispatch(ev.target, a, ev) ;
	}
	
	private function eventListenerExists(eventName:String, obj , func):Boolean {
		var a:Array = _listeners[eventName] ;
		return (EDispatcher.indexOf(a, obj, func)  > -1) ;
	}

	private function removeAllEventListeners(eventName:String):Void {
		if (eventName) delete _listeners[eventName] ;
		else delete _listeners ;
	}

	private function removeEventListener( eventName:String, obj , func):Void {
		var a:Array = _listeners[eventName] ;
		if (!a) return ;
		var id:Number = EDispatcher.indexOf(a, obj, func) ;
		if (id > -1) a.splice(id, 1) ;
	}
	
	private function updateEvent(eventName:String, oInit):Void {
		var ev = { 	type:eventName, target:this } ;
		if ( oInit != undefined ) for (var each:String in oInit) ev[each] = oInit[each] ;
		dispatchEvent( ev ) ;
	}
	
	// ----o Static public Methods
	
	static public function dispatch( target, a:Array , ev ):Void {
		for (var each in a) {
			var item = a[each] ;
			var o = item.o ;
			var f = item.f ;
			var tof:String = typeof(o) ;
			if (tof == "object" || tof == "movieclip") {
				if (f instanceof Function) {
					Delegate.create(o, f)(ev) ;
				} else if (o["handleEvent"] && !f) {
					o["handleEvent"](ev) ;
				} else {
					if (f == undefined) f = ev.type ;
					if (typeof(f) == "string") {
						o[f].apply(o, [ev]) ;
					}
				}
			} else { // function
				o.apply(target, [ev]) ;
			}
		}	
	}
	
	static public function indexOf( a:Array, o , f):Number {
		var l:Number = a.length ;
		while (--l > -1) {
			var item = a[l] ;
			if (item.o == o && item.f == f) return l ; 
		}
		return -1;
	}

	
}
