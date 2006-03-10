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

/* -------- LuminicTracer

	AUTHOR
	
		Name : LuminicTracer
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2006-01-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- static category

	METHOD SUMMARY
	
		- static getInstance():LuminicTarget
		
		- static initialize(namespace:String):Void
		
		- static release():Void
		
		- static trace(o):Void
		
		- static traceReplacer(o):Void [MTASC]
	
	THANKS
	
		Pablo Costantini :: LuminicBox 
			http://www.luminicbox.com/blog/default.aspx?page=post&id=2

----------  */	


import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.logging.LogEventLevel;
import vegas.logging.targets.LuminicTarget;

class vegas.logging.LuminicTracer {
	
	// ----o Constructor
	
	private function LuminicTracer() {
		//
	}

	// ----o Public Properties
	
	static public var category:String ;
	
	// ----o Public Methods

	static public function getInstance():LuminicTarget {
		return _instance ;
	}

	static public function initialize(namespace:String, depth:Number, collapse:Boolean):Void {
		release() ;
		category = namespace ;
		if (category.length > 0) {
			_instance = new LuminicTarget(depth, collapse) ;
			_instance.filters = [category] ;
			_instance.level = LogEventLevel.ALL ;
			_instance.addLogger( _logger ) ;
			Log.addTarget(_instance) ; 
			_logger = Log.getLogger(namespace) ;
		}
	}

	static public function release():Void {
		Log.removeTarget(_instance) ;
		_instance = null ;
		_logger = null ;
	}

	static public function trace(o):Void {
		_logger.debug(o) ;
	}

	static public function traceReplacer(o):Void {
		LuminicTracer.trace(o) ;
	}
	
	// ----o Private Properties
	
	static private var _instance:LuminicTarget ;
	static private var _logger:ILogger ;
	
}