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
 * Provides a logger target that uses the global trace() method to output log messages.
 * <code>
 * Log = vegas.logging.Log ;
 * LogEventLevel = vegas.logging.LogEventLevel ;
 *       
 * TraceTarget = vegas.logging.targets.TraceTarget ;
 *       
 * // setup writer 
 * var traceTarget = new TraceTarget() ;
 * traceTarget.filters = ["vegas.logging.*", "vegas.errors.*"] ;
 * 
 * traceTarget.includeDate = true ;
 * traceTarget.includeTime = true ;
 * traceTarget.includeMilliseconds = true ;
 * traceTarget.includeLevel = true ;
 * traceTarget.includeCategory = true ;
 * traceTarget.includeLines = true ;
 * 
 * traceTarget.level = LogEventLevel.ALL ; 
 *       
 * // start writing log data 
 * Log.addTarget( traceTarget ) ; 
 *       
 * // get a logger for the 'myDebug' category 
 * // and send some data to it.
 *       
 * var logger = Log.getLogger("vegas.logging.targets") ;
 * logger.log(LogEventLevel.DEBUG, "here is some myDebug info : {0} and {1}", 2.25 , true) ; 
 * 
 * logger.debug( "here is some myDebug info : {0} and {1}", 2.25 , true ) ;
 * logger.info ( "here is some myDebug info : {0} and {1}", 2.25 , true ) ;
 * logger.warn ( "here is some myDebug info : {0} and {1}", 2.25 , true ) ;
 * logger.error( "here is some myDebug info : {0} and {1}", 2.25 , true ) ;
 * logger.fatal( "here is some myDebug info : {0} and {1}", 2.25 , true ) ;
 * 
 * traceTarget.includeDate = false ;
 * traceTarget.includeTime = false ;
 * traceTarget.includeCategory = false ;
 * logger.log(LogEventLevel.DEBUG, [2, 3, 4]) ; 
 * 
 * try
 * {
 *     throw new vegas.errors.FatalError("A fatal error") ;
 * }
 * catch(e)
 * {
 *     e.toString() ;
 * }
 * </code>
 * @author eKameleon
 * @version 1.0.0.0
 */
if (vegas.logging.targets.TraceTarget == undefined) {


	/**
	 * @requires vegas.logging.targets.LineFormattedTarget
	 */
	require("vegas.logging.targets.LineFormattedTarget") ;
	
	/**
	 * @requires vegas.logging.LogEvent
	 */
	require("vegas.logging.LogEvent") ;

	/**
	 * Creates a new TraceTarget instance.
	 */
	vegas.logging.targets.TraceTarget = function () 
	{ 
		vegas.logging.AbstractTarget.call(this) ; // super
	}

	/** 
	 * @extends vegas.logging.targets.LineFormattedTarget
	 */
	proto = vegas.logging.targets.TraceTarget.extend(vegas.logging.targets.LineFormattedTarget) ;
	
	/**
     * Descendants of this class should override this method to direct the specified message to the desired output.
     * @param message String containing preprocessed log message which may include time, date, category, etc. based on property settings, such as <code>includeDate</code>, <code>includeCategory</code>, etc.
     * @param level the LogEventLevel of the message.
	 */
	proto.internalLog = function( message , level /*Number*/ ) /*Void*/
	{
    	trace( message ) 
	}
	
	delete proto ;
	
}