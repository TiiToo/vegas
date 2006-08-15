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


/** RemotingConnection

	AUTHOR

		Name : RemotingConnection
		Package : asgard.net.remoting
		Version : 1.0.0.0
		Date :  2006-05-26
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
	
		- static getConnection( sURL:String ):RemotingConnection
	
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
		
		- setCredentials( authentification:RemotingAuthentification ):Void
		
		- setDelay(n:Number, useSeconds:Boolean):Void
		
		- setLimitPolicy( policy:NetServerPolicy ):Void
		
		- setParent(parent:EventDispatcher):Void	INHERIT
	
		- startDebug():Void
		
		- stopDebug():Void
		
		- toString():String
	
	INHERIT
	
		NetConnection → NetServerConnection → RemotingConnection

	IMPLEMENTS
	
		Action, EventTarget, IEventDispatcher, IHashable, IFormattable

	SEE ALSO
	
		RemotingConnectionCollector

*/

import asgard.net.NetServerConnection;
import asgard.net.remoting.RemotingAuthentification;
import asgard.net.remoting.RemotingConnectionCollector;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.net.remoting.RemotingConnection extends NetServerConnection {
	
	// ----o Constructor
	
	function RemotingConnection( sURL:String ) {
		
		super() ;

		if (sURL) this.connect( sURL );
		
	}
	
	// ----o Constants
	
	static public var AMF_SERVER_DEBUG:String = "amf_server_debug" ;
	static public var CREDENTIALS:String = "Credentials" ;

	// ----o Public Methods

	public function clone() {
		return new RemotingConnection( uri ) ;	
	}

	static public function getConnection( sUrl:String ):RemotingConnection {
		if ( ! RemotingConnectionCollector.contains(sUrl) ) {
			RemotingConnectionCollector.insert(sUrl, new RemotingConnection( sUrl ));
		}
		return RemotingConnectionCollector.get(sUrl) ;
	}

	public function setCredentials( authentification:RemotingAuthentification ):Void  {
		var oInfo:Object = {
			userid : authentification.userID , 
			password: authentification.password 
		} ; 
		addHeader( RemotingConnection.CREDENTIALS , false, oInfo);
	}

	public function startDebug():Void {
		var oDebug:Object = {
			amf:false, 
			error:true,
			trace:true,
			coldfusion:false, 
			m_debug:true,
			httpheaders:false, 
			amfheaders:false, 
			recordset:true
		};
		addHeader( RemotingConnection.AMF_SERVER_DEBUG, true, oDebug) ;
	}
	
	public function stopDebug():Void {
		addHeader( RemotingConnection.AMF_SERVER_DEBUG, true, undefined) ;
	}
	
}