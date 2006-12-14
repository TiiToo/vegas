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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** NetServerEventType

	AUTHOR

		Name : NetServerEventType
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2005-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTANT SUMMARY

		- ACCEPT:NetServerEventType

		- CLOSE:NetServerEventType
		
		- FINISH:NetServerEventType
		
		- START:NetServerEventType
		
		- TIMEOUT:NetServerEventType
**/

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.events.NetServerEventType extends String {

	// ----o Constructor
	
	private function NetServerEventType(s:String) {
		super(s) ;
	}

	// ----o Static Properties
	
	static public var ACCEPTED:NetServerEventType = new NetServerEventType("onAccepted") ;
	
	static public var CLOSE:NetServerEventType = new NetServerEventType("onClosed") ;
	
	static public var FINISH:NetServerEventType = new NetServerEventType("onFinished") ;
	
	static public var START:NetServerEventType = new NetServerEventType("onStarted") ;

	static public var NET_STATUS:NetServerEventType = new NetServerEventType("onStatus") ;

	static public var TIMEOUT:NetServerEventType = new NetServerEventType("onTimeOut") ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(NetServerEventType, null , 7, 7) ;
	
}
