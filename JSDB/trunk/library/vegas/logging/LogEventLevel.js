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
 * Static enumeration containing constants for use in the level property.
 * @author eKameleon
 */
if (vegas.logging.LogEventLevel == undefined) 
{
	
	/**
	 * Creates the LogEventLevel singleton.
	 */
	vegas.logging.LogEventLevel = {} ;
	
	/**
	 * Intended to force a target to process all messages (0).
	 */
	vegas.logging.LogEventLevel.ALL = 0 ;

	/**
	 * Designates informational level messages that are fine grained and most helpful when debugging an application (2).
	 */
	vegas.logging.LogEventLevel.DEBUG = 2 ;

	/**
	 * Designates error events that might still allow the application to continue running (8).
	 */	
	vegas.logging.LogEventLevel.ERROR = 8 ;

	/**
	 * Designates events that are very harmful and will eventually lead to application failure (1000).
	 */
	vegas.logging.LogEventLevel.FATAL = 1000 ;

	/**
	 * Designates informational messages that highlight the progress of the application at coarse-grained level (4).
	 */
	vegas.logging.LogEventLevel.INFO = 4 ;

	/**
	 * Designates events that could be harmful to the application operation (6).
	 */	
	vegas.logging.LogEventLevel.WARN = 6 ;

	/**
	 * Returns {@code true} if the number level passed in argument is valid.
	 * @return {@code true} if the number level passed in argument is valid.
	 */
	vegas.logging.LogEventLevel.isValidLevel = function ( level /*Number*/ ) /*Boolean*/ 
	{
		if (level instanceof Number || typeof(level) == "number") 
		{
			var LogEventLevel = vegas.logging.LogEventLevel ;	
			var levels /*Array*/ = 
			[
				LogEventLevel.ALL   , LogEventLevel.DEBUG , LogEventLevel.ERROR , 
				LogEventLevel.FATAL , LogEventLevel.INFO  , LogEventLevel.WARN
			] ;
			return levels.contains( level.valueOf() ) ;
		}		
	}

}
