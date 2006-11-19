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


import vegas.core.types.Int;
import vegas.util.serialize.Serializer;

/**
 * Static class containing constants for use in the level  property.
 * @author eKameleon
 */
class vegas.logging.LogEventLevel extends Int 
{
	
	/**
	 * Creates a new LogEventLevel instance.
	 */
	public function LogEventLevel(name:String, value:Number) 
	{
		super(value) ;
		_name = name ;
	}

	/**
	 * Intended to force a target to process all messages.
	 */
	static public var ALL:LogEventLevel = new LogEventLevel("ALL", 1000) ;

	/**
	 * Designates informational level messages that are fine grained and most helpful when debugging an application.
	 */
	static public var DEBUG:LogEventLevel = new LogEventLevel("DEBUG", 8) ;

	/**
	 * Designates error events that might still allow the application to continue running.
	 */	
	static public var ERROR:LogEventLevel = new LogEventLevel("ERROR", 2) ;
	
	/**
	 * Designates events that are very harmful and will eventually lead to application failure
	 */
	static public var FATAL:LogEventLevel = new LogEventLevel("FATAL", 6) ;

	/**
	 * Designates informational messages that highlight the progress of the application at coarse-grained level.
	 */
	static public var INFO:LogEventLevel = new LogEventLevel("INFO", 0) ;	

	/**
	 * Designates events that could be harmful to the application operation
	 */	
	static public var WARN:LogEventLevel = new LogEventLevel("WARN", 4) ; ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(LogEventLevel, null , 7, 7) ;
	
	/**
	 * Returns true if the number level passed in argument is valid.
	 */
	static public function isValidLevel(level:Number):Boolean 
	{
		var levels:Array = [ALL, DEBUG, ERROR, FATAL, INFO, WARN] ;
		var l:Number = levels.length ;
		while (--l > -1) if (level == levels[l]) return true ;
		return false ;
	}
	
	/**
	 * Returns the string representation of the object.
	 */	
	/*override*/ public function toString():String 
	{ 
		return _name ; 
	}

	/**
	 * The name of this LogEventLevel instance.
	 */
	private var _name:String ;

	/**
	 * This method is used by the toSource method.
	 */
	/*protected*/ private function _getParams():Array 
	{
		return [ Serializer.toSource(_name) ].concat(super._getParams()) ;
	}

}