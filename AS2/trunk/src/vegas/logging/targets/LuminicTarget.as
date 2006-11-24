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

import vegas.logging.LogEvent;
import vegas.logging.targets.TraceTarget;
import vegas.maths.Range;
import vegas.util.TypeUtil;

/**
 * Provides a logger target that uses the FlashInspector console to output log messages. 
 * Thanks Pablo Costantini and LuminicBox <a href='http://www.luminicbox.com/blog/default.aspx?page=post&id=2'>FlashInspector</a>.
 * @author eKameleon
 */
class vegas.logging.targets.LuminicTarget extends TraceTarget 
{
	
	/**
	 * Creates a new LuminicTarget instance.
	 */
	public function LuminicTarget(depth:Number, collapse:Boolean) 
	{
		_lc = new LocalConnection() ;
		isCollapse = (collapse == false) ? false : true ;
		setMaxDepth( depth || 4 ) ;
	}
	
	/**
	 * Indicated if the console use collapse property or not.
	 */
	public var isCollapse:Boolean ;
	
	/**
	 * (read-only) Returns the max depth to collaspe the structure of an object in the console.
	 */
	public function get maxDepth():Number
	{
		return getMaxDepth() ;	
	}

	/**
	 * (read-only) Sets the max depth to collaspe the structure of an object in the console.
	 */
	public function set maxDepth( value:Number ):Void
	{
		setMaxDepth(value) ;	
	}

	/**
	 * Returns and format the string representation of the log event.
	 */
	/*override*/ public function formatLogEvent(ev:LogEvent):Object 
	{
		
		var category:String = ev.getTarget().category ;
		var level:String = ev.level.toString() ;
		var msg = ev.context ;
		var time:Date = new Date(ev.getTimeStamp()) ; 
		
		var context:Object = { loggerId:null , levelName:level , time:time };
		
		if ( !TypeUtil.typesMatch( msg, String ) && isCollapse ) 
		{
			context.argument = _serializeObj( msg , 1) ;	
		}
		else 
		{
			var data:Object = new Object();
			data.type = "string" ;
			data.value = _formatMessage
			(
				msg.toString() , 
				level, 
				category, 
				context.time
			) ;
			context.argument = data ;
		}
		
		return context ;
	}

	/**
	 * Returns the max depth to collaspe the structure of an object in the console.
	 */
	public function getMaxDepth():Number 
	{
		return _maxDepth ;
	}
	
	/**
	 * This method handles a LogEvent from an associated logger.
	 */
	/*override*/ public function logEvent(e:LogEvent) 
	{
		_lc.send( "_luminicbox_log_console", "log", formatLogEvent(e)) ;
	}

	/**
	 * Sets the max depth to collaspe the structure of an object in the console.
	 */
	public function setMaxDepth(value:Number) 
	{
		var r:Range = new Range(1, 255) ;
		_maxDepth = r.clamp(value) ;
	}
	
	/**
	 * Internal max depth value.
	 */
	private var _maxDepth:Number ;
	
	/**
	 * Internal LocalConnection reference.
	 */
	private var _lc:LocalConnection ;
	
	/**
	 * Serialize un object before send the message in the console.
	 */
	private function _serializeObj(o, depth:Number) : Object {
		
		var type = _getType(o) ;
		var serial:Object = {} ;
		
		if (!type.inspectable) 
		{
			serial.value = o ;
		}
		else if(type.stringify) 
		{
			serial.value = o + "" ;
		}
		else 
		{
			if (depth <= _maxDepth) 	
			{
				if(type.name == "movieclip" || type.name == "button") 
				{
					serial.id = o + "" ;
				}
				var items:Array = [] ;
				if(o instanceof Array) 
				{
					var len:Number = o.length ;
					for(var i:Number=0; i<len ; i++) 
					{
						items[i] = 
						{
							property : i ,
							value : _serializeObj( o[i], (depth+1) )
						} ;
					}
					
				}
				else 
				{
					for (var prop:String in o) 
					{
						items.push
						( 
							{
								property : prop ,
								value : _serializeObj( o[prop], (depth+1) )
							} 
						) ;
					} 
				}
				
				serial.value = items ;
				
			}
			else 
			{
				serial.reachLimit = true ;
			}
		}
		serial.type = type.name ;
		return serial ;
	}
	
	/**
	 * Returns an object with all the config of the current log content.
	 */
	private function _getType(o):Object 
	{
		var tof:String = typeof(o);
		var type = new Object();
		type.inspectable = true ;
		type.name = tof ;
		switch( tof ) 
		{
			case "string" :
			case "boolean" :
			case "number" :
			case "undefined" :
			case "null" :
			{
				type.inspectable = false ;
				break ;
			}
			default :
			{	
				if(o instanceof Date) 
				{
					type.inspectable = false ;
					type.name = "date" ;
				}
				else if(o instanceof Array) 
				{
					type.name = "array" ;
				}
				else if(o instanceof Button) 
				{
					type.name = "button";
				}
				else if(o instanceof MovieClip) 
				{
					type.name = "movieclip";
				}
				else if(o instanceof XML) 
				{
					type.name = "xml" ;
					type.stringify = true ;
				}
				else if(o instanceof XMLNode) 
				{
					type.name = "xmlnode" ;
					type.stringify = true ;
				}
				else if(o instanceof Color) 
				{
					type.name = "color" ;
				}
			}
		}
		return type ;
	}
	

}