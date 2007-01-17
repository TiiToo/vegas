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

package asgard.events
{
	
	import flash.events.Event;
	
	import asgard.net.NetServerConnection ;
	import asgard.net.NetServerInfo ;
	import asgard.net.NetServerStatus ;

	import vegas.core.ICloneable ;

	public class NetServerEvent extends Event
	{
		
		// ----o Constructor
		
		public function NetServerEvent(type:String, connection:NetServerConnection=null, status:NetServerStatus=null, info:*=null)
		{
			super(type) ;
			setConnection(connection) ;
			setInfo( info ) ;
			setStatus( status ) ;
		}

		// ----o Constants

		static public const ACCEPTED:String = "onAccepted" ;
	
		static public const CLOSE:String = "onClosed" ;
		
		static public const FINISH:String = "onFinished" ;
	
		static public const START:String = "onStarted" ;
		
		static public const NET_STATUS:String = "onStatus" ;

		static public const TIMEOUT:String = "onTimeOut" ;

		// ----o Public Methods

		override public function clone():Event
		{
			var e:NetServerEvent = new NetServerEvent( type , getConnection(), getStatus(), getInfo()) ;
			e.setInfo (e.getInfo()) ;
			e.setStatus(e.getStatus()) ;
			return e ;
		}

		public function getConnection():NetServerConnection
		{
			return _connection ;
		}

		public function getInfo():NetServerInfo 
		{
			return _info ;	
		}
	
		public function getStatus():NetServerStatus 
		{
			return _status ;	
		}

		public function setConnection(connection:NetServerConnection):void
		{
			_connection = connection ;
		}

		public function setInfo( oInfo:* ):void 
		{
			if (oInfo is NetServerInfo) 
			{
				_info = oInfo ;
			} 
			else if (typeof(oInfo) == "object") 
			{
				_info = new NetServerInfo(oInfo) ;	
			} 	
			else
			{
				_info = null ;
			}
		}
	
		public function setStatus(status:NetServerStatus):void 
		{
			_status = NetServerStatus.validate(status) ? status : null ;
		}
		
		public function toSource():String
		{
			return "new NetServerEvent()" ; 
		}

		// ----o Private Properties
	
		private var _connection:NetServerConnection ;
		private var _status:NetServerStatus ;
		private var _info:NetServerInfo ;

	}
}