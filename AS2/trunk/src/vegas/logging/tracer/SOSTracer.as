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

import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.logging.LogEventLevel;
import vegas.logging.targets.SOSTarget;

/**
 * This static class create a tracer to use with MTASC and this {@code -trace} command.
 * @author eKameleon
 */
class vegas.logging.tracer.SOSTracer 
{

	/**
	 * Provides the category of the current tracer.
	 */	
	static public var category:String ;

	/**
	 * Launch the {@code clear} method of the internal SOSTarget instance.
	 */
	static public function clear():Void 
	{
		_instance.clear() ;
	}
	
	/**
	 * Launch the {@code exit} method of the internal SOSTarget instance.
	 */
	static public function exit():Void 
	{
		_instance.exit() ;
	}

	/**
	 * Returns the include category value of the internal SOSTarget instance.
	 */
	static public function getIncludeCategory():Boolean 
	{
		return _instance.includeCategory ;
	}

	/**
	 * Returns the include date value of the internal SOSTarget instance.
	 */
	static public function getIncludeDate():Boolean 
	{
		return _instance.includeDate ;
	}

	/**
	 * Returns the include level value of the internal SOSTarget instance.
	 */
	static public function getIncludeLevel():Boolean 
	{
		return _instance.includeLines ;
	}
	
	/**
	 * Returns the include lines value of the internal SOSTarget instance.
	 */
	static public function getIncludeLines():Boolean 
	{
		return _instance.includeLines ;
	}

	/**
	 * Returns the include time value of the internal SOSTarget instance.
	 */
	static public function getIncludeTime():Boolean 
	{
		return _instance.includeTime ;
	}

	/**
	 * Returns the internal SOSTarget reference.
	 */
	static public function getTargetInstance():SOSTarget 
	{
		return _instance ;	
	}
	
	/**
	 * Initialize the SOSTracer.
	 * @param name the default name of the application.
	 * @param color the default color of the application.
	 * @param includes a boolean, {@code true} if you wan includes time, date, level and lines in your logs.
	 */
	static public function initialize(name:String, color:Number, includes:Boolean):Void 
	{
		_logger = Log.getLogger() ;
		_instance = new SOSTarget(color) ;
		_instance.setAppName(name || "SOSTracer");
		_instance.getIdentify() ;
		_instance.level = LogEventLevel.ALL ;
		if (includes)
		{
			setIncludes(true, true, true, true, true) ;
		}
		Log.addTarget(_instance) ; 
		
	}
	
	/**
	 * Release the SOSTracer.
	 */
	static public function release():Void 
	{
		Log.removeTarget(_instance) ;
		_instance.close() ;
		_instance = null ;
		_logger = null ;
	}

	/**
	 * Sets the include category value of the internal SOSTarget instance.
	 */
	static public function setIncludeCategory(b:Boolean):Void 
	{
		_instance.includeCategory = b ;
	}

	/**
	 * Sets the include date value of the internal SOSTarget instance.
	 */
	static public function setIncludeDate(b:Boolean):Void 
	{
		_instance.includeDate = b ;
	}

	/**
	 * Sets the include level value of the internal SOSTarget instance.
	 */
	static public function setIncludeLevel(b:Boolean):Void 
	{
		_instance.includeLines = b ;
	}

	/**
	 * Sets the include lines value of the internal SOSTarget instance.
	 */	
	static public function setIncludeLines(b:Boolean):Void 
	{
		_instance.includeLines = b ;
	}

	/**
	 * Sets all the include values of the internal SOSTarget instance.
	 */
	static public function setIncludes(lines:Boolean, level:Boolean, time:Boolean, date:Boolean, category:Boolean):Void 
	{
		if (lines != null ) 
		{
			_instance.includeLines = lines ;
		}
		if (level != null )
		{
			_instance.includeLevel = level ;
		}
		if (time != null )
		{
			_instance.includeTime = time ;
		}
		if (date != null )
		{
			_instance.includeDate = date ;
		}
		if (category != null )
		{
			_instance.includeCategory = category ;
		}
	}

	/**
	 * Sets the include time value of the internal SOSTarget instance.
	 */	
	static public function setIncludeTime(b:Boolean):Void 
	{
		_instance.includeTime = b ;
	}

	/**
	 * Trace a message with the internal SOSTarget.
	 */
	static public function trace(o):Void 
	{
		_logger.debug.apply(_logger, [].concat(arguments)) ;
	}

	/**
	 * This method is used in MTASC {@code -trace} command.
	 */
	static public function traceReplacer(o):Void
	{
		SOSTracer.trace( o ) ;
	}

	/**
	 * Internal SOSTarget singleton.
	 */	
	static private var _instance:SOSTarget ;

	/**
	 * Internal logger.
	 */
	static private var _logger:ILogger ;
	
}