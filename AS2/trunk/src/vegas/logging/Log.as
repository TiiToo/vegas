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

/* -------- Log

	AUTHOR

		Name : Log
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2005-10-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- DEFAULT_CATEGORY : ""
		
		- ILLEGALCHARACTERS : "[]~$^&\/(){}<>+=`!#%?,:;'\"@"

	METHOD SUMMARY
	
		- static addTarget(target:ITarget, [logger:ILogger] ):Void
		
			DESCRIPTION
			
				Allows the specified target to begin receiving notification of log events.
			
			PARAMS
			
				- target : an ITarget instance
				
				- logger : optional ILogger instance
		
		- static flush():Void
		
			This method will remove all of the current loggers from the cache.
		
		- static getLogger(category:String, isQueue:Boolean) : ILogger 
		
			Returns the logger associated with the specified category.
			If the category given doesn't exist a new instance of a logger will be returned and associated with that category.
			Categories must be at least one character in length and may not contain any blanks or any of the following characters :
				[]~$^&\/(){}<>+=`!#%?,:;'"@ 
			This method will throw an InvalidCategoryError if the category specified is malformed.
		
		- static hasIllegalCharacters(value:String) : Boolean 
		
			This method checks the specified string value for illegal characters.
			
			Parameters
				
				value:String : string to check for illegal characters. The following characters are not valid: []~$^&\/(){}<>+=`!#%?,:;'"@
			
			Returns
			
				Boolean : true if there are any illegal characters found, false otherwise
		
		- static removeTarget(target:ITarget, [logger:ILogger] ) : Void 
			
			Stops the specified target from receiving notification of log events.

------------*/

import vegas.data.map.HashMap;
import vegas.events.Event;
import vegas.logging.errors.InvalidCategoryError;
import vegas.logging.ILogger;
import vegas.logging.ITarget;
import vegas.logging.LogLogger;
import vegas.util.StringUtil;

class vegas.logging.Log {

	// ----o Constructor
	
	private function Log() {
		//
	}

	// ----o Static Properties
	
	static var DEFAULT_CATEGORY:String = "" ;
	
	static var ILLEGALCHARACTERS:String = "[]~$^&/\\(){}<>+=`!#%?,:;'\"@" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(Log, null , 7, 7) ;
	
	// ----o Public Methods
	
	static public function addTarget(target:ITarget, logger:ILogger):Void {
		target.addLogger( __logger ) ;
	}

	static public function flush():Void {
		Log.__categories.clear() ;
	}
	
	static public function getLogger(category:String, isQueue:Boolean):ILogger {
		if (hasIllegalCharacters(category)) throw new InvalidCategoryError ;
		if (!category) category = DEFAULT_CATEGORY ;
		if (! Log.__categories.containsKey(category)) {
			var logger:LogLogger = new LogLogger(category) ;
			logger.isQueue = isQueue ;
			logger.parent = __logger ; // Bubbling Event
			Log.__categories.put(category, logger) ;
		}
		return Log.__categories.get(category) ;
	}
		
	static public function hasIllegalCharacters(value:String):Boolean {
		var a = ILLEGALCHARACTERS.split("") ;
		var s:StringUtil = new StringUtil(value) ;
		return s.indexOfAny( a ) != -1 ;
	}
	
	static public function removeTarget(target:ITarget, logger:ILogger):Void {
		target.removeLogger(logger || __logger) ;
	}

	static public function toString():String {
		return "[Log]" ;
	}

	// ----o Private Properties
	
	static private var __logger:LogLogger = new LogLogger ;
	static private var __categories:HashMap = new HashMap ;

	// ----o Private Methods
	
	static private function _handleEvent(e:Event) {
		__logger.dispatchEvent(e) ;
	}
	

}