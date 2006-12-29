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

/** RemotingService

	AUTHOR
	
		Name : RemotingService
		Package : asgard.net.remoting
		Version : 1.0.0.0
		Date :  2006-05-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

 	DESCRIPTION
	
		- gatewayUrl:String [R/W]

		- isDynamic:Boolean [R/W]
		
		- methodName:String [R/W]
		
		- params:Array [R/W]
		
		- serviceName:String [R/W]
		
	METHOD SUMMARY
	
		- addEventListener(eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void
		
		- addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void
		
		- dispatchEvent( event , [isQueue, [target, [context]]]):Event
		
		- getEventDispatcher():EventDispatcher 
		
 		- getEventListeners(eventName:String):EventListenerCollection
		
		- getGlobalEventListeners():EventListenerCollection
		
		- getParent():EventDispatcher
		
		- getRegisteredEventNames():Set
		
		- initEventDispatcher():EventDispatcher 
		
 		- hasEventListener(eventName:String):Boolean
		
		- removeEventListener(eventName:String, listener, useCapture:Boolean ):EventListener
		
		- removeGlobalEventListener(o):EventListener
		
		- setParent(parent:EventDispatcher):Void
	
	INHERIT

		 CoreObject → AbstractCoreEventDispatcher → AbstractAction → RemotingService
 
 	IMPLEMENTS
 
		Action, EventTarget, IEventDispatcher, IFormattable, IHashable

*/

// TODO rajouter les logs et les erreurs.

import asgard.events.RemotingEvent;
import asgard.net.remoting.RemotingAuthentification;
import asgard.net.remoting.RemotingConnection;
import asgard.net.remoting.RemotingConnectionCollector;
import asgard.net.remoting.RemotingFormat;
import asgard.net.remoting.RemotingServiceResponder;
import asgard.net.TimeoutPolicy;

import pegas.process.AbstractAction;

import vegas.events.Delegate;
import vegas.events.EventListener;
import vegas.events.TimerEvent;
import vegas.util.Timer;

/**
 * @author eKameleon
 */
dynamic class asgard.net.remoting.RemotingService extends AbstractAction 
{
	
	// ----o Constructor
	
	function RemotingService( gatewayUrl:String , serviceName:String , responder:RemotingServiceResponder ) 
	{
		
		super() ;
		
		setGatewayUrl( gatewayUrl );
		setServiceName( serviceName ) ;
		setResponder( responder ) ;
		
		_eFinish = new RemotingEvent(RemotingEvent.FINISH, this) ;
		_eProgress = new RemotingEvent(RemotingEvent.PROGRESS, this) ;
		_eStart = new RemotingEvent(RemotingEvent.START, this) ;
		_eError = new RemotingEvent(RemotingEvent.ERROR, this)  ;
		
		_global.System.onStatus = Delegate.create (this, _onStatus) ;
		
		_timerListener = new Delegate(this, _onTimeOut) ;
		_timer = new Timer(DEFAULT_DELAY, 1) ;
		setTimeoutPolicy(TimeoutPolicy.LIMIT) ;
		
	}
	
	// ----o Constants
	
	static public var DEFAULT_DELAY:Number = 8000 ; // 8 secondes

	static public var LEVEL_ERROR:String = "error" ;

	static private var __ASPF__ = _global.ASSetPropFlags(RemotingService, null , 7, 7) ;
	
	// ----o Public Properties
	
	public var multipleSimultaneousAllowed:Boolean ;
	
	// ----o Public Methods

	public function clone() 
	{
		return new RemotingService( getGatewayUrl() , getServiceName() ) ; // TODO voir pour le responder !
	}

	public function getConnection() 
	{
		return _rc ;	
	}

	/**
	 * Returns timeout interval duration.
	 */
	public function getDelay():Number
	{
		return _timer.delay ;
	}

	public function getIsProxy():Boolean 
	{
		return _isProxy ;	
	}
	
	public function getGatewayUrl():String 
	{
		return _gatewayUrl ;	
	}

	public function getMethodName():String 
	{
		return _methodName ;
	}

	public function getParams():Array {
		return _args  ;	
	}

	public function getResponder():RemotingServiceResponder 
	{
		return _responder ;
	}

	public function getResult() 
	{
		return _result ;	
	}

	public function getServiceName():String 
	{
		return _serviceName ;
	}

	public function notifyError( code:String ):Void 
	{
		_timer.stop() ;
		_setRunning(false) ;
		_eError.code = code || RemotingEvent.ERROR ;
		dispatchEvent( _eError ) ;
		notifyFinished() ;
	}	

	public function onFault( e:RemotingEvent ) : Void 
	{
		_timer.stop() ;
		_setRunning(false) ;
		e.setTarget(this) ;
		dispatchEvent( e ) ;
		notifyFinished() ;
	}

	public function onResult( e:RemotingEvent ):Void 
	{
		_timer.stop() ;
		_setRunning(false) ;
		e.setTarget(this) ;
		_result = e.getResult() ;
		dispatchEvent( e ) ;
		notifyFinished() ;
	}

	public function run():Void 
	{
		
		_rc = RemotingConnection.getConnection( _gatewayUrl ) ;
		
		if (_rc == null ) {
			// ici notifier qu'il est impossible de lancer la connection.	
		}
		
		if (_authentification != null)
		{
			_rc.setCredentials(_authentification) ;
		}
		
		if ( getRunning() && multipleSimultaneousAllowed == false)  
		{
			notifyProgress() ;
		}
		else 
		{
			notifyStarted() ;
			_result = null ;
			_setRunning(true) ;
			_timer.start() ;
			var arg:Array = [_serviceName + "." + _methodName , getResponder()].concat(_args) ;
			_rc.call.apply( _rc, arg );
			
		} 
	}

	
	public function setCredentials( authentification:RemotingAuthentification ):Void  
	{
		_authentification = authentification ;
	}

	/**
	 * Set timeout interval duration.
	 */
	public function setDelay( time:Number , useSeconds:Boolean ):Void 
	{
		if (useSeconds) time = Math.round(time * 1000) ;
		_timer.delay = time ;
	}
	
	public function setGatewayUrl( url:String ):Void 
	{
		if (_gatewayUrl) RemotingConnectionCollector.remove(_gatewayUrl) ;
		if (url) {
			_gatewayUrl = url ;
			_rc = RemotingConnection.getConnection( _gatewayUrl ) ;
		} else {
			_rc = null ;	
		}
	}

	public function setIsProxy(b:Boolean):Void 
	{
		_isProxy = b ;
		__resolve = b ? __resolve__ : null ;	
	}



	public function setParams(args:Array):Void 
	{
		_args = args ;	
	}
		
	public function setMethodName( sName:String ):Void 
	{
		_methodName = sName ;	
	}
	
	public function setResponder( responder:RemotingServiceResponder ):Void 
	{
		if (_responder) _responder.setService(null) ;
		_responder = responder || new RemotingServiceResponder(this, onResult, onFault) ;
		_responder.setService(this) ;
	}

	public function setServiceName( sName:String ):Void 
	{
		_serviceName = sName ;	
	}

	/**
	 * Use limit timeout interval.
	 * @see TimeoutPolicy
	 */
	public function setTimeoutPolicy( policy:TimeoutPolicy ):Void 
	{
		_policy = policy ;
		
		if (_policy == TimeoutPolicy.LIMIT) 
		{
			_timer.addEventListener( TimerEvent.TIMER, _timerListener) ;
		}
		else 
		{
			_timer.removeEventListener(TimerEvent.TIMER, _timerListener) ;
		}
	}

	public function trigger():Void 
	{
		run() ;	
	}

	public function toString():String 
	{
		return (new RemotingFormat()).formatToString(this) ;	
	}

	// ----o Virtual Properties

	public function get gatewayUrl():String 
	{ 
		return getGatewayUrl() ;
	}
	
	public function set gatewayUrl(sUrl:String):Void 
	{ 
		setGatewayUrl(sUrl) ;
	}

	public function get isProxy():Boolean 
	{ 
		return getIsProxy() ;
	}
	
	public function set isProxy(b:Boolean):Void 
	{ 
		setIsProxy(b) ;
	}

	public function get params():Array 
	{ 
		return getParams() ;
	}
	
	public function set params(ar:Array):Void 
	{ 
		setParams(ar) ;
	}

	public function get methodName():String 
	{ 
		return getMethodName() ;
	}
	
	public function set methodName(sName:String):Void 
	{ 
		setMethodName(sName) ;
	}

	public function get serviceName():String 
	{ 
		return getServiceName() ;
	}
	
	public function set serviceName(sName:String):Void 
	{ 
		setServiceName(sName) ;
	}

	// ----o Private Properties
	
	private var _args:Array ;
	
	private var _authentification:RemotingAuthentification ;
	
	private var _eError:RemotingEvent ;
	
	private var _eFinish:RemotingEvent ;
	
	private var _eProgress:RemotingEvent ;
	
	private var _eStart:RemotingEvent ;
	
	private var _gatewayUrl:String = null  ;
	
	private var _isProxy:Boolean = false ;
	
	private var _methodName:String ; 

	private var _policy:TimeoutPolicy ;

	private var _rc:RemotingConnection = null ;
	
	private var __resolve = null ;
	
	private var _result = null ;
	
	private var _serviceName:String = null ;
	
	private var _responder:RemotingServiceResponder = null ;

	private var _timer:Timer ;
	
	private var _timerListener:EventListener ;

	// ----o Private Methods

	private function __resolve__( methodName:String ):Function 
	{
		
		if (_rc == null ) {
			// ici notifier qu'il est impossible de lancer la connection.	
			return null ;
		}
		
		if(methodName == "__path__") {
			return null ; // hack pour le toString avec ConstructorUtil.getName !!
		}
		
		var responder:RemotingServiceResponder = getResponder() ;
		responder.setMethodName(methodName) ;

		var rc:RemotingConnection = _rc ;
		var serviceName:String = _serviceName ;

		return function () {
			var args:Array = [ serviceName + "." + methodName , responder ].concat(arguments) ;
			return rc.call.apply( rc, args ); 
		} ;
		
		
	}
	
	private function _onStatus ( ev:Object ):Void 
	{
		
		_timer.stop() ; // stop timeout interval
		
		if (ev.level == RemotingService.LEVEL_ERROR) 
		{
			notifyError(ev.code) ;
		}
	}

	private function _onTimeOut(e:TimerEvent):Void 
	{
		
		_timer.stop() ;
		
		_rc.close() ;
		
		_setRunning(false) ;
		
		notifyTimeOut() ;
		notifyFinished() ;
			
	}

}