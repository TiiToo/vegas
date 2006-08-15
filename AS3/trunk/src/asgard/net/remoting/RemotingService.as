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

/* RemotingService

	AUTHOR

		Name : RemotingService
		Package : asgard.net.remoting
		Version : 1.0.0.0
		Date :  2006-08-15
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/

// TODO cabler l'événement TIMEOUT

package asgard.net.remoting
{

	
	import asgard.process.AbstractAction;
	
	import asgard.data.remoting.RecordSet ;
	import asgard.events.ActionEvent;
	import asgard.events.NetServerEvent;
	import asgard.events.RemotingEvent ;
	import asgard.net.TimeoutPolicy ;

	import flash.events.TimerEvent ;	
	import flash.net.Responder ;
	import flash.utils.Timer;

	import vegas.core.ICloneable;
	import vegas.events.AbstractCoreEventBroadcaster;

	public class RemotingService extends AbstractAction implements ICloneable
	{
		
		// ----o Constructor
		
		public function RemotingService( gatewayUrl:String=null , serviceName:String=null , responder:Responder=null )
		{
			
			super();
			
			setGatewayUrl( gatewayUrl );
			setServiceName( serviceName ) ;
			setResponder( responder ) ;
		
			_timer = new Timer(DEFAULT_DELAY, 1) ;
			setTimeoutPolicy(TimeoutPolicy.LIMIT) ;
			
			_eError = new RemotingEvent(RemotingEvent.ERROR)  ;
			
			_eFault = new RemotingEvent( RemotingEvent.FAULT) ;
			
			_eResult = new RemotingEvent( RemotingEvent.RESULT) ;
			
			_eTimeOut = new RemotingEvent(RemotingEvent.TIMEOUT) ;
			
		}
		
		// ----o Constants
		
		static public const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
		static public const LEVEL_ERROR:String = "error" ;

		// ----o Public Properties
	
		public var multipleSimultaneousAllowed:Boolean = false ;

		// ----o Public Methods

		override public function clone():*
		{
			return new RemotingService( getGatewayUrl() , getServiceName() ) ; // TODO voir pour le responder !
		}
		
		public function getConnection():RemotingConnection 
		{
			return _rc ;	
		}

		/**
		 * Returns timeout interval duration.
		 */
		public function getDelay():uint
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

		public function getTimeoutPolicy():TimeoutPolicy {
			return _policy ;	
		}

		public function getMethodName():String 
		{
			return _methodName ;
		}

		public function getParams():Array 
		{
			return _args  ;	
		}

		public function getResponder():Responder 
		{
			return _responder ;
		}

		public function getResult():*
		{
			return _result ;	
		}

		public function getServiceName():String 
		{
			return _serviceName ;
		}

		public function notifyError( code:String ):void 
		{
			_setRunning(false) ;
			_eError.code = (code == null) ? RemotingEvent.ERROR : code ;
			dispatchEvent( _eError ) ;
			notifyFinished() ;
		}	

		public function notifyResult():void
		{
		
			_eResult.setResult( getResult(), getMethodName() ) ;
			dispatchEvent( _eResult ) ;
			
		}

		public function notifyTimeOut():void
		{
			dispatchEvent(_eTimeOut) ;
		}

		override public function run(...arguments:Array):void {
		
			if (_rc == null ) {
				// ici notifier qu'il est impossible de lancer la connection.	
			}
		
			if (getRunning() && multipleSimultaneousAllowed == false)  
			{
				notifyProgress() ;
			}
			else 
			{
				
				notifyStarted() ;

				_result = null ;

				_setRunning(true) ;	

				var args:Array = [_serviceName + "." + _methodName , getResponder()].concat(_args) ;
				
				_rc.call.apply( _rc, args );
				
				_timer.start() ;
						
			} 
		}
		
		/**
		 * Set timeout interval duration.
		 */
		public function setDelay( time:uint , useSeconds:Boolean=false):void 
		{
			if (useSeconds) time = Math.round(time * 1000) ;
			_timer.delay = time ;
		}

		/**
		 * Use limit timeout interval.
		 * @see TimeoutPolicy
		 */
		public function setTimeoutPolicy( policy:TimeoutPolicy ):void 
		{
			_policy = policy ;
			if (_policy == TimeoutPolicy.LIMIT) 
			{
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
			}
			else 
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
			}
		}

		public function setParams(args:Array):void 
		{
			_args = args ;	
		}
	
		public function setCredentials( authentification:RemotingAuthentification ):void  
		{
			_rc.setCredentials(authentification) ;
		}
	
		public function setGatewayUrl( url:String ):void 
		{
			if (_gatewayUrl != null)
			{
				RemotingConnectionCollector.remove(_gatewayUrl) ;
			} 
			if (url) 
			{
				_gatewayUrl = url ;
				_rc = RemotingConnection.getConnection( _gatewayUrl ) ;
			}
			else
			{
				_rc = null ;	
			}
		}

		public function setIsProxy(b:Boolean):void 
		{
			_isProxy = b ;
		}
		
		public function setMethodName( sName:String ):void 
		{
			_methodName = sName ;	
		}
	
		public function setResponder( responder:Responder=null ):void 
		{
			_responder = (responder == null) ?  _internalResponder : responder ;
		}

		public function setServiceName( sName:String ):void 
		{
			_serviceName = sName ;	
		}

		public function trigger():void 
		{
			run() ;	
		}

		override public function toString():String 
		{
			return (new RemotingFormat()).formatToString(this) ;	
		}

		// ----o Virtual Properties

		public function get gatewayUrl():String 
		{ 
			return getGatewayUrl() ;
		}
	
		public function set gatewayUrl(sUrl:String):void 
		{ 
			setGatewayUrl(sUrl) ;
		}

		public function get isProxy():Boolean 
		{ 
			return getIsProxy() ;
		}
	
		public function set isProxy(b:Boolean):void 
		{ 
			setIsProxy(b) ;
		}

		public function get params():Array 
		{ 
			return getParams() ;
		}
	
		public function set params(ar:Array):void 
		{ 
			setParams(ar) ;	
		}

		public function get methodName():String 
		{ 
			return getMethodName() ;	
		}
	
		public function set methodName(sName:String):void 
		{ 
			setMethodName(sName) ;
		}

		public function get serviceName():String 
		{ 
			return getServiceName() ;	
		}
	
		public function set serviceName(sName:String):void 
		{ 
			setServiceName(sName) ;
		}

		// ----o Private Properties
	
		private var _args:Array ;
		
		private var _eError:RemotingEvent ;
		
		private var _eFault:RemotingEvent ;
		
		private var _eResult:RemotingEvent ;
		
		private var _eTimeOut:RemotingEvent ;

		private var _gatewayUrl:String = null  ;

		private var _internalResponder:Responder = new Responder(_onResult, _onStatus) ;
		
		private var _isProxy:Boolean = false ;
		
		private var _methodName:String ; 

		private var _policy:TimeoutPolicy ;

		private var _rc:RemotingConnection = null ;

		private var _responder:Responder = null ;
		
		private var _result:* = null ;
		
		private var _serviceName:String = null ;
		
		private var _timer:Timer ;
		
		// ----o Private Methods
		
		private function _onResult( data:* ):void
		{
						
			_timer.stop() ; // stop timeout interval
			
			if (data.hasOwnProperty("serverInfo") )
			{
				data = new RecordSet(data) ;
			}
			
			if (data is RecordSet) 
			{
				data.setParentService( this ) ;
			}

			_result = data ;
			
			_setRunning(false) ;

			notifyResult() ;

			notifyFinished() ;

		}

		private function _onStatus( fault:Object ):void 
		{

			_timer.stop() ; // stop timeout interval

			_eFault.setFault(fault, _methodName) ;
			
			_setRunning(false) ;
			
			dispatchEvent( _eFault ) ;
			
			notifyFinished() ;

		}

		public function _onTimeOut(e:TimerEvent):void 
		{
			
			_timer.stop() ;
			
			notifyTimeOut() ;

			notifyFinished() ;
			
		}

	}
	
}