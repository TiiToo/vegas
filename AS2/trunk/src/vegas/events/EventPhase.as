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

/* ------- EventPhase

	AUTHOR

		Name : EventPhase
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-01-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		AS3 API flash.events.EventPhase compatibility
	
	CONSTRUCTOR
	
		private
	
	CONSTANT

		static const AT_TARGET:Number
			
			The target phase(2).
			
		static const BUBBLING_PHASE:Number
			
			The bubbling phase(3).
			
		static const CAPTURING_PHASE:Number
			
			The capturing phase(1).
		
		static const NONE:Number
			
			The default phase(0)
		
		static const STOP:Number
		
			Stop the phase(4). Use only by the Event and EventDispatcher class.
		
		static const STOP_IMMEDIATE:Number
		
			Stop the phase immediately (4). Use only by the Event and EventDispatcher class.
	
----------  */

class vegas.events.EventPhase {

	// ----o Constructor
	
	private function EventPhase() {
		//
	}

	// ----o Static Properties
	
	static public var AT_TARGET:Number = 2 ;
	static public var BUBBLING_PHASE:Number = 3 ;
	static public var CAPTURING_PHASE:Number = 1 ;
	static public var NONE:Number = 0 ;
	static public var STOP:Number = 8 ;
	static public var STOP_IMMEDIATE:Number = 10 ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(EventPhase, null , 7, 7) ;
	
}

