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

// TODO réimplémenter AbstractAction ?
// TODO cabler l'événement TIMEOUT

package asgard.net.remoting
{

	
	import asgard.process.IAction;
	
	import asgard.data.remoting.RecordSet ;
	import asgard.events.ActionEvent;
	import asgard.events.RemotingEvent ;

	import flash.net.Responder ;

	import vegas.core.ICloneable;
	import vegas.events.AbstractCoreEventBroadcaster;

	public class RemotingService extends AbstractCoreEventBroadcaster implements IAction, ICloneable
	{
		
		// ----o Constructor
		
		public function RemotingService( gatewayUrl:String=null , serviceName:String=null , responder:Responder=null )
		{
			
			super();
			
			setGatewayUrl( gatewayUrl );
			setServiceName( serviceName ) ;
			setResponder( responder ) ;
		
			_eError = new RemotingEvent(RemotingEvent.ERROR)  ;

			_eFinish = new ActionEvent(ActionEvent.FINISH) ;
			
			_eFault = new RemotingEvent( RemotingEvent.FAULT) ;
			
			_eResult = new RemotingEvent( RemotingEvent.RESULT) ;
			
			_eProgress = new ActionEvent(ActionEvent.PROGRESS) ;
			
			_eStart = new ActionEvent(ActionEvent.START) ;
			
			_eTimeOut = new RemotingEvent(RemotingEvent.TIMEOUT) ;
			
		}
		
		// ----o Constants
	
		static public const LEVEL_ERROR:String = "error" ;

		// ----o Public Properties
	
		public var multipleSimultaneousAllowed:Boolean = false ;

		// ----o Public Methods

		public function clone():*
		{
			return new RemotingService( getGatewayUrl() , getServiceName() ) ; // TODO voir pour le responder !
		}
		
		public function getConnection():RemotingConnection 
		{
			return _rc ;	
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

		public function getRunning():Boolean 
		{
			return _isRunning ;	
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

		public function notifyFinished():void
		{
			dispatchEvent( _eFinish ) ;
		}

		public function notifyProgress():void
		{
			dispatchEvent(_eProgress) ;
		}

		public function notifyResult():void
		{
		
			_eResult = new RemotingEvent(RemotingEvent.RESULT, getResult(), getMethodName()) ;
			dispatchEvent( _eResult ) ;
			
		}

		public function notifyStarted():void
		{
			dispatchEvent( _eStart ) ;
		}
	

		public function run(...arguments:Array):void {
		
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
				var arg:Array = [_serviceName + "." + _methodName , getResponder()].concat(_args) ;
				
				_rc.call.apply( _rc, arg );
				
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
			_responder = (responder == null) ?  new Responder(_onResult, _onStatus) : responder ;
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

		public function get running():Boolean 
		{
			return getRunning() ;	
		}

		public function get serviceName():String 
		{ 
			return getServiceName() ;	
		}
	
		public function set serviceName(sName:String):void 
		{ 
			setServiceName(sName) ;
		}

		// ----o Protected Methods
	
		protected function _setRunning(b:Boolean):void
		{
			_isRunning = b ;	
		}

		// ----o Private Properties
	
		private var _args:Array ;
		
		private var _eError:RemotingEvent ;
		
		private var _eFinish:ActionEvent ;
		
		private var _eFault:RemotingEvent ;
		
		private var _eResult:RemotingEvent ;
		
		private var _eProgress:ActionEvent ;
		
		private var _eStart:ActionEvent ;
		
		private var _eTimeOut:RemotingEvent ;

		private var _gatewayUrl:String = null  ;
		
		private var _isProxy:Boolean = false ;
		
		private var _isRunning:Boolean = false ;
		
		private var _methodName:String ; 
		
		private var _rc:RemotingConnection = null ;
		
		private var _result:* = null ;
		
		private var _serviceName:String = null ;
		
		private var _responder:Responder = null ;

		// ----o Private Methods
		
		private function _onResult( data:* ):void
		{
			
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

			_eFault.setFault(fault, _methodName) ;
			
			_setRunning(false) ;
			
			dispatchEvent( _eFault ) ;
			
			notifyFinished() ;

		}
		
	}
	
}