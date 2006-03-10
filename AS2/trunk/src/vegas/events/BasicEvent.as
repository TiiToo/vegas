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

/* ------- 	BasicEvent

	AUTHOR
	
		Name : BasicEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var ev:BasicEvent = new BasicEvent(type:String, target, context) ;

	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext()
		
		- getCurrentTarget()
		
		- getEventPhase():Number
		
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		- initEvent(type:String, bubbles:Boolean, cancelable:Boolean)
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setTarget(target):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation():Void
		
		- toString():String
	
	INHERIT
	
		Object > BasicEvent
	
	IMPLEMENTS 
		
		Event, ICloneable, IFormattable, IHashable

	HISTORY
	
		ADD : [2006-01-22] getTime() method
		ADD : [2006-01-22] initEvent(type:String, bubbles:Boolean, cancelable:Boolean)
		REFACTORING : [2006-01-22] getTime() -> getTimeStamp()

----------  */

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.events.EventFormat;
import vegas.events.EventPhase;

class vegas.events.BasicEvent extends CoreObject implements Event {

	// ----o Constructor
	
	public function BasicEvent(type:String, target, context){
		_bubbles = true ;
		_context = context || null ;
		_eventPhase = EventPhase.AT_TARGET ;
		stop = EventPhase.NONE ;
		_target = target || null ;
		_time = (new Date()).valueOf() ;
		_type = type ;
	}
	
	// ----o Public Property
	
	public var stop:Number ;

	// ----o Public Methods

	public function cancel():Void {
		_cancelled = true ;
	}
	
	public function clone() {
		return new BasicEvent(_type, _target, _context) ;
	}

	public function getBubbles():Boolean {
		return _bubbles ;
	}

	public function getContext() {
		return _context ;
	}

	public function getCurrentTarget() {
		return _currentTarget ;
	}

	public function getEventPhase():Number {
		return _eventPhase ;
	}

	public function getTarget() {
		return _target ;
	}
	
	public function getTimeStamp():Number {
		return _time ;
	}

	public function getType():String {
		return _type ;
	}

	public 	function initEvent(type:String, bubbles:Boolean, cancelable:Boolean):Void {
		_type = type ;
		_bubbles = bubbles ;
		_cancelled = cancelable ;
		_time = (new Date()).valueOf() ;
	}

	public function isCancelled():Boolean {
		return _cancelled ;
	}

	public function isQueued():Boolean {
		return _inQueue ;
	}
	
	public function queueEvent():Void {
		_inQueue = true ;
	}

	public function setBubbles(b:Boolean):Void {
		_bubbles = b ;
	}

	public function setContext(context):Void {
		_context = context || null ;
	}

	public function setCurrentTarget(target):Void {
		_currentTarget = target ;
	}

	public function setEventPhase(n:Number):Void {
		_eventPhase = n ;
	}

	public function setTarget(target):Void {
		_target = target || null ;
	}

	public function setType(type:String):Void {
		_type = type ;
	}
	
	public function stopPropagation():Void {
		stop = EventPhase.STOP ;
	}
	
	public function stopImmediatePropagation():Void {
		stop = EventPhase.STOP_IMMEDIATE ;
	}
	
	public function toString():String {
		return (new EventFormat()).formatToString(this) ;
	}
  
	// ----o Private Properties

	private var _bubbles:Boolean ;
	private var _context = null ;
	private var _currentTarget ;
	private var _cancelled:Boolean = false ;
	private var _eventPhase:Number ;
	private var _inQueue:Boolean = false ;
	private var _target = null ;
	private var _time:Number ;
	private var _type:String ;

	
}