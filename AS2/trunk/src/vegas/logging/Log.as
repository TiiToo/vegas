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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.data.map.HashMap;
import vegas.logging.errors.InvalidCategoryError;
import vegas.logging.ILogger;
import vegas.logging.ITarget;
import vegas.logging.LogLogger;
import vegas.util.StringUtil;

/**
 * Provides psuedo-hierarchical logging capabilities with multiple format and output options.
 * @author eKameleon
 */
class vegas.logging.Log 
{

	/**
	 * const The default categoty of the {@code ILogger} instances returns with the {@code getLogger} method.
	 */
	static public var DEFAULT_CATEGORY:String = "" ;
	
	/**
	 * const The string representation of all the illegal characters.
	 */
	static public var ILLEGALCHARACTERS:String = "[]~$^&/\\(){}<>+=`!#%?,:;'\"@" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(Log, null , 7, 7) ;
	
	/**
	 * Allows the specified target to begin receiving notification of log events.
	 * @param target specific target that should capture log events.
	 */
	static public function addTarget(target:ITarget, logger:ILogger):Void 
	{
		target.addLogger( __logger ) ;
	}

	/**
	 * This method removes all of the current loggers from the cache.
	 */
	static public function flush():Void 
	{
		Log.__categories.clear() ;
	}
	
	/**
	 * Returns the logger associated with the specified category.
	 * If the category given doesn't exist a new instance of a logger will be returned and associated with that category. Categories must be at least one character in length and may not contain any blanks or any of the following characters: []~$^&\/(){}<>+=`!#%?,:;'"@
	 * @param The String to check for illegal characters. The following characters are not valid: []~$^&\/(){}<>+=`!#%?,:;'"@ 
	 * @return An instance of a logger object for the specified name. If the name doesn't exist, a new instance with the specified name is returned.
	 * @throws InvalidCategoryError if the category specified is malformed.
	 */
	static public function getLogger(category:String, isQueue:Boolean):ILogger 
	{
		if (hasIllegalCharacters(category)) throw new InvalidCategoryError ;
		if (!category) category = DEFAULT_CATEGORY ;
		if (! Log.__categories.containsKey(category)) 
		{
			var logger:LogLogger = new LogLogger(category) ;
			logger.isQueue = isQueue ;
			logger.parent = __logger ; // Bubbling Event
			Log.__categories.put(category, logger) ;
		}
		return Log.__categories.get(category) ;
	}
		
	/**
	 * This method checks the specified string value for illegal characters.
	 * @param value The String to check for illegal characters. The following characters are not valid: []~$^&\/(){}<>+=`!#%?,:;'"@
	 * @return {code true} if there are any illegal characters found, false otherwise.
	 */
	static public function hasIllegalCharacters(value:String):Boolean 
	{
		var a = ILLEGALCHARACTERS.split("") ;
		var s:StringUtil = new StringUtil(value) ;
		return s.indexOfAny( a ) != -1 ;
	}
	
	/**
	 * Stops the specified target from receiving notification of log events.
	 * @param specific target that should capture log events.
	 */
	static public function removeTarget(target:ITarget, logger:ILogger):Void 
	{
		target.removeLogger(logger || __logger) ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	static public function toString():String 
	{
		return "[Log]" ;
	}

	/**
	 * The internal categories HashMap.
	 */
	static private var __categories:HashMap = new HashMap() ;

	/**
	 * The internal logger.
	 */
	static private var __logger:LogLogger = new LogLogger() ;
	
	

}