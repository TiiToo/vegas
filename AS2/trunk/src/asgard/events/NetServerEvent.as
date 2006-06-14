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

/**	NetServerEvent

	AUTHOR

		Name : NetServerEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2005-04-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	PROPERTY SUMMARY

		- bubbles:Boolean [R/W]
		
		- context [R/W]
		
		- currentTarget [R/W]
		
		- eventPhase:Number [R/W]
		
		- target [R/W]
		
		- type:String [R/W]

	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext()
		
		- getCurrentTarget()
		
		- getError()
		
		- getEventPhase():Number
		
		- getInfo():NetServerStatus
				
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setError(oError):Void
		
		- setInfo(status:NetServerStatus):Void
		
		- setTarget(target):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation()
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String

	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent

	IMPLEMENTS 
		
		Event, ICloneable, IFormattable, IHashable, ISerializable

	EVENT SUMMARY

		- NetServerEventType.ACCEPT:NetServerEventType

		- NetServerEventType.CLOSE:NetServerEventType
		
		- NetServerEventType.FINISH:NetServerEventType
		
		- NetServerEventType.START:NetServerEventType
		
		- NetServerEventType.TIMEOUT:NetServerEventType

	SEE ALSO
		
		NetServerEventType

**/

import asgard.events.NetServerEventType;
import asgard.net.NetServerConnection;
import asgard.net.NetServerInfo;
import asgard.net.NetServerStatus;

import vegas.events.DynamicEvent;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.events.NetServerEvent extends DynamicEvent {

	// ----o Constructor
	
	public function NetServerEvent( type:NetServerEventType, connection:NetServerConnection, status:NetServerStatus, info, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number ){
		super(type, connection, context, bubbles, eventPhase, time, stop) ;
		setInfo(info) ;
		setStatus(status) ;
	}
	
	// ----o Public Methods

	public function clone() 
		{
		var e = new NetServerEvent(NetServerEventType(getType()), getTarget()) ;
		e.setInfo (e.getInfo()) ;
		e.setStatus(e.getStatus()) ;
		return e ;
		}

	public function getInfo():NetServerInfo 
		{
		return _info ;	
		}
	
	public function getStatus():NetServerStatus 
		{
		return _status ;	
		}

	public function setInfo( oInfo ):Void 
		{
		if (oInfo instanceof NetServerInfo) 
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
	
	public function setStatus(status:NetServerStatus):Void 
		{
		_status = NetServerStatus.validate(status) ? status : null ;
		}
	
	// ----o Private Properties
	
	private var _status:NetServerStatus ;
	private var _info:NetServerInfo ;

	// ----o Protected Methods
	
	/*protected*/ private function _getParams():Array 
		{
		var ar:Array = super._getParams() ;
		ar.splice(2, null, getStatus().toSource()) ;
		ar.splice(3, null, getInfo().toSource()) ;
		return ar ;
		}

}
