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


/** NetServerConnection

	AUTHOR

		Name : NetServerConnection
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-04-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	PROPERTY SUMMARY
	
		- isConnected:Boolean
		
		- uri:String
		
	METHOD SUMMARY
	
		- addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void
	
		- addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void
	
		- addHeader()
		
		- call(remoteMethod:String, resultObject:Object):Void
		
		- close():Void
	
		- connect(targetURI:String):Boolean
	
		- dispatchEvent(event, isQueue:Boolean, target, context):Event
	
		- getDelay():Number

		- getDispatcher():EventDispatcher
		
		- getEventDispatcher():EventDispatcher
		
		- getEventListeners(eventName:String):EventListenerCollection
		
		- getGlobalEventListeners():EventListenerCollection
		
		- getLimitPolicy():ConnectionPolicy
		
		- getRegisteredEventNames():Set
		
		- getParent():EventDispatcher
		
		- hashCode():Number
		
		- hasEventListener(eventName:String):Boolean
		
		- initEventDispatcher():EventDispatcher
		
		- removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener
		
		- removeGlobalEventListener( listener ):EventListener
		
		- setDelay(n:Number, useSeconds:Boolean):Void
		
		- setLimitPolicy( policy:NetServerPolicy ):Void
		
		- setParent(parent:EventDispatcher):Void	INHERIT
	
	INHERIT
	
		NetConnection → NetServerConnection

	IMPLEMENTS
	
		Action, EventTarget, IEventDispatcher, IHashable, IFormattable

**/

// TODO voir notifyAccept !! Pour le moment méthode non utilisée

import asgard.events.NetServerEvent;
import asgard.events.NetServerEventType;
import asgard.net.NetServerPolicy;
import asgard.net.NetServerStatus;
import asgard.process.Action;

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.data.Set;
import vegas.events.Delegate;
import vegas.events.Event;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;
import vegas.events.IEventDispatcher;
import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.ConstructorUtil;
import vegas.util.Timer;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
dynamic class asgard.net.NetServerConnection extends NetConnection implements Action, IEventDispatcher, IFormattable, IHashable {
	
	// ----o Constructor
	
	function NetServerConnection() {
		
		super() ;
		
		_dispatcher = initEventDispatcher() ;
		
		_eClose = new NetServerEvent( NetServerEventType.CLOSE , this ) ;
		_eFinish = new NetServerEvent( NetServerEventType.FINISH , this ) ;
		_eStart = new NetServerEvent( NetServerEventType.START , this ) ;
		_eStatus = new NetServerEvent( NetServerEventType.NET_STATUS , this ) ;
		_eTimeOut = new NetServerEvent( NetServerEventType.TIMEOUT , this ) ;		
		
		_timer = new Timer(8000, 1) ;
		_timeOut = new Delegate(this, _onTimeOut) ;
		
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(NetServerConnection.prototype) ;

	// ----o Public Methods

	public function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void {
		_dispatcher.addEventListener.apply(_dispatcher, arguments);
	}
	
	public function addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void {
		_dispatcher.addGlobalEventListener(listener, priority, autoRemove) ;
	}

	public function clone() {
		return new NetServerConnection() ;	
	}

	/*override*/ public function close( noEvent:Boolean ):Void {
		super.close() ;
		_timer.stop() ;
		if (!noEvent) notifyClose() ;
	}

	/*override*/ public function connect():Boolean {
		if (isConnected) return false ;
		notifyStarted() ;
		return super.connect.apply(this, arguments) ;
	}

	public function dispatchEvent(event, isQueue:Boolean, target, context):Event {
		return _dispatcher.dispatchEvent(event, isQueue, target, context) ;
	}
	
	/**
	 * Return timeout interval duration.
	 */
	public function getDelay():Number {
		return _timer.getDelay() ;	
	}

	public function getDispatcher():EventDispatcher {
		return _dispatcher ;
	}

	public function getEventDispatcher():EventDispatcher {
		return _dispatcher ;
	}
	
	public function getEventListeners(eventName:String):EventListenerCollection {
		return _dispatcher.getEventListeners(eventName) ;
	}

	public function getGlobalEventListeners():EventListenerCollection {
		return getGlobalEventListeners() ;
	}

	public function getLimitPolicy():NetServerPolicy {
		return _policy ;	
	}
	
	function getRegisteredEventNames():Set {
		return _dispatcher.getRegisteredEventNames() ;
	}
	
	public function getParent():EventDispatcher {
		return _dispatcher.parent ;
	}

	public function hashCode():Number {
		return null ;
	}
	
	public function hasEventListener(eventName:String):Boolean {
		return _dispatcher.hasEventListener(eventName) ;
	}

	public function initEventDispatcher():EventDispatcher {
		return new EventDispatcher(this) ;
	}

	public function notifyClose():Void {
		dispatchEvent( _eClose ) ;	
	}

	public function notifyFinished():Void {
		dispatchEvent(_eFinish) ;
	}

	public function notifyStarted():Void {
		dispatchEvent( _eStart ) ;
	}
	
	public function notifyStatus( info:NetServerStatus ):Void {
		_eStatus.setInfo(info) ;
		dispatchEvent( _eStatus ) ;	
	}

	public function notifyTimeOut():Void {
		dispatchEvent(_eTimeOut) ;	
	}
	
	public function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener {
		return _dispatcher.removeEventListener(eventName, listener, useCapture) ;
	}

	public function removeGlobalEventListener( listener ):EventListener {
		return _dispatcher.removeGlobalEventListener(listener) ;
	}

	public function run():Void {
		connect(uri) ;	
	}

	/**
	 * Set timeout interval duration.
	 */
	public function setDelay(n:Number, useSeconds:Boolean):Void {
		var t:Number = (n > 0) ? n : 0 ;
		if (useSeconds) t = Math.round(t * 1000) ;
		_timer.setDelay(t) ;
	}

	/**
	 * Use limit timeout interval.
	 * @see StreamPolicy
	 */
	public function setLimitPolicy( policy:NetServerPolicy ):Void {
		_policy = policy ;
		if (_policy == NetServerPolicy.LIMIT) {
			_timer.addEventListener(TimerEventType.TIMER, _timeOut) ;
		} else {
			_timer.removeEventListener(TimerEventType.TIMER, _timeOut) ;
		}
	}

	public function setParent(parent:EventDispatcher):Void {
		_dispatcher.parent = parent ;
	}

	public function toString():String {
		return "[" + ConstructorUtil.getName(this) + "]" ;
	}

	// ----o Private Properties
	
	private var _dispatcher:EventDispatcher ;
	private var _eClose:NetServerEvent ;
	private var _eFinish:NetServerEvent ;
	private var _eStart:NetServerEvent ;
	private var _eStatus:NetServerEvent ;
	private var _eTimeOut:NetServerEvent ;
	private var _policy:NetServerPolicy ;
	private var _timer:Timer ;
	private var _timeOut:EventListener ;
	
	// ----o Private Methods

	private function onStatus( oInfo ):Void {
		_timer.stop() ;
		
		var code:NetServerStatus = NetServerStatus.format(oInfo.code) ;
		
		// trace("> " + this + ".onStatus(" + code + ")") ;
		
		switch (code) {

			case NetServerStatus.BAD_VERSION :
				notifyStatus(NetServerStatus.BAD_VERSION) ;
				break ;

			case NetServerStatus.CLOSED :
				notifyStatus(NetServerStatus.CLOSED) ;
				break ;

			case NetServerStatus.FAILED :
				notifyStatus(NetServerStatus.FAILED) ;
				break ;

			case NetServerStatus.INVALID :
				notifyStatus(NetServerStatus.INVALID) ;
				break ;
				
			case NetServerStatus.REJECTED :
				notifyStatus(NetServerStatus.REJECTED) ;
				break ;

			case NetServerStatus.SHUTDOWN :
				notifyStatus(NetServerStatus.SHUTDOWN) ;
				break ;

			case NetServerStatus.SUCCESS :
				notifyStatus(NetServerStatus.SUCCESS) ;
				break ;

		}
		notifyFinished() ;
	}

	public function _onTimeOut(e:TimerEvent):Void {
		notifyTimeOut() ;
		notifyFinished() ;
		close() ;
	}

}