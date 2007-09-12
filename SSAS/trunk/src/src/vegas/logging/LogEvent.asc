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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Represents the log information for a single logging event. 
 * The loging system dispatches a single event each time a process requests information be logged. 
 * This event can be captured by any object for storage or formatting.
 * @author eKameleon 
 */
if (vegas.logging.LogEvent == undefined) 
{

	/**
	 * @requires vegas.events.DynamicEvent
	 */	
	require("vegas.events.DynamicEvent") ;
	
	/**
	 * @requires vegas.logging.LogEventLevel
	 */
	require("vegas.logging.LogEventLevel") ;
	
	/**
	 * Creates a new LogEvent.
	 */
	vegas.logging.LogEvent = function( message , level /*Number*/ ) 
	{
		vegas.events.DynamicEvent.call(this, vegas.logging.LogEvent.LOG) ;
		this.level = ( isNaN(level) && level >= 0 ) ? vegas.logging.LogEventLevel.ALL : level ;
		this.message = message || "" ;
	}
	
	/**
	 * @extends vegas.events.DynamicEvent
	 */ 
	vegas.logging.LogEvent.extend( vegas.events.DynamicEvent ) ;

	/**
	 * Event type constant, identifies a logging event.
	 */
	vegas.logging.LogEvent.LOG /*String*/ = "log" ;

	/**
	 * Provides access to the level for this log event.
	 */
	vegas.logging.LogEvent.prototype.level /*String*/ = null ;

	/**
	 * Provides access to the message that was logged.
	 */
	vegas.logging.LogEvent.prototype.message = null ;
 
 	/**
	 * Returns the shallow copy of the event.
	 * @return the shallow copy of the LogEvent event.
	 */
	vegas.logging.LogEvent.prototype.clone = function () 
	{
		return new vegas.logging.LogEvent(this.message, this.level) ;
	}

	/**
	 * Returns a string value representing the level specified.
	 * @return a string value representing the level specified.
	 */	
	vegas.logging.LogEvent.getLevelString = function (value /*Number*/) /*String*/ 
	{
		
		LogEventLevel = vegas.logging.LogEventLevel ;
		
		switch (value) 
		{
			
			case LogEventLevel.ALL :
			{ 
				return "ALL" ;
			}
			case LogEventLevel.DEBUG :
			{
				return "DEBUG" ;
			}
			case LogEventLevel.ERROR :
			{
				return "ERROR" ;
			}
			case LogEventLevel.FATAL :
			{
				return "FATAL" ;
			}
			case LogEventLevel.INFO :
			{
				return "INFO" ;
			}
			case LogEventLevel.WARN :
			{
				return "WARN" ;
			}
			default :
			{			
				return "UNKNOWN" ;
			}
		}
	}

}
