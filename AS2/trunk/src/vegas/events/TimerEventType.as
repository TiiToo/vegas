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

/**	TimerEventType

	AUTHOR

		Name : TimerEventType
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		- RESTART:String
			
			"restart"
		
		- START:String
		
			"start"
		
		- STOP:String
		
			"stop"
		
		- TIMER:String
		
			"timer"

**/

class vegas.events.TimerEventType {

	// ----o Constructor
	
	private function TimerEventType() {
		//
	}

	// ----o Static Properties

	static public var RESTART:String = "restart" ;
	static public var START:String = "start" ;
	static public var STOP:String = "stop" ;
	static public var TIMER:String = "timer" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(TimerEventType, null , 7, 7) ;
	
}
