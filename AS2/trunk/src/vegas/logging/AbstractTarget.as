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

/* -------- AbstractTarget

	AUTHOR

		Name : AbstractTarget
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2005-10-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- filters:Array
		
			In addition to the level setting, filters are used to provide a pseudo hierarchical 
			mapping for processing only those events for a given category.
		
		
		- level:Number
		
			Provides access to the level this target is currently set at.


	METHOD SUMMARY
	
		- addLogger(logger:ILogger):Void
		
			Sets up this target with the specified logger.
			
			NOTE this method is called by the framework and should not be called by the developer.
		
		- initialized(document:Object, id:String):Void
		
			Called after the implementing object has been created and all properties specified on the tag have been assigned.
		
		- handleEvent(event:Event) : Void
		
			This method handles a LogEvent from an associated logger.
		
		- removeLogger(logger:ILogger):Void
		
			Stops this target from receiving events from the specified logger.
			
			NOTE this method is called by the framework and should not be called by the developer.
		
		- toString():String
	
	INHERIT 
	
		Object > AbstractTarget
	
	
	IMPLEMENTS
	
		EventListener, ITarget, IFormattable

------------*/

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.logging.ILogger;
import vegas.logging.ITarget;
import vegas.logging.Log;
import vegas.logging.LogEvent;
import vegas.logging.LogEventLevel;
import vegas.string.WildExp;
import vegas.util.ArrayUtil;

class vegas.logging.AbstractTarget extends CoreObject implements ITarget {

	// ----o Constructor
	
	private function AbstractTarget() {
		//
	}

	// ----o Public Properties

	public var filters:Array ;
	public var level:Number ;
	
	// ----o Public Methods
	
	public function addLogger(logger:ILogger):Void {
		logger.addEventListener(LogEvent.LOG, this) ;
	}

	public function addNamespace(namespace:String):Boolean {
		if (filters == undefined) filters = [] ;
		if (ArrayUtil.contains(filters, namespace)) return false ;
		filters.push(namespace) ;
	}

	public function logEvent(e:LogEvent):Void {
		//
	}

	public function handleEvent(e:Event) {
		if ( level == LogEventLevel.ALL || level == LogEvent(e).level ) {
			var category:String = LogEvent(e).getTarget().category ;
			var isValid:Boolean = _isValidCategory(category) ;
			if (isValid) logEvent(LogEvent(e)) ;
		}
	}
	
	public function removeLogger(logger:ILogger):Void {
		logger.removeEventListener(LogEvent.LOG) ;
	}
	
	public function removeNamespace(namespace:String):Boolean {
		var pos:Number = ArrayUtil.indexOf(filters, namespace) ;
		if ( pos > -1) {
			filters.splice(pos, 1) ;
			return true ;
		} else {
			return false ;
		}
	}
	
	// ----o Private Methods
	
	private function _isValidCategory(category:String):Boolean {
		if (category == Log.DEFAULT_CATEGORY) return true ;
		var l:Number = filters.length ;
		if (l > 0) {
			for (var i:Number = 0 ; i<l ; i++) {
				var pattern:String = filters[i] ;
				var we:WildExp = new WildExp( pattern, WildExp.IGNORECASE | WildExp.MULTIWORD );
				var result = we.test( category ) ;
				if (result == true || pattern == category) return true ;
			}
			return false ;
		} else {
			return true ;
		}
	}
	
}