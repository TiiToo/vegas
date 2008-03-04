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
 * The logger that is used within the logging framework. This class dispatches events for each message logged using the log() method.
 * @author eKameleon
 */
if (vegas.logging.LogLogger == undefined) 
{

	/**
	 * @requires vegas.logging.ILogger
	 */	
	require("vegas.logging.ILogger") ;

	/**
	 * Creates a new LogLogger instance.
	 */
	vegas.logging.LogLogger = function ( category /*String*/ ) 
	{ 
		
		vegas.logging.ILogger.apply(this) ;
		
		this.category = category || vegas.logging.LogLogger.DEFAULT_CATEGORY ;
		
	}
	
	/**
	 * @extends vegas.logging.ILogger
	 */
	vegas.logging.LogLogger.extend(vegas.logging.ILogger) ;

	vegas.logging.LogLogger.DEFAULT_CATEGORY  = "" ;

	/**
	 * The category this logger send messages for.
	 */	
	vegas.logging.LogLogger.prototype.category /*String*/ = null ;

	/**
	 * This logger is dispatching in a queue if no targets are register.
	 */
	vegas.logging.LogLogger.prototype.isQueue /*Boolean*/ = null ;

	/**
	 * Logs the specified data using the LogEventLevel.DEBUG level.
	 * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
 	 * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
	 */
	vegas.logging.LogLogger.prototype.debug = function (context) /*Void*/ 
	{
		this.log.apply(this, [vegas.logging.LogEventLevel.DEBUG].concat(Array.fromArguments(arguments)) ) ;
	}

	/**
	 * Logs the specified data using the LogEventLevel.ERROR level.
	 * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
 	 * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
	 */
	vegas.logging.LogLogger.prototype.error = function (context) /*Void*/ 
	{
		this.log.apply(this, [vegas.logging.LogEventLevel.ERROR].concat(Array.fromArguments(arguments)) ) ;
	}

	/**
	 * Logs the specified data using the LogEventLevel.FATAL level.
	 * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
 	 * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.	 
 	 */
	vegas.logging.LogLogger.prototype.fatal = function (context) /*Void*/ 
	{
		this.log.apply(this, [vegas.logging.LogEventLevel.FATAL].concat(Array.fromArguments(arguments)) ) ;
	}
	
	/**
	 * Logs the specified data using the LogEvent.INFO level.
 	 * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
 	 * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
	 */
	vegas.logging.LogLogger.prototype.info = function (context) /*Void*/ 
	{
		this.log.apply(this, [vegas.logging.LogEventLevel.INFO].concat(Array.fromArguments(arguments)) ) ;
	}

	/**
	 * Logs the specified data at the given level.
 	 * @param level The level this information should be logged at. Valid values are:<p>
	 * <li>LogEventLevel.FATAL designates events that are very harmful and will eventually lead to application failure</li>
	 * <li>LogEventLevel.ERROR designates error events that might still allow the application to continue running.</li>
	 * <li>LogEventLevel.WARN designates events that could be harmful to the application operation</li>
	 * <li>LogEventLevel.INFO designates informational messages that highlight the progress of the application at coarse-grained level.</li>
	 * <li>LogEventLevel.DEBUG designates informational level messages that are fine grained and most helpful when debugging an application.</li>
	 * <li>LogEventLevel.ALL intended to force a target to process all messages.</li></p>
	 * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
  	 * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
 	 */
	vegas.logging.LogLogger.prototype.log = function ( level /*Number*/, context) /*Void*/ 
	{
		
		var message /*String*/ ;
		var args /*Array*/ = Array.fromArguments(arguments) ;
		if (vegas.util.TypeUtil.typesMatch(context, String) && arguments.length > 2) {
			message = this._format(context.toString(), args.splice(2));
		} else {
			message = context ;
		}
		var e /*LogEvent*/ = new vegas.logging.LogEvent(message, level) ;
		e.setTarget(this) ;
		e.setContext(context) ;
		this.dispatchEvent(e, this.isQueue) ;
		
	}

	/**
	 * Logs the specified data using the LogEventLevel.WARN level.
 	 * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
 	 * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
	 */
	vegas.logging.LogLogger.prototype.warn = function (context) /*void*/ 
	{
		this.log.apply(this, [vegas.logging.LogEventLevel.WARN].concat(Array.fromArguments(arguments)) ) ;
	}

	/**
	 * Format the message with StringFormatter tool.
	 * @see StringFormatter
	 */
	vegas.logging.LogLogger.prototype._format = function (msg /*String*/, args/*Array*/) /*String*/ 
	{
		return String.format.apply(null, [msg].concat(args)) ; // Core2 !
	}

}