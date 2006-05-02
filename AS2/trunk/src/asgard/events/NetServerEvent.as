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
	
	METHODS
	
		- clone():NetServerEvent

		- getInfo():NetServerStatus
		
		- setInfo(status:NetServerStatus):Void

**/

import asgard.net.NetServerConnection ;
import asgard.events.NetServerEventType;

import vegas.events.DynamicEvent;
import asgard.net.NetServerStatus;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.events.NetServerEvent extends DynamicEvent {

	// ----o Constructor
	
	public function NetServerEvent( type:NetServerEventType, connection:NetServerConnection ){
		super(type, connection) ;
	}
	
	// ----o Public Methods

	public function clone() {
		return new NetServerEvent(NetServerEventType(getType()), getTarget()) ;
	}

	public function getInfo():NetServerStatus {
		return _info ;	
	}
	
	public function setInfo(status:NetServerStatus):Void {
		_info = NetServerStatus.validate(status) ? status : null ;
	}
	
	// ----o Private Properties
	
	private var _info:NetServerStatus ;
		
}
