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

/** EDispatcher
 
	AUTHOR
	
		Name : EDispatcher
		type : SSAS
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
 
	METHODS
	
		- addEventListener( eventName , o , f ) 
		
		- dispatchEvent(ev)
		
		- eventListenerExists(eventName, obj, func)
		
		- removeAllEventListeners(eventName)
		
		- removeEventListener(eventName, o, f)
		
		- updateEvent(eventName, oInit)
 
	EXAMPLE
	

	THANKS :
	
		Inspiration & Compatibility : GDispatcher by Grant Skinner, http://gskinner.com/
 
**/

/**
 * The old event model of VEGAS inspired by the <a href='http://livedocs.macromedia.com/flash/mx2004/main_7_2/wwhelp/wwhimpl/common/html/wwhelp.htm?context=Flash_MX_2004&file=00003105.html'>mx.events.EventDispatcher</a> in the V2 components framework and inspired by the <a href='http://www.gskinner.com/blog/archives/000027.html>GDispatcher</a> class of Grant Skinner.
 * <p>This event model is depreciated, used {@code EventDispatcher} class in VEGAS please.</p>
 * <p><b>Example :</b></p>
 * {@code
 * listener.onSpeak = function (e) 
 * {
 *     trace ("> " + this + ".onSpeak() :: " + e.type + " - "  + e.target ) ;
 * }
 * 
 * listener.test = function (e) 
 * {
 *     trace ("> " + this + ".test() :: " + e.type + " - "  + e.target ) ;
 * }
 * 
 * var onDelegateSpeak = function (e) 
 * {
 *     trace ("> " + this + ".onDelegateSpeak() :: " + e.type + " - "  + e.target ) ;
 * }
 * 
 * var i = new Dispatcher() ;
 * 
 * i.addEventListener("onSpeak", listener) ;
 * i.addEventListener("onSpeak", listener, onDelegateSpeak) ;
 * i.addEventListener("onSpeak", listener, "test") ;
 * 
 * i.speak() ;
 * 
 * trace ("----")  ;
 * 
 * i.removeEventListener("onSpeak", listener, onDelegateSpeak) ;
 * 
 * i.speak() ;
 * }
 * @author eKameleon
 * @see IDispatcher interface to creates concrete EDispatcher implementations.
 * @see FastDispatcher
 * @see EventDispatcher
 * @see vegas.events.type package with all core class with the IDispatcher implementation and the EDispatcher mixin.
 */
if (vegas.events.EDispatcher == undefined) 
{

	/**
	 * The EDispatcher singleton.
	 */	
	vegas.events.EDispatcher = function() {}
	
	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.EDispatcher.extend(vegas.core.CoreObject) ;
 
	/**
	 * Launch the mixin of the specified target object. 
	 * Injected in this object the methods addEventListener, dispatchEvent, eventListenerExists, removeAllEventListeners, removeEventListener and dispatchEvent.
	 * @see Mixin  
	 */
	vegas.events.EDispatcher.initialize = function (target /*Object*/ ) 
	{
		if (target == undefined) return null ;
		var attributes = [
			"addEventListener" , 
			"dispatchEvent", 
			"eventListenerExists" ,
			"removeAllEventListeners" , 
			"removeEventListener" , 
			"updateEvent" 
		] ;
		var i = new vegas.events.EDispatcher ;
		var l = attributes.length ;
		while(--l > -1) 
		{
			var prop = attributes[l] ;
			target[prop] = i[prop] ;
		}
	}
 
 	/**
 	 * Returns the string representation of the object.
 	 * @return the string representation of the object.
 	 */
	vegas.events.EDispatcher.toString = function() /*String*/ 
	{
		return "[EDispatcher]" ;
	}
 
	vegas.events.EDispatcher.prototype._listeners = null ;
	
	vegas.events.EDispatcher.prototype.addEventListener = function ( eventName /*String*/ , obj /*Object*/, func ) /*Void*/ 
	{
		
		if (typeof(eventName) == "string") {
			
			if (this._listeners == null) {
				
				this._listeners = {} ;
				
			}
			
			var a = this._listeners[eventName] ;
			
			if (a == undefined) {
				
				this._listeners[eventName] = a = [] ;
				
			}
			
			if ( vegas.events.EDispatcher.indexOf( a , obj , func) == -1 ) {
				
				a.push( { scope:obj , method:func } ) ;
				
			}
			
		}
	}
	
	vegas.events.EDispatcher.dispatch = function ( target /*Object*/ , a /*Array*/ , ev /*Object*/ ) /*Void*/
	{
		
		var i = 0 ;
		var len = a.length ;	
		
		for ( i ; i<len ; i++ ) {
			
			var item = a[i] ;
			var o = item.scope ;
			var f = item.method ;
			var tof = typeof(o) ;
			
			if (tof == "object") 
			{
				if (f instanceof Function) 
				{
					f = vegas.events.Delegate.create(o, f) ;
					if (f != undefined) 
					{
						f(ev) ;
					}
				} 
				else if (o["handleEvent"] != undefined && f == undefined) 
				{
					o["handleEvent"](ev) ;
				} 
				else 
				{
					if (f == undefined) f = ev.type ;
					if (typeof(f) == "string" && o[f] != undefined) 
					{
						o[f].apply(o, [ev]) ;
					}
				}
			} 
			else if ( o instanceof Function )
			{ 
				o.call( target, ev ) ;
			}
		}
		
	}
	
	vegas.events.EDispatcher.prototype.dispatchEvent = function ( ev /*Object*/ ) /*Void*/
	{
		if ( typeof (ev.type) == "string") 
		{
			if ( ev.type == "ALL") 
			{
				return ;
			}
			
			var a /*Array*/ ;
			
			if (ev.target == undefined) {
				
				ev.target = this ;
				
			}
			
			var f = this[ev.type + "_handler"] ;
			
			if (f != undefined) f(ev) ;
			
			a = this._listeners[ev.type] ;
			
			if (a != undefined ) 
			{
				vegas.events.EDispatcher.dispatch( ev.target, a, ev ) ;
			}
			
			a = this._listeners["ALL"] ;
			
			if (a != undefined) 
			{
				vegas.events.EDispatcher.dispatch(ev.target, a, ev) ;
			}
			
		}
		
	}
	
	vegas.events.EDispatcher.prototype.eventListenerExists = function (eventName/*String*/, obj /*Object*/, func/*Object*/) /*Boolean*/ 
	{
		var a = _listeners[eventName] ;
		if (a == undefined) return false ;
		return (EDispatcher.indexOf(a, obj, func)  > -1) ;
	}

	vegas.events.EDispatcher.indexOf = function ( a /*Array*/ , scope /*Object*/ , method /*Object*/ ) /*Number*/ 
	{
		var l = a.length ;
		while (--l > -1) 
		{
			var item = a[l] ;
			if (item.scope == scope && item.method == method) return l ; 
		}
		return -1 ;
	}
 
	vegas.events.EDispatcher.prototype.removeAllEventListeners = function(eventName/*String*/) /*Void*/ 
	{
		if (eventName) 
		{
			delete this._listeners[eventName] ;
		}
		else 
		{
			delete this._listeners ;
		}
	}
 
	vegas.events.EDispatcher.prototype.removeEventListener = function ( eventName /*String*/ , obj /*Object*/ , func /*Object*/ ) /*Void*/ 
	{
		var a = this._listeners[eventName] ;
		if (a == undefined) 
		{
			return ;
		}
		var id = vegas.events.EDispatcher.indexOf(a, obj, func) ;
		if (id > -1) 
		{
			a.splice(id, 1) ;
		}
	}
	
	vegas.events.EDispatcher.prototype.updateEvent = function ( eventName/*String*/, oInit/*Object*/) /*Void*/ 
	{
		var ev = {} ;
		ev.dynamic = true ;
		ev.type = eventName ;
		ev.target = this ;
		if ( oInit != undefined ) for (var each in oInit) ev[each] = oInit[each] ;
		this.dispatchEvent( ev ) ;
	}
 
}