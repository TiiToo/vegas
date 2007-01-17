/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.net
{

	import asgard.events.NetServerEvent;
	
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.utils.Timer;
	
	import vegas.core.HashCode;
	import vegas.core.ICloneable;
	import vegas.core.IHashable;
	import vegas.core.IRunnable;
	import vegas.core.ISerializable;
	import vegas.util.ClassUtil;

	/**
	 * @author eKameleon
	 */
	public class NetServerConnection extends NetConnection implements ICloneable, IHashable, IRunnable, ISerializable
	{
		
		/**
		 * Creates a new NetServerConnection instance.
		 */
		public function NetServerConnection()
		{
			super();
			
			_eClose = new NetServerEvent( NetServerEvent.CLOSE ) ;
			_eFinish = new NetServerEvent( NetServerEvent.FINISH ) ;
			_eStart = new NetServerEvent( NetServerEvent.START ) ;
			_eStatus = new NetServerEvent( NetServerEvent.NET_STATUS ) ;
			_eTimeOut = new NetServerEvent( NetServerEvent.TIMEOUT ) ;
			
			_timer = new Timer(DEFAULT_DELAY, 1) ;
			
			objectEncoding = ObjectEncoding.AMF0 ;
			
			addEventListener( IOErrorEvent.IO_ERROR , onIOError) ;
			addEventListener( NetStatusEvent.NET_STATUS, _onStatus) ;
			addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
		}
		
		// ----o Init HashCode
		
		static private var _initHashCode:Boolean = HashCode.initialize(NetServerConnection.prototype) ;
		
		// ----o Constants
		
		static public const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
		
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
		
		/**
		 * Returns timeout interval duration.
		 */
		public function getDelay():uint
		{
			return _timer.delay ;
		}
		
		public function getTimeoutPolicy():TimeoutPolicy {
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
		 * @see TimeoutPolicy
		 */
		public function setLimitPolicy( policy:TimeoutPolicy ):void 
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
		
		public function toSource(...arguments:Array):String
		{
			return "new asgard.net.NetServerConnection()" ;
		}
		
		override public function toString():String
		{
			return "[" + ClassUtil.getName(this) + "]" ;
		}
		
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
			_timer.start() ;
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
		
		protected function onIOError(e:IOErrorEvent):void
		{
			_timer.stop() ;
			trace("> " + this + "onIOError : " + e) ;
			notifyFinished() ;
		}
		
		protected function onSecurityError(e:SecurityErrorEvent):void
		{
			_timer.stop() ;
			trace("> " + this + "onSecurityError : " + e) ;
			notifyFinished() ;
		}
		
		// ----o Private Properties
		
		private var _eClose:NetServerEvent ;
		private var _eFinish:NetServerEvent ;
		private var _eStart:NetServerEvent ;
		private var _eStatus:NetServerEvent ;
		private var _eTimeOut:NetServerEvent ;
		private var _policy:TimeoutPolicy ;
		private var _timer:Timer ;
		
		private function _onStatus( e:NetStatusEvent ):void
		{
			
			_timer.stop() ;
			
			var code:NetServerStatus = NetServerStatus.format(e.info.code) ;
			
			// trace("> " + this + "._onStatus(" + code + ")") ;
			
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
		
		public function _onTimeOut(e:TimerEvent):void 
		{
			
			_timer.stop() ;
			
			notifyTimeOut() ;
			notifyFinished() ;
			close() ;
			
		}
		
		
	}
	
}