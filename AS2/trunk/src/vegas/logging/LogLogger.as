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

/* -------- LogLogger

	AUTHOR
	
		Name : LogLogger
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2005-12-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- isQueue:Boolean

	METHOD SUMMARY
	
		- debug(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.DEBUG level.
		
		- error(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.ERROR level.
		
		- fatal(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.FATAL level.
		
		- info(context, ...rest):Void
		
			Logs the specified data using the LogEvent.INFO level.
		
		- log(level:Number, context ...rest):Void
		
			Logs the specified data at the given level.
		
		- warn(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.WARN level.

	INHERIT
	
		EventDispatcher

	IMPLEMENTS
	
		 IEventDispatcher, ILogger, IFormattable

	CHANGE : [2006-01-20 message:String -> o

----------  */	

import vegas.events.EventDispatcher;
import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.logging.LogEvent;
import vegas.logging.LogEventLevel;
import vegas.string.StringFormatter;
import vegas.util.TypeUtil;

class vegas.logging.LogLogger extends EventDispatcher implements ILogger {

	// ----o Constructor
	
	public function LogLogger(category:String) {
		this.category = category || Log.DEFAULT_CATEGORY ;
	}

	// ----o Public Methods
	
	public var category:String ;
	public var isQueue:Boolean ;
	
	// ----o Public Methods
	
	public function debug(context):Void {
		log.apply(this, [LogEventLevel.DEBUG].concat(arguments)) ;
	}
	
	public function error(context):Void {
		log.apply(this, [LogEventLevel.ERROR].concat(arguments)) ;
	}
	
	public function fatal(context):Void {
		log.apply(this, [LogEventLevel.FATAL].concat(arguments)) ;
	}
	
	public function info(context):Void {
		log.apply(this, [LogEventLevel.INFO].concat(arguments)) ;
	}
	
	public function log(level:Number, context):Void {
		var message:String ;
		if (TypeUtil.typesMatch(context, String) && arguments.length > 2) {
			message = _format(context.toString(), arguments.splice(2));
		} else {
			message = context.toString() ;
		}
		var ev:LogEvent = new LogEvent(message, level) ;
		ev.context = context ;
		this.dispatchEvent(ev, isQueue) ;
	}
	
	public function warn(context):Void {
		log.apply(this, [LogEventLevel.WARN].concat(arguments)) ;
	}
	
	public function toString():String {
		return "[LogLogger]" ;
	}
	
	// ----o Private Methods
	
	private function _format(msg:String, args:Array):String {
		var f:StringFormatter = new StringFormatter(msg) ;
		return f.format.apply(f, args) ;
	}
	

	
}