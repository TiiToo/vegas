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

/* -------- SOSTarget

	AUTHOR
	
		Name : SOSTarget
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2006-01-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static clear():Void
		
			clear SOS Console.
		
		- static exit():Void
		
			close SOS Console.
		
		- static getIncludeCategory():Boolean
		
		- static getIncludeDate():Boolean
		
		- static getIncludeLevel():Boolean
		
		- static getIncludeLines():Boolean
		
		- static getIncludeTime():Boolean
		
		- static initialize(namespace, color:Number, includes:Boolean)
		
		- static release():Void
		
		- static setIncludeCategory(b:Boolean):Void
		
		- static setIncludeDate(b:Boolean):Void
		
		- static setIncludeLevel(b:Boolean):Void
		
		- static setIncludeLines(b:Boolean):Void
		
		- setIncludes(lines:Boolean, level:Boolean, time:Boolean, date:Boolean, category:Boolean):Void
		
		- static setIncludeTime(b:Boolean):Void	
		
		- static trace(o, ..rest):Void
		
		- static traceReplacer(o):Void [MTASC]
	
----------  */	

import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.logging.LogEventLevel;
import vegas.logging.targets.SOSTarget;

class vegas.logging.SOSTracer {

	// ----o Constructor
	
	private function SOSTracer() {
		//
	}

	// ----o Public Properties
	
	static public var category:String ;

	// ----o Public Method
	
	static public function clear():Void {
		_instance.clear() ;
	}
	
	static public function exit():Void {
		_instance.exit() ;
	}

	static public function getIncludeCategory():Boolean {
		return _instance.includeCategory ;
	}

	static public function getIncludeDate():Boolean {
		return _instance.includeDate ;
	}
	
	static public function getIncludeLevel():Boolean {
		return _instance.includeLines ;
	}
	
	static public function getIncludeLines():Boolean {
		return _instance.includeLines ;
	}

	static public function getIncludeTime():Boolean {
		return _instance.includeTime ;
	}
	
	static public function initialize(name:String, color:Number, includes:Boolean):Void {
		_logger = Log.getLogger() ;
		_instance = new SOSTarget(color) ;
		_instance.setAppName(name || "SOSTracer");
		_instance.getIdentify() ;
		_instance.level = LogEventLevel.ALL ;
		if (includes) setIncludes(true, true, true, true, true) ;
		Log.addTarget(_instance) ; 
		
	}
	
	static public function release():Void {
		Log.removeTarget(_instance) ;
		_instance.close() ;
		_instance = null ;
		_logger = null ;
	}

	static public function setIncludeCategory(b:Boolean):Void {
		_instance.includeCategory = b ;
	}

	static public function setIncludeDate(b:Boolean):Void {
		_instance.includeDate = b ;
	}
	
	static public function setIncludeLevel(b:Boolean):Void {
		_instance.includeLines = b ;
	}
	
	static public function setIncludeLines(b:Boolean):Void {
		_instance.includeLines = b ;
	}

	static public function setIncludes(lines:Boolean, level:Boolean, time:Boolean, date:Boolean, category:Boolean):Void {
		if (lines != null ) _instance.includeLines = lines ;
		if (level != null ) _instance.includeLevel = level ;
		if (time != null ) _instance.includeTime = time ;
		if (date != null ) _instance.includeDate = date ;
		if (category != null ) _instance.includeCategory = category ;
	}

	static public function setIncludeTime(b:Boolean):Void {
		_instance.includeTime = b ;
	}

	static public function trace(o):Void {
		_logger.debug.apply(_logger, [].concat(arguments)) ;
	}
	
	static public var traceReplacer:Function = trace ;

	// ----o Private Property
	
	static private var _instance:SOSTarget ;
	static private var _logger:ILogger ;
	
	
}