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

import vegas.logging.LogEvent;
import vegas.logging.targets.LineFormattedTarget;

/**
 * Provides a logger target that uses the global trace() method to output log messages.
 * @author eKameleon
 */
class vegas.logging.targets.TraceTarget extends LineFormattedTarget 
{
	
	/**
	 * Creates a new TraceTarget instance.
	 */
	public function TraceTarget() 
	{
		//
	}
	
	/**
	 * Returns the string representation with format of the log event.
	 */
	public function formatLogEvent(ev:LogEvent):String 
	{
		return _formatMessage(ev.message, ev.level.toString(), ev.getTarget().category, new Date(ev.getTimeStamp())) ;
	}
	
	/**
	 * This method handles a LogEvent from an associated logger.
	 */
	/*override*/ public function logEvent(e:LogEvent) 
	{
		trace ( formatLogEvent(e) ) ;
	}
	
	/**
	 * The current line number.
	 */
	private var __lineNumber:Number = 1 ;
	
	/**
	 * This method format the passed Date in arguments.
	 */
	private function _formatDate(d:Date):String 
	{
		var date:String = "" ;
		date += _getDigit(d.getDate()) ;
		date += "/" + _getDigit(d.getMonth() + 1) ;
		date += "/" + d.getFullYear();
		return date ;
	}

	/**
	 * This method format the passed level in arguments.
	 */
	private function _formatLevel(level:String):String 
	{
		return '[' + level + ']' ;
	}	

	/**
	 * This method format the current line value.
	 */
	private function _formatLines():String 
	{
		return "[" + __lineNumber++ + "]" ; 
	}	
	
	/**
	 * This method format the log message.
	 */
	private function _formatMessage(message:String, level:String, category:String, date:Date):String 
	{
		var msg:String = "" ;
		var d:Date = date || new Date ;
		if (includeLines) msg += _formatLines() + " " ; // lines
		if (includeDate) msg += _formatDate(d) + " " ; // date
		if (includeTime) msg += _formatTime(d) + " " ; // time
		if (includeLevel) msg += _formatLevel(level || "" ) + " " ; // level
		if (includeCategory) msg += (category || "") + " " ; // category
		msg += message ;
		return msg ;
	}
	
	/**
	 * This method format the current Date passed in argument.
	 */
	private function _formatTime(d:Date):String 
	{
		var time:String = "" ;
		time += _getDigit(d.getHours()) ;
		time += ":" + _getDigit(d.getMinutes()) ;
		time += ":" + _getDigit(d.getSeconds()) ;
		return time ;
	}
	
	/**
	 * Returns the string representation of a number and use digit conversion.
	 */
	private function _getDigit(n:Number):String 
	{
		if (isNaN(n)) return "00" ;
		return ((n < 10) ? "0" : "") + n ;
	}
	
}