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

/** TraceTarget

	AUTHOR
	
		Name : TraceTarget
		Package : vegas.logging.targets
		Version : 1.0.0.0
		Date :  2005-12-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
		
		- includeCategory:Boolean
		
			Indicates if the category for this target should added to the trace.
		
		- includeDate:Boolean
		
			Indicates if the date should be added to the trace.
		
		- includeLevel:Boolean
		
			Indicates if the level for the event should added to the trace.
		
		- includeLines:Boolean
		
			Indicates if a line number should be added to the trace.
		
		- includeTime:Boolean
		
			Indicates if the time should be added to the trace.

	METHOD SUMMARY
	
		- formatLogEvent(ev:LogEvent):String
	
		- handleEvent(event:LogEvent) : Void
		
			This method handles a LogEvent from an associated logger.
	
	INHERIT 
	
		CoreObject → AbstractTarget → LineFormattedTarget → TraceTarget

	IMPLEMENTS
	
		EventListener, ITarget, IFormattable, IHashable

**/	

import vegas.logging.LogEvent;
import vegas.logging.targets.LineFormattedTarget;

class vegas.logging.targets.TraceTarget extends LineFormattedTarget {
	
	// ----o Constructor
	
	public function TraceTarget() {
		//
	}
	
	// ----o Public Methods

	public function formatLogEvent(ev:LogEvent):String {
		return _formatMessage(ev.message, ev.level.toString(), ev.getTarget().category, new Date(ev.getTimeStamp())) ;
	}
	
	/*override*/ public function logEvent(e:LogEvent) {
		var msg:String = formatLogEvent(e) ;
		trace (msg) ;
	}
	
	// ----o Private Properties
	
	static private var __lineNumber:Number = 1 ;
	
	// ----o Private Methods
	
	private function _formatDate(d:Date):String {
		var date:String = "" ;
		date += _getDigit(d.getDate()) ;
		date += "/" + _getDigit(d.getMonth() + 1) ;
		date += "/" + d.getFullYear();
		return date ;
	}
	
	private function _formatLevel(level:String):String {
		return '[' + level + ']' ;
	}	
	
	private function _formatLines():String {
		return "[" + __lineNumber++ + "]" ; 
	}	
	
	private function _formatMessage(message:String, level:String, category:String, date:Date):String {
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
	
	private function _formatTime(d:Date):String {
		var time:String = "" ;
		time += _getDigit(d.getHours()) ;
		time += ":" + _getDigit(d.getMinutes()) ;
		time += ":" + _getDigit(d.getSeconds()) ;
		return time ;
	}
	
	private function _getDigit(n:Number):String {
		if (isNaN(n)) return "00" ;
		return ((n < 10) ? "0" : "") + n ;
	}
	
}