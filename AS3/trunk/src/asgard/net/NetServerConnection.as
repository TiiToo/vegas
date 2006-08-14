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

/* NetServerConnection

	AUTHOR

		Name : NetServerConnection
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-08-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
*/


package asgard.net
{

	import flash.events.NetStatusEvent ;
	import flash.events.TimerEvent ;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.utils.Timer;

	import asgard.events.NetServerEvent;
	import asgard.net.NetServerPolicy ;
	import asgard.net.NetServerStatus ;
	
	import vegas.core.HashCode;
	import vegas.core.ICloneable;
	import vegas.core.IHashable; 
	import vegas.core.IRunnable;
	import vegas.core.ISerializable;
	
	import vegas.util.ClassUtil;	

	public class NetServerConnection extends NetConnection implements ICloneable, IHashable, IRunnable, ISerializable
	{
		
		// ----o Constructor
		
		public function NetServerConnection()
		{
			super();
			
			_eClose = new NetServerEvent( NetServerEvent.CLOSE ) ;
			_eFinish = new NetServerEvent( NetServerEvent.FINISH ) ;
			_eStart = new NetServerEvent( NetServerEvent.START ) ;
			_eStatus = new NetServerEvent( NetServerEvent.NET_STATUS ) ;
			_eTimeOut = new NetServerEvent( NetServerEvent.TIMEOUT ) ;
			
			_timer = new Timer(8000, 1) ;
			
			objectEncoding = ObjectEncoding.AMF0 ;
			
			addEventListener(NetStatusEvent.NET_STATUS, _onStatus) ;
			
		}

		// ----o Init HashCode
	
		static private var _initHashCode:Boolean = HashCode.initialize(NetServerConnection.prototype) ;

		// ----o Public Properties
		
		public var noEvent:Boolean = false ;
		
		// -----o Public Methods
		
		public function clone():*
		{
			return new NetServerConnection() ;
		}

		override public function close():void 
		{
			super.close() ;
			_timer.stop() ;
			if (!noEvent) notifyClose() ;
		}

		override public function connect(command:String, ... arguments):void
		{
			notifyStarted() ;
			super.connect.apply(this, [command].concat(arguments)) ;
		}


		public function getLimitPolicy():NetServerPolicy {
			return _policy ;	
		}

		public function hashCode():uint
		{
			return null ;
		}

		public function run( ...arguments:Array ):void 
		{
			connect(uri) ;	
		}

		/**
		 * Set timeout interval duration.
		 */
		public function setDelay(n:Number, useSeconds:Boolean):void 
		{
			var t:Number = (n > 0) ? n : 0 ;
			if (useSeconds) t = Math.round(t * 1000) ;
			_timer.delay = t ;
		}

		/**
		 * Use limit timeout interval.
		 * @see StreamPolicy
		 */
		public function setLimitPolicy( policy:NetServerPolicy ):void 
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
		
		public function toSource(...arguments:Array):String
		{
			return "new NetServerConnection()" ;
		}
		
		override public function toString():String
		{
			return "[" + ClassUtil.getName(this) + "]" ;
		}

		// ----o Protected Methods

		protected function notifyClose():void 
		{
			dispatchEvent( _eClose ) ;	
		}

		protected function notifyFinished():void 
		{
			dispatchEvent(_eFinish) ;
		}

		protected function notifyStarted():void 
		{
			dispatchEvent( _eStart ) ;
		}
	
		protected function notifyStatus( status:NetServerStatus , info:*=null ):void 
		{
			_eStatus.setInfo(info) ;
			_eStatus.setStatus(status) ;
			dispatchEvent( _eStatus ) ;	
		}

		protected function notifyTimeOut():void
		{
			dispatchEvent(_eTimeOut) ;	
		}

		// ----o Private Properties
		
		private var _eClose:NetServerEvent ;
		private var _eFinish:NetServerEvent ;
		private var _eStart:NetServerEvent ;
		private var _eStatus:NetServerEvent ;
		private var _eTimeOut:NetServerEvent ;
		private var _policy:NetServerPolicy ;
		private var _timer:Timer ;
	
		// ----o Private Methods
	
		private function _onStatus( e:NetStatusEvent ):void
		{
		
			_timer.stop() ;
		
			var code:NetServerStatus = NetServerStatus.format(e.info.code) ;
		
			trace("> " + this + "._onStatus(" + code + ")") ;
		
			switch (code) 
			{
		
				case NetServerStatus.BAD_VERSION :
					notifyStatus( NetServerStatus.BAD_VERSION ) ;
					break ;
				
				case NetServerStatus.CLOSED :
					notifyStatus(NetServerStatus.CLOSED) ;
					break ;
				
				case NetServerStatus.FAILED :
					notifyStatus(NetServerStatus.FAILED, e.info) ;
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
	
		public function _timeOut(e:TimerEvent):void 
		{
			notifyTimeOut() ;
			notifyFinished() ;
			close() ;
		}
		
		
	}
	
}