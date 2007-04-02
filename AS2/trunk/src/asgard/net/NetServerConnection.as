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

import asgard.events.NetServerEvent;
import asgard.events.NetServerEventType;
import asgard.net.NetServerPolicy;
import asgard.net.NetServerStatus;

import pegas.process.Action;

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.core.ISerializable;
import vegas.data.Set;
import vegas.events.Delegate;
import vegas.events.Event;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;
import vegas.events.IEventDispatcher;
import vegas.events.TimerEvent;
import vegas.util.ConstructorUtil;
import vegas.util.Timer;
import vegas.util.TypeUtil;

/**
 * This class extends the NetConnection class and defined an implementation based on VEGAS to used Flash Remoting or Flash MediaServer (with AMF protocol).
 * @author eKameleon
 */	
dynamic class asgard.net.NetServerConnection extends NetConnection implements Action, IEventDispatcher, IFormattable, IHashable, ISerializable 
{
	
	/**
	 * Creates a new NetServerConnection instance.
	 */
	function NetServerConnection() 
	{
		_dispatcher = initEventDispatcher() ;
		_eClose = new NetServerEvent( NetServerEventType.CLOSE , this ) ;
		_eFinish = new NetServerEvent( NetServerEventType.FINISH , this ) ;
		_eStart = new NetServerEvent( NetServerEventType.START , this ) ;
		_eStatus = new NetServerEvent( NetServerEventType.NET_STATUS , this ) ;
		_eTimeOut = new NetServerEvent( NetServerEventType.TIMEOUT , this ) ;		
		_timer = new Timer(8000, 1) ;
		_timeOut = new Delegate(this, _onTimeOut) ;
	}

	/**
	 * This method is overrides if you want receive Events from the server.
	 * @see NetServerGateway
	 */
	public var receiveSharedEvent:Function ;

	/**
	 * Allows the registration of event listeners on the event target.
	 * @param eventName A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 * @param useCapture Determinates if the event flow use capture or not.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	public function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void 
	{
		_dispatcher.addEventListener.apply(_dispatcher, arguments);
	}

	/**
	 * Allows the registration of global event listeners on the event target.
	 * 
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <b>EventListener</b> interface.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	public function addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void 
	{
		_dispatcher.addGlobalEventListener(listener, priority, autoRemove) ;
	}

	/**
	 * Returns the shallow copy of this object.
	 * @return the shallow copy of this object.
	 */
	public function clone() 
	{
		return new NetServerConnection() ;	
	}

	/**
	 * Close the connection.
	 * @param noEvent if this argument is {@code true} the event propagation is disabled.
	 */
	/*override*/ public function close( noEvent:Boolean ):Void 
	{
		super.close() ;
		_timer.stop() ;
		if (!noEvent) 
		{
			notifyClose() ;
		}
	}

	/**
	 * Connect the client with this method.
	 */
	/*override*/ public function connect():Boolean 
	{
		if (isConnected) 
		{
			return false ;
		}
		notifyStarted() ;
		return super.connect.apply(this, arguments) ;
	}

	/**
	 * Dispatches an event into the event flow.
	 * @param event The Event object that is dispatched into the event flow.
	 * @param isQueue if the EventDispatcher isn't register to the event type the event is bufferized.
	 * @param target the target of the event.
	 * @param contect the context of the event.
	 * @return the reference of the event dispatched in the event flow.
	 */
	public function dispatchEvent(event, isQueue:Boolean, target, context):Event 
	{
		return _dispatcher.dispatchEvent(event, isQueue, target, context) ;
	}
	
	/**
	 * Returns the timeout interval duration.
	 * @return the timeout interval duration.
	 */
	public function getDelay():Number 
	{
		return _timer.getDelay() ;	
	}

	/**
	 * Returns the internal {@code EventDispatcher} reference.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	public function getDispatcher():EventDispatcher 
	{
		return _dispatcher ;
	}

	/**
	 * Returns the internal {@code EventDispatcher} reference.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	public function getEventDispatcher():EventDispatcher 
	{
		return _dispatcher ;
	}
	
	/**
	 * Returns the {@code EventListenerCollection} of the specified event name.
	 * @return the {@code EventListenerCollection} of the specified event name.
	 */
	public function getEventListeners(eventName:String):EventListenerCollection 
	{
		return _dispatcher.getEventListeners(eventName) ;
	}

	/**
	 * Returns the {@code EventListenerCollection} of this EventDispatcher.
	 * @return the {@code EventListenerCollection} of this EventDispatcher.
	 */
	public function getGlobalEventListeners():EventListenerCollection 
	{
		return _dispatcher.getGlobalEventListeners() ;
	}

	public function getLimitPolicy():NetServerPolicy 
	{
		return _policy ;	
	}

	/**
	 * Returns a {@code Set} of all register event's name in this EventListener.
	 * @return a {@code Set} of all register event's name in this EventListener.
	 */	
	public function getRegisteredEventNames():Set 
	{
		return _dispatcher.getRegisteredEventNames() ;
	}
	
	/**
	 * Returns the EventDispatcher parent reference of this instance.
	 * @return the EventDispatcher parent reference of this instance.
	 */
	public function getParent():EventDispatcher 
	{
		return _dispatcher.parent ;
	}

	/**
	 * Returns a hash code value for the object.
	 * @return a hash code value for the object.
	 */
	public function hashCode():Number 
	{
		return null ;
	}

	/**
	 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
	 */ 
	public function hasEventListener(eventName:String):Boolean 
	{
		return _dispatcher.hasEventListener(eventName) ;
	}
	
	/**
	 * Creates and returns the internal {@code EventDispatcher} reference (this method is invoqued in the constructor).
	 * You can overrides this method if you wan use a global {@code EventDispatcher} singleton.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	public function initEventDispatcher():EventDispatcher 
	{
		return new EventDispatcher(this) ;
	}

	public function notifyClose():Void 
	{
		dispatchEvent( _eClose ) ;	
	}

	public function notifyFinished():Void 
	{
		dispatchEvent(_eFinish) ;
	}

	public function notifyStarted():Void 
	{
		dispatchEvent( _eStart ) ;
	}
	
	public function notifyStatus( status:NetServerStatus , info ):Void 
	{
		_eStatus.setInfo(info) ;
		_eStatus.setStatus(status) ;
		dispatchEvent( _eStatus ) ;	
	}

	public function notifyTimeOut():Void 
	{
		dispatchEvent(_eTimeOut) ;	
	}

	/** 
	 * Removes a listener from the EventDispatcher object.
	 * If there is no matching listener registered with the {@code EventDispatcher} object, then calling this method has no effect.
	 * @param Specifies the type of event.
	 * @param the class name(string) or a {@code EventListener} object.
	 */
	public function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener 
	{
		return _dispatcher.removeEventListener(eventName, listener, useCapture) ;
	}

	/** 
	 * Removes a global listener from the EventDispatcher object.
	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
	 * @param the string representation of the class name of the EventListener or a EventListener object.
	 */
	public function removeGlobalEventListener( listener ):EventListener 
	{
		return _dispatcher.removeGlobalEventListener(listener) ;
	}
	
	/**
	 * Runs the process of this NetServerConnection.
	 */
	public function run():Void 
	{
		connect(uri) ;	
	}

	/**
	 * Sets the internal {@code EventDispatcher} reference.
	 */
	public function setEventDispatcher( e:EventDispatcher ):Void 
	{
		_dispatcher = e || initEventDispatcher() ;
	}

	/**
	 * Set timeout interval duration.
	 */
	public function setDelay(n:Number, useSeconds:Boolean):Void 
	{
		var t:Number = (n > 0) ? n : 0 ;
		if (useSeconds) t = Math.round(t * 1000) ;
		_timer.setDelay(t) ;
	}

	/**
	 * Use limit timeout interval.
	 * @see NetServerPolicy
	 */
	public function setLimitPolicy( policy:NetServerPolicy ):Void 
	{
		_policy = policy ;
		if (_policy == NetServerPolicy.LIMIT) 
		{
			_timer.addEventListener(TimerEvent.TIMER, _timeOut) ;
		}
		else 
		{
			_timer.removeEventListener(TimerEvent.TIMER, _timeOut) ;
		}
	}

	/**
	 * Sets the parent EventDispatcher reference of this instance.
	 */
	public function setParent(parent:EventDispatcher):Void 
	{
		_dispatcher.parent = parent ;
	}

	/**
	 * Use this method to dispatch in FMS application an event.
	 */
	public function sharedEvent( event , context ):Void 
	{
		if (event instanceof Event) 
		{
			this.call( event.getType(), null, event ) ;
		}
		else if (TypeUtil.typesMatch(event, String)) 
		{
			this.call( event, null, context ) ;
		}
	}

	/**
	 * Returns the string Eden representation of this object.
	 * @return the string Eden representation of this object.
	 */
	/*override*/ public function toSource(indent : Number, indentor : String) : String 
	{
		return null ;
	}
	
	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	public function toString():String 
	{
		return "[" + ConstructorUtil.getName(this) + "]" ;
	}

	private var _dispatcher:EventDispatcher ;
	private var _eClose:NetServerEvent ;
	private var _eFinish:NetServerEvent ;
	private var _eStart:NetServerEvent ;
	private var _eStatus:NetServerEvent ;
	private var _eTimeOut:NetServerEvent ;
	private var _policy:NetServerPolicy ;
	private var _timer:Timer ;
	private var _timeOut:EventListener ;
	
	static private var _initHashCode:Boolean = HashCode.initialize(NetServerConnection.prototype) ;

	/**
	 * Invoqued when the onStatus event is invoqued.
	 * @see NetServerStatus
	 */	
	private function onStatus( oInfo ):Void 
	{
		
		_timer.stop() ;
		
		var code:NetServerStatus = NetServerStatus.format(oInfo.code) ;
		
		// trace("> " + this + ".onStatus(" + oInfo.code+ ")") ;
		
		switch (code) 
		{
			
			case NetServerStatus.BAD_VERSION :
			{
				notifyStatus(NetServerStatus.BAD_VERSION) ;
				break ;
			}
			case NetServerStatus.CLOSED :
			{
				notifyStatus(NetServerStatus.CLOSED) ;
				break ;
			}
			case NetServerStatus.FAILED :
			{
				notifyStatus(NetServerStatus.FAILED, oInfo) ;
				break ;
			}
			case NetServerStatus.INVALID :
			{
				notifyStatus(NetServerStatus.INVALID) ;
				break ;
			}	
			case NetServerStatus.REJECTED :
			{
				notifyStatus(NetServerStatus.REJECTED) ;
				break ;
			}
			case NetServerStatus.SHUTDOWN :
			{
				notifyStatus(NetServerStatus.SHUTDOWN) ;
				break ;
			}
			case NetServerStatus.SUCCESS :
			{
				notifyStatus(NetServerStatus.SUCCESS) ;
				break ;
			}
		}
		
		notifyFinished() ;
		
	}

	/**
	 * Invoqued when the connection is out of time.
	 */
	private function _onTimeOut(e:TimerEvent):Void 
	{
		notifyTimeOut() ;
		notifyFinished() ;
		close() ;
	}

}