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

/**	BasicEvent

	AUTHOR
	
		Name : BasicEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var e:BasicEvent = new BasicEvent(type:String, target, context) ;

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
		
		- hashCode():Number
		
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
	
		CoreObject → BasicEvent
	
	IMPLEMENTS 
		
		Event, ICloneable, IFormattable, IHashable

	HISTORY
	
		ADD : [2006-01-22] getTime() method
		ADD : [2006-01-22] initEvent(type:String, bubbles:Boolean, cancelable:Boolean)
		REFACTORING : [2006-01-22] getTime() -> getTimeStamp()

**/

import vegas.core.CoreObject;
import vegas.core.ISerializable;
import vegas.events.Event;
import vegas.events.EventPhase;
import vegas.util.ConstructorUtil;
import vegas.util.serialize.Serializer;

/**
 * {@code BasicEvent} is the basical event structure to work with {@link EventDispatcher} and {@link FastDispatcher}.
 * 
 * @author  eKameleon
 * @version 1.0.0.0
 * @see     CoreObject	
 * @see     Event	
 * @since   
 */
class vegas.events.BasicEvent extends CoreObject implements Event, ISerializable {

	// ----o Constructor
	
	/**
	 * Constructs a new {@code BasicEvent} instance.
	 * 
	 * <p>
	 *    <code>
	 *     var e:BasicEvent = new BasicEvent(type, target, context, [bubbles:Boolean, [eventPhase:Number, [time:Number, [stop:Boolean]]]]) ;
	 *    </code>
	 * </p>
	 * @param type:String 
	 * @param target
	 * @param context
	 * @param bubbles:Boolean
	 * @param eventPhase:Number
	 * @param time:Number
	 * @param stop:Boolean
	 */
	public function BasicEvent(
		type:String
		, target
		, context
		, p_bubbles:Boolean
		, p_eventPhase:Number
		, p_time:Number
		, p_stop:Number 
	) {
		
		_type = type || null ;
		
		_context = context || null ;
		
		_target = target || null ;
		
		_bubbles = (p_bubbles != null) ? p_bubbles : true ;
		
		_eventPhase = isNaN(p_eventPhase) ? EventPhase.AT_TARGET : p_eventPhase ; ;
		
		_time = (p_time > 0) ? p_time : ( (new Date()).valueOf() ) ;
		
		stop = isNaN(p_stop) ? EventPhase.NONE : p_stop ;
		
	}
	
	// ----o Public Property
	
	public var stop:Number ;

	// ----o Public Methods

	public function cancel():Void {
		_cancelled = true ;
	}
	
	/**
	 * @return a new clone reference.
	 */
	public function clone() {
		return new BasicEvent(getType(), getTarget(), getContext()) ;
	}

	/**
	 * @return 'true' if the event is bubbling.
	 */
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
		_type = type || null ;
	}
	
	public function stopPropagation():Void {
		stop = EventPhase.STOP ;
	}
	
	public function stopImmediatePropagation():Void {
		stop = EventPhase.STOP_IMMEDIATE ;
	}

	public function toSource(indent : Number, indentor : String) : String {
		return Serializer.getSourceOf(this, _getParams()) ;
	}

	public function toString():String {
		var phase:Number = getEventPhase() ;
		var name:String = ConstructorUtil.getName(this);
		var txt:String = "[" + name ;
		if (getType()) txt += " " + getType() ;
		switch (phase) {
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
		if (getBubbles() && phase != EventPhase.BUBBLING_PHASE) {
			txt += ", bubbles" ;
		}
		if (isCancelled()) {
			txt += ", can cancel" ;
		}
		txt += "]" ;
		return txt ;
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

	// ----o Protected Methods
	
	/*protected*/ private function _getParams():Array {
		return [
			Serializer.toSource(getType()) ,
			Serializer.toSource(getTarget()) ,
			Serializer.toSource(getContext()) ,
			Serializer.toSource(getBubbles()) ,
			Serializer.toSource(getEventPhase()) ,
			Serializer.toSource(getTimeStamp()) ,
			Serializer.toSource(stop)
		] ;
	}
	
	/*protected*/ private function _setTimeStamp( nTime:Number ):Void {
		_time = (nTime >= 0) ? nTime : (new Date()).valueOf() ;	
	}

}