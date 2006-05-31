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

/** LuminicTarget

	AUTHOR
	
		Name : LuminicTarget
		Package : vegas.logging.targets
		Version : 1.0.0.0
		Date :  2006-01-17
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new LuminicTarget(depth:Number, collapse:Boolean)

	PROPERTY SUMMARY
		
		- includeCategory:Boolean
		
			Indicates if the category for this target should added to the trace. Only if isCollapse is false.
		
		- includeDate:Boolean
		
			Indicates if the date should be added to the trace. Only if isCollapse is false.
		
		- includeLevel:Boolean
		
			Indicates if the level for the event should added to the trace. Only if isCollapse is false.
		
		- includeLines:Boolean
		
			Indicates if a line number should be added to the trace. Only if isCollapse is false.
		
		- includeTime:Boolean
		
			Indicates if the time should be added to the trace. Only if isCollapse is false.
		
		- isCollapse:Boolean
		
			Indicate if the LuminicBox Console use collapse presentation or not.
		
		- maxDepth:Number [R/W] 
		
			object's depth value between 1 and 255.

	METHOD SUMMARY
	
		- formatLogEvent(ev:LogEvent):Object
		
		- getMaxDepth():Number
		
		- override logEvent(e:LogEvent):Void
		
		- setMaxDepth(n:Number):Void
		
		- toString():String
	
	INHERIT 
	
		CoreObject → AbstractTarget → LineFormattedTarget → TraceTarget → LuminicTarget

	IMPLEMENTS
	
		EventListener, ITarget, IFormattable, IHashable

	THANKS
	
		Pablo Costantini :: LuminicBox
			http://www.luminicbox.com/blog/default.aspx?page=post&id=2

----------  */	

import vegas.logging.LogEvent;
import vegas.logging.targets.TraceTarget;
import vegas.maths.Range;
import vegas.util.factory.PropertyFactory;

class vegas.logging.targets.LuminicTarget extends TraceTarget {
	
	// ----o Constructor
	
	public function LuminicTarget(depth:Number, collapse:Boolean) {
		isCollapse = (collapse == false) ? false : true ;
		setMaxDepth(depth || 4) ;
		_lc = new LocalConnection() ;
	}
	
	// ----o Public Properties

	public var isCollapse:Boolean ;
	public var maxDepth:Number ; // [R/W]

	// ----o Public Methods

	/*override*/ public function formatLogEvent(ev:LogEvent):Object {
		var context:Object = {
			loggerId     : null ,
			levelName    : ev.level.toString() ,
			time : new Date()
		};
		if (isCollapse) {
			context.argument = _serializeObj( ev.context , 1) ;
		} else {
			var data:Object = new Object();
			data.type = "string" ;
			data.value = _formatMessage(
				ev.context.toString() , 
				ev.level.toString(), 
				ev.getTarget().category, 
				context.time
			) ;
			context.argument = data ;
		}
		
		return context ;
	}

	public function getMaxDepth():Number {
		return _maxDepth ;
	}

	/*override*/ public function logEvent(e:LogEvent) {
		_lc.send( "_luminicbox_log_console", "log", formatLogEvent(e)) ;
	}

	public function setMaxDepth(value:Number) {
		var r:Range = new Range(1, 255) ;
		_maxDepth = r.clamp(value) ;
	}
	
	public function toString():String {
		return "[LuminicTarget]" ;
	}

	// ----o Virtual Properties
	
	static private var __MAXDEPTH__:Boolean = PropertyFactory.create(LuminicTarget, "maxDepth", true) ;
	
	// ----o Private Properties
	
	private var _maxDepth:Number ;
	private var _lc:LocalConnection ;
	
	// ----o Private Methods
	
	private function _serializeObj(o, depth:Number) : Object {
		
		var type = _getType(o) ;
		var serial:Object = {} ;
		
		if (!type.inspectable) {
			
			serial.value = o ;
			
		}else if(type.stringify) {
			
			serial.value = o + "" ;
			
		} else {
			
			if (depth <= _maxDepth) 	{
				
				if(type.name == "movieclip" || type.name == "button") serial.id = o + "" ;
				var items:Array = [] ;
				if(o instanceof Array) {
					var len:Number = o.length ;
					for(var i:Number=0; i<len ; i++) {
						items[i] = {
							property : i ,
							value : _serializeObj( o[i], (depth+1) )
						} ;
					}
					
				} else {
					for (var prop:String in o) {
						items.push( {
							property : prop ,
							value : _serializeObj( o[prop], (depth+1) )
						} ) ;
					} 
				}
				
				serial.value = items ;
				
			} else {
				
				serial.reachLimit = true ;
				
			}
		}
		serial.type = type.name ;
		return serial ;
	}
	
	private function _getType(o):Object {
		var tof = typeof(o);
		var type = new Object();
		type.inspectable = true ;
		type.name = tof ;
		switch( tof ) {
			case "string" :
			case "boolean" :
			case "number" :
			case "undefined" :
			case "null" :
				type.inspectable = false ;
				break ;
			default :	
				if(o instanceof Date) {
					type.inspectable = false ;
					type.name = "date" ;
				} else if(o instanceof Array) {
					type.name = "array" ;
				} else if(o instanceof Button) {
					type.name = "button";
				} else if(o instanceof MovieClip) {
					type.name = "movieclip";
				} else if(o instanceof XML) {
					type.name = "xml" ;
					type.stringify = true ;
				} else if(o instanceof XMLNode) {
					type.name = "xmlnode" ;
					type.stringify = true ;
				} else if(o instanceof Color) {
					type.name = "color" ;
				}
		}
		return type ;
	}
	

}