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

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.logging.ILogger;
import vegas.logging.ITarget;
import vegas.logging.Log;
import vegas.logging.LogEvent;
import vegas.logging.LogEventLevel;
import vegas.string.WildExp;
import vegas.util.ArrayUtil;

/**
 * This class provides the basic functionality required by the logging framework for a target implementation. It handles the validation of filter expressions and provides a default level property. No implementation of the logEvent() method is provided.
 * @author eKameleon
 */
class vegas.logging.AbstractTarget extends CoreObject implements ITarget 
{

	/**
	 * Creates a new AbstractTarget instance.
	 */
	private function AbstractTarget() {
		//
	}

	/**
	 * In addition to the level setting, filters are used to provide a pseudo hierarchical mapping for processing only those events for a given category.
	 */
	public var filters:Array ;
	
	/**
	 * Provides access to the level this target is currently set at.
	 */
	public var level:Number ;
	
	/**
	 * Sets up this target with the specified logger.
	 * Note : this method is called by the framework and should not be called by the developer.
	 */
	public function addLogger(logger:ILogger):Void 
	{
		logger.addEventListener(LogEvent.LOG, this) ;
	}

	/**
	 * Add a new namespace in the filters array.
	 */
	public function addNamespace(namespace:String):Boolean 
	{
		if (filters == undefined) 
		{
			filters = [] ;
		}
		if ( ArrayUtil.contains(filters, namespace) ) 
		{
			return false ;
		}
		else
		{
			filters.push(namespace) ;
			return true ;
		}
	}

	/**
	 * This method is called whenever an event occurs of the type for which the EventListener interface was registered.
	 */
	public function handleEvent(e:Event) 
	{
		if ( level == LogEventLevel.ALL || level == LogEvent(e).level ) {
			var category:String = LogEvent(e).getTarget().category ;
			var isValid:Boolean = _isValidCategory(category) ;
			if (isValid) logEvent(LogEvent(e)) ;
		}
	}

    /**
     *  This method handles a <code>LogEvent</code> from an associated logger.
     *  <p>A target uses this method to translate the event into the appropriate format for transmission, storage, or display.</p>
     *  <p>This method will be called only if the event's level is in range of the target's level.</p>
     *  <p><b><i>Descendants need to override this method to make it useful.</i></b></p>
     */		
	public function logEvent(e:LogEvent):Void 
	{
		//
	}
			
	/**
	 * Stops this target from receiving events from the specified logger.
	 * Note : this method is called by the framework and should not be called by the developer.
	 */
	public function removeLogger(logger:ILogger):Void 
	{
		logger.removeEventListener(LogEvent.LOG, this) ;
	}

	/**
	 * Removes an existing namespace in the filters array.
	 */
	public function removeNamespace(namespace:String):Boolean 
	{
		var pos:Number = ArrayUtil.indexOf(filters, namespace) ;
		if ( pos > -1) 
		{
			filters.splice(pos, 1) ;
			return true ;
		} 
		else 
		{
			return false ;
		}
	}
	
	/**
	 * Returns 'true' is the passed argument is a valid category.
	 */
	private function _isValidCategory(category:String):Boolean 
	{
		if (category == Log.DEFAULT_CATEGORY) return true ;
		var l:Number = filters.length ;
		if (l > 0) 
		{
			for (var i:Number = 0 ; i<l ; i++) 
			{
				var pattern:String = filters[i] ;
				var we:WildExp = new WildExp( pattern, WildExp.IGNORECASE | WildExp.MULTIWORD );
				var result = we.test( category ) ;
				if (result == true || pattern == category) 
				{
					return true ;
				}
			}
			return false ;
		} 
		else 
		{
			return true ;
		}
	}
	
}