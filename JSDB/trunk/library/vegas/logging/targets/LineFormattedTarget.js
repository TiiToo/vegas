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
 * All logger target implementations that have a formatted line style output should extend this class. It provides default behavior for including date, time, category, and level within the output.
 * @author eKameleon
 */
if (vegas.logging.targets.LineFormattedTarget == undefined) 
{

	/**
	 * Import
	 */
	require("vegas.logging.AbstractTarget") ;

	/**
	 * Creates a new LineFormattedTarget instance.
	 */
	vegas.logging.targets.LineFormattedTarget = function () 
	{ 
		vegas.logging.AbstractTarget.call(this) ;
	}

	/**
	 * @extends vegas.logging.AbstractTarget
	 */
	proto = vegas.logging.targets.LineFormattedTarget.extend(vegas.logging.AbstractTarget) ;
	
	/**
	 * Indicates if the category for this target should added to the trace.
	 */
	proto.includeCategory /*Boolean*/ = false ;

	/**
	 * Indicates if the date should be added to the trace.
	 */
	proto.includeDate /*Boolean*/ = false ;
	
	/**
	 * Indicates if the level for the event should added to the trace.
	 */
	proto.includeLevel /*Boolean*/ = false ;
	
	/**
	 * Indicates if a line number should be added to the trace.
	 */
	proto.includeLines /*Boolean*/ = false ; 

  	/**
	 * Indicates if the milliseconds should be added to the trace. Only relevant when includeTime is {@code true}.
     */
  	proto.includeMilliseconds /*Boolean*/ = false ;

	/**
	 * Indicates if the time should be added to the trace.
	 */
	proto.includeTime /*Boolean*/ = false ;

   	/**
     * The separator string.
     */
   	proto.separator /*String*/ = " " ;

	/**
     * Descendants of this class should override this method to direct the specified message to the desired output.
     * @param message String containing preprocessed log message which may include time, date, category, etc. based on property settings, such as <code>includeDate</code>, <code>includeCategory</code>, etc.
     * @param level the LogEventLevel of the message.
	 */
	proto.internalLog = function( message , level /*Number*/ ) /*Void*/
	{
    	// override this method.
	}

	/**
	 * This method handles a LogEvent from an associated logger.
	 */
	/*override*/ proto.logEvent = function (e /*LogEvent*/ ) /*void*/ 
	{
		var category /*String*/ = e.getTarget().category ;
		var level /*String*/ = vegas.logging.LogEvent.getLevelString( e.level ) ;
		var message /*String*/ = this._formatMessage( e.message, level, category, new Date() ) ;
		this.internalLog( message, e.level ) ;
	}

	/**
	 * The current line number.
	 */
	/*private*/ proto.__lineNumber /*Number*/ = 1 ;

	/**
	 * This method format the passed Date in arguments.
	 */
	/*private*/ proto._formatDate = function ( d /*Date*/) /*String*/ 
	{
		var sDate /*String*/ = "" ;
		sDate += this._getDigit( d.getDate() ) ;
		sDate += "/" + this._getDigit( d.getMonth() + 1) ;
		sDate += "/" + d.getFullYear() ;
		return sDate ;
	}

	/**
	 * This method format the passed level in arguments.
	 */
	/*private*/ proto._formatLevel = function (level/*String*/)/*String*/ 
	{
		return '[' + level + ']' ;
	}	

	/**
	 * This method format the current line value.
	 */
	/*private*/ proto._formatLines = function () /*String*/ 
	{
		return "[" + this.__lineNumber++ + "]" ; 
	}	
	
	/**
	 * This method format the log message.
	 */
	/*private*/ proto._formatMessage = function (message/*String*/, level/*String*/, category/*String*/, date/*Date*/)/*String*/ 
	{
		var msg /*String*/ = "" ;
		var d /*Date*/ = date || new Date() ;
		if (this.includeLines) 
		{
			msg += this._formatLines() + this.separator ; // lines
		}
		if (this.includeDate) 
		{
			msg += this._formatDate(d) + this.separator ; // date
		}
		if (this.includeTime) 
		{
			msg += this._formatTime(d) + this.separator ; // time
		}
		if (this.includeLevel) 
		{
			msg += this._formatLevel(level || "" ) + this.separator ; // level
		}
		if (this.includeCategory) 
		{
			msg += (category || "") + this.separator ; // category
		}
		msg += message ;
		return msg ;
	}

	/**
	 * This method format the current Date passed in argument.
	 */
	/*private*/ proto._formatTime = function (d /*Date*/ ) /*String*/ 
	{
		var sTime /*String*/ = "" ;
		sTime += this._getDigit(d.getHours()) ;
		sTime += ":" + this._getDigit(d.getMinutes()) ;
		sTime += ":" + this._getDigit(d.getSeconds()) ;
		if( this.includeMilliseconds ) 
		{
      		sTime += ":" + this._getDigit(d.getMilliseconds()) ;
    	}
		return sTime ;
	}

	/**
	 * Returns the string representation of a number and use digit conversion.
	 * @return the string representation of a number and use digit conversion.
	 */
	/*private*/ proto._getDigit = function ( n/*Number*/) /*String*/ 
	{
		if (isNaN(n)) return "00" ;
		return ((n < 10) ? "0" : "") + n ;
	}

	delete proto ;
}