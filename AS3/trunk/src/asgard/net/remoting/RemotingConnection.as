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

package asgard.net.remoting
{

	import asgard.events.NetServerEvent ;	
	import asgard.net.NetServerConnection;

	public class RemotingConnection extends NetServerConnection
	{
		
		/**
		 * Creates a new RemotingConnection instance.
		 */
		public function RemotingConnection( sURL:String=null )
		{
			
			super() ;
			
			if (sURL != null)
			{
				this.connect( sURL );
			} 
			
		}

		static public const AMF_SERVER_DEBUG:String = "amf_server_debug" ;

		static public const CREDENTIALS:String = "Credentials" ;
	
		override public function clone():* 
		{
			return new RemotingConnection( uri ) ;	
		}

		static public function getConnection( sUrl:String ):RemotingConnection 
		{
			if ( ! RemotingConnectionCollector.contains(sUrl) ) 
			{
				RemotingConnectionCollector.insert(sUrl, new RemotingConnection( sUrl ));
			}
			return RemotingConnectionCollector.get(sUrl) ;
		}

		public function setCredentials( authentification:RemotingAuthentification=null ):void  
		{
			addHeader( RemotingConnection.CREDENTIALS , false, authentification.toObject());
		}
	
		public function startDebug():void
		{
			var oDebug:Object = 
			{
				amf:false, 
				error:true,
				trace:true,
				coldfusion:false, 
				m_debug:true,
				httpheaders:false, 
				amfheaders:false, 
				recordset:true
			} ;
			addHeader( RemotingConnection.AMF_SERVER_DEBUG, true, oDebug) ;
		}
	
		public function stopDebug():void
		{
			addHeader( RemotingConnection.AMF_SERVER_DEBUG, true, undefined) ;
		}
		
	}
	
}