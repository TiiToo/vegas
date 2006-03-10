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

/* -------- LogEventLevel

	AUTHOR
	
		Name : LogEventLevel
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2005-12-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- ALL
		
			intended to force a target to process all messages.
		
		- DEBUG
		
			designates informational level messages that are fine grained and most helpful when debugging an application.
		
		- ERROR
		
			designates error events that might still allow the application to continue running.
		
		- FATAL
		
			designates events that are very harmful and will eventually lead to application failure
		
		- INFO
		
			designates informational messages that highlight the progress of the application at coarse-grained level.
		
		- WARN
			
			designates events that could be harmful to the application operation	

	METHOD SUMMARY
	
		- static isValidLevel(level:Number):Boolean
		
		- toString():String
		
		- valueOf()

	INHERIT
	
		Int > LogEventLevel
	
	IMPLEMENTS
	
		IFormattable

----------  */	

import vegas.core.types.Int;

class vegas.logging.LogEventLevel extends Int {
	
	// ----o Constructor 
	
	public function LogEventLevel(name:String, value:Number) {
		super(value) ;
		_name = name ;
	}

	// ----o Constant

	static public var ALL:LogEventLevel = new LogEventLevel("ALL", 1000) ;
	
	static public var DEBUG:LogEventLevel = new LogEventLevel("DEBUG", 8) ;
	
	static public var ERROR:LogEventLevel = new LogEventLevel("ERROR", 2) ;
	
	static public var FATAL:LogEventLevel = new LogEventLevel("FATAL", 6) ;

	static public var INFO:LogEventLevel = new LogEventLevel("INFO", 0) ;	
	
	static public var WARN:LogEventLevel = new LogEventLevel("WARN", 4) ; ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(LogEventLevel, null , 7, 7) ;
	
	// ----o Public Methods

	static public function isValidLevel(level:Number):Boolean {
		var levels:Array = [ALL, DEBUG, ERROR, FATAL, INFO, WARN] ;
		var l:Number = levels.length ;
		while (--l > -1) if (level == levels[l]) return true ;
		return false ;
	}
		
	/*override*/ public function toString():String { 
		return _name ; 
	}

	// ----o Private Properties
	
	private var _name:String ;

	
}