/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard AS3 Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.net.remoting
{
	import flash.events.TimerEvent;
	import flash.net.Responder;
	import flash.net.registerClassAlias;
	import flash.utils.Timer;
	
	import asgard.events.RemotingEvent;
	import asgard.net.TimeoutPolicy;
	
	import pegas.process.Action;
	
	import vegas.core.ICloneable;
	import vegas.errors.Warning;
	import vegas.util.ClassUtil;

	/**
	 * This class provides a service object to communicate with a remoting gateway server.
	 * @author eKameleon
 	 */
	public class RemotingService extends Action implements ICloneable
	{
		
		/**
		 * Creates a new RemotingService instance.
	 	 * @param gatewayUrl the url of the gateway of the remoting service.
		 * @param serviceName the name of the service in the server.
	 	 * @param responder (optional) The RemotingServiceResponder use to receive data from the server.
		 */
		public function RemotingService( gatewayUrl:String=null , serviceName:String=null , responder:Responder=null )
		{
			
			super();
			
			setGatewayUrl( gatewayUrl );
			setServiceName( serviceName ) ;
			setResponder( responder ) ;
		
			_timer = new Timer(DEFAULT_DELAY, 1) ;
			setTimeoutPolicy(TimeoutPolicy.LIMIT) ;
			
		}
		
		static public const DEFAULT_DELAY:uint = 8000 ; // 8 secondes

		static public const LEVEL_ERROR:String = "error" ;

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

		public var multipleSimultaneousAllowed:Boolean = false ;

		public function get serviceName():String 
		{ 
			return getServiceName() ;	
		}
	
		public function set serviceName(sName:String):void 
		{ 
			setServiceName(sName) ;
		}

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
		override public function clone():*
		{
			return new RemotingService( getGatewayUrl() , getServiceName() ) ; // TODO : see the responder !
		}
		
		/**
		 * Returns the internal RemotingConnection reference.
		 * @return the internal RemotingConnection reference.
		 */
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

        /**
         * Returns the timeout policy.
         */
		public function getTimeoutPolicy():TimeoutPolicy 
		{
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

		/**
		 * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF).
		 */
		static public function registerClassAlias( classObject:Class, aliasName:String=null  ):void
		{
			
			if (aliasName == null)
			{
				aliasName = ClassUtil.getPath(classObject) ;
			}
			
			flash.net.registerClassAlias(aliasName, classObject) ;	
					
		}

		override public function run(...arguments:Array):void 
		{
						
			_rc = RemotingConnection.getConnection( _gatewayUrl ) ;

	
			if ( (_rc == null) && !(_rc is RemotingConnection) ) 
			{
				throw new Warning(this + ", You can't run the RemotingConnection.") ;
			}
		
			if (_authentification != null)
			{
				_rc.setCredentials(_authentification) ;
			}
			
			if (getRunning() && multipleSimultaneousAllowed == false)  
			{
				notifyProgress() ;
			}
			else 
			{
				
				notifyStarted() ;

				_result = null ;
				
				setRunning(true) ;	

				var args:Array = [_serviceName + "." + _methodName , getResponder()].concat(_args) ;
				
				_rc.call.apply( _rc, args );
				
				_timer.start() ;
						
			} 
		}

		public function setCredentials( authentification:RemotingAuthentification=null ):void  
		{			
			_authentification = authentification ;
		}

		/**
		 * Set timeout interval duration.
		 */
		public function setDelay( time:uint , useSeconds:Boolean=false):void 
		{
			if (useSeconds) time = Math.round(time * 1000) ;
			_timer.delay = time ;
		}
		
		public function setGatewayUrl( url:String ):void 
		{
			_gatewayUrl = url ;
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



		// ----o Protected Methods

		protected function notifyError( code:String ):void 
		{
			
			setRunning(false) ;
			
			var eError:RemotingEvent = new RemotingEvent(RemotingEvent.ERROR) ;
			eError.code = (code == null) ? RemotingEvent.ERROR : code ;
			dispatchEvent( eError ) ;
			
			notifyFinished() ;
			
		}	

		protected function notifyFault(fault:Object):void
		{
			var eFault:RemotingEvent = new RemotingEvent(RemotingEvent.FAULT) ;
			eFault.setFault(fault, _methodName) ;
			dispatchEvent( eFault ) ;
		}

		protected function notifyResult():void
		{
			
			var eResult:RemotingEvent = new RemotingEvent(RemotingEvent.RESULT, _result, _methodName) ;
			dispatchEvent( eResult ) ;
			
		}

		private var _args:Array ;
		
		private var _authentification:RemotingAuthentification ;
		
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
		
		private function _onResult( data:* ):void
		{
			
			_timer.stop() ; // stop timeout interval
			
			_result = data ;
			
			setRunning(false) ;

			notifyResult() ;

			notifyFinished() ;

		}

		private function _onStatus( fault:Object ):void 
		{

			_timer.stop() ; // stop timeout interval

			setRunning(false) ;
			
			notifyFault(fault) ;
			
			notifyFinished() ;

		}

		private function _onTimeOut(e:TimerEvent):void 
		{
			
			_timer.stop() ;
			
			setRunning(false) ;
			
			notifyTimeOut() ;

			notifyFinished() ;
			
		}

	}
	
}