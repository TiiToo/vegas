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
import vegas.logging.targets.LuminicTarget;

/**
 * This static class create a tracer to use with MTASC and this {@code -trace} command.
 * @author eKameleon
 */
class vegas.logging.tracer.LuminicTracer 
{

	/**
	 * Provides the category of the current tracer.
	 */	
	static public var category:String ;

	/**
	 * Returns the internal singleton LuminicTarget instance.
	 * @return the internal singleton LuminicTarget instance.
	 */	
	static public function getInstance():LuminicTarget 
	{
		return _instance ;
	}
	
	/**
	 * Returns the internal ILogger of this tracer.
	 */
	static public function getLogger():ILogger
	{
		return _logger ;	
	}

	/**
	 * Initialize the LuminicTracer.
	 */
	static public function initialize(namespace:String, depth:Number, collapse:Boolean):Void 
	{
		
		release() ;
		
		category = namespace ;
		
		_instance = new LuminicTarget( depth , collapse ) ;
		_instance.filters = [ category ] ;
		_instance.level = LogEventLevel.ALL ;
		
		Log.addTarget( _instance ) ;
		
		_logger = Log.getLogger(namespace) ;
		
	}

	/**
	 * Release the LuminicTracer.
	 */
	static public function release():Void 
	{
		if (_instance != null)
		{
			Log.removeTarget(_instance) ;
		}
		_instance = null ;
		_logger = null ;
	}

	/**
	 * Trace a message with the internal LuminicTarget.
	 */
	static public function trace(o):Void 
	{
		_logger.debug(o) ;
	}
	
	/**
	 * This method is used in MTASC {@code -trace} command.
	 */
	static public function traceReplacer(o):Void 
	{
		LuminicTracer.trace(o) ;
	}

	/**
	 * Internal LuminicTarget singleton.
	 */	
	static private var _instance:LuminicTarget ;

	/**
	 * Internal logger.
	 */
	static private var _logger:ILogger ;
	
}