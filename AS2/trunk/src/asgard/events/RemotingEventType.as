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

/* ------- 	RemotingEventType

	AUTHOR

		Name : RemotingEventType
		Package : asgard.remoting
		Version : 1.0.0.0
		Date :  2005-12-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTANT SUMMARY
		
		- RemotingEventType.ERROR:String 
		
			"onError"

		- RemotingEventType.FAULT:String
		
			"onFault"
		
		- RemotingEventType.FINISHED:String
		
			"onFinished"
		
		- RemotingEventType.PROGRESS:String
		
			"onProgress"

		- RemotingEventType.RESULT:String
		
			"onResult"
	
		- RemotingEventType.STARTED:String
		
			"onStarted"

----------  */

import asgard.events.ActionEventType;

class asgard.events.RemotingEventType {

	// ----o Constructor
	
	private function RemotingEventType() {
		//
	}

	// ----o Constants
	
	static public var ERROR:String = "onError" ;	
	static public var FAULT:String = "onFault" ;
	static public var FINISHED:String = ActionEventType.FINISH ;
	static public var PROGRESS:String = ActionEventType.PROGRESS ;
	static public var RESULT:String = "onResult" ;
	static public var STARTED:String = ActionEventType.START ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(RemotingEventType, null , 7, 7) ;
	
}
