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

/** LogEvent

	AUTHOR
	
		Name : LogEvent
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2005-12-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Dynamic class.

	CONSTANT SUMMARY

		- LOG:String

	PROPERTY SUMMARY

		- bubbles:Boolean [R/W]
		
		- context [R/W]
		
		- currentTarget [R/W]
		
		- eventPhase:Number [R/W]
		
		- level:Number
			
			Provides access to the level for this log event.
		
		- message:String
		
			Provides access to the message that was logged.
		
		- target [R/W]
		
		- type:String [R/W]

	METHOD SUMMARY
	
		- cancel():Void
		
		- clone()
		
		- getBubbles():Boolean
		
		- getContext()
		
		- getCurrentTarget()
		
		- getEventPhase():Number
		
		- static getLevelString(value:Number):String 
		
			Returns a string value representing the level specified.
			
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
		
		- setTarget(target):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation()
		
		- toString():String

	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → LogEvent

	IMPLEMENTS
	
		ICloneable, Event, IFormattable

**/	

import vegas.events.DynamicEvent;
import vegas.logging.LogEventLevel;

dynamic class vegas.logging.LogEvent extends DynamicEvent {
	
	// ----o Constructor
	
	public function LogEvent(msg:String, lv:Number) {
		super(LogEvent.LOG) ;
		message = msg || "" ;
		level = lv || LogEventLevel.ALL ;
	}

	// ----o Constant
	
	static public var LOG:String = "log" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(LogEvent, ["LOG"] , 7, 7) ;
	
	// ----o Public Properties
	
	public var level:Number ;
	
	public var message:String ;
	
	// ----o Public Methods
	
	/*override*/ public function clone() {
		return new LogEvent(message, level) ;
	}
	
	static public function getLevelString(value:Number):String {
		
		switch (value) {
			
			case LogEventLevel.ALL : 
				return LogEventLevel.ALL.toString() ;
			
			case LogEventLevel.DEBUG :
				return LogEventLevel.DEBUG.toString() ;
			
			case LogEventLevel.ERROR :
				return LogEventLevel.ERROR.toString() ;

			case LogEventLevel.FATAL :
				return LogEventLevel.FATAL.toString() ;
		
			case LogEventLevel.INFO :
				return LogEventLevel.INFO.toString() ;
			
			case LogEventLevel.WARN :
				return LogEventLevel.WARN.toString() ;
		
			default :
				return null ;
		}
	}
	
}