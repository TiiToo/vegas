﻿/*

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

import vegas.events.DynamicEvent;
import vegas.logging.LogEventLevel;
import vegas.util.serialize.Serializer;

/**
 * Represents the log information for a single logging event. The loging system dispatches a single event each time a process requests information be logged. This event can be captured by any object for storage or formatting.
 * @author eKameleon 
 */
dynamic class vegas.logging.LogEvent extends DynamicEvent 
{
	
	/**
	 * Creates a new LogEvent.
	 */
	public function LogEvent(msg:String, lv:Number, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		super(LogEvent.LOG, target, context, bubbles, eventPhase, time, stop) ;
		message = msg || "" ;
		level = lv || LogEventLevel.ALL ;
	}

	/**
	 * Event type constant, identifies a logging event.
	 */
	static public var LOG:String = "log" ;
	
	/**
	 * Provides access to the level for this log event.
	 */
	public var level:Number ;
	
	/**
	 * Provides access to the message that was logged.
	 */
	public var message:String ;
	
	/**
	 * Returns the shallow copy of the event.
	 * @return the shallow copy of the LogEvent event.
	 */
	/*override*/ public function clone() 
	{
		return new LogEvent(message, level) ;
	}
	
	/**
	 * Returns a string value representing the level specified.
	 */
	static public function getLevelString(value:Number):String 
	{
		
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

	/**
	 * Internal methods used by toSource method.
	 */
	/*protected*/ private function _getParams():Array 
	{
		var ar1:Array = 
		[
			Serializer.toSource(message) ,
			Serializer.toSource(level)
		] ;
		var ar2:Array = super._getParams() ;
		return ar1.concat( ar2 ) ;
	}

}