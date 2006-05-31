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

/** SOSTarget

	AUTHOR
	
		Name : SOSTarget
		Package : vegas.logging.targets
		Version : 1.0.0.0
		Date :  2006-01-17
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new SOSTarget(color:Number) ;

	PROPERTY SUMMARY
		
		- includeCategory:Boolean
		
			Indicates if the category for this target should added to the trace.
		
		- includeDate:Boolean
		
			Indicates if the date should be added to the trace.
		
		- includeLevel:Boolean
		
			Indicates if the level for the event should added to the trace.
		
		- includeLines:Boolean
		
		- includeTime:Boolean
		
			Indicates if the time should be added to the trace.
		
		- isConnected:Boolean [Read Only]
		
		- levelPolicy:Number
		
			show level colors SOSType.ENABLE or SOSType.DISABLE
			
	METHOD SUMMARY
	
		- clear():Void
	
			clear SOS console.
	
		- close():Void
			
			close SOS console connection
			
		- connect():Void
		
			connect SOS console.
		
		- exit():Void	
		
			close SOS console.
		
		- formatLogEvent(ev:LogEvent):String
		
		- getIdentify():Void
		
			Shows some Information about the Connection.
			This time it is : HostName, HostAddress and Color.
		
		- getIsConnected():Boolean
		
		- override logEvent(e:LogEvent):Void
		
		- sendLevelMessage(level:Number, message:String):Void
		
		- sendMessage(message:String):Void
		
			send message or bufferize message if the SOS console is disconnected.
		
		- setAppName(name:String):Void 
		
			Each Command or Log Connection can have a name. You can set this name with this command.
		
		- setAppColor(color:Number):Void 
		
			The Color must be set as Integer Value. So 16768477 equals 0xffdddd.
		
		- setLevelColor(level:LogEventLevel, color:Number):Void
		
		- toString():String

	INHERIT 
	
		CoreObject → AbstractTarget → LineFormattedTarget → TraceTarget → SOSTarget

	IMPLEMENTS
	
		EventListener, ITarget, IFormattable, IHashable

**/	

import vegas.data.iterator.Iterator;
import vegas.data.queue.LinearQueue;
import vegas.events.Delegate;
import vegas.logging.LogEvent;
import vegas.logging.LogEventLevel;
import vegas.logging.SOSType;
import vegas.logging.targets.TraceTarget;
import vegas.util.factory.PropertyFactory;

class vegas.logging.targets.SOSTarget extends TraceTarget {

	// ----o Constructor
	
	public function SOSTarget(color:Number) {
		
		// --- Init Buffer queue object
		
		_queue = new LinearQueue() ;
		
		// --- Init Application Color
		
		setAppColor(isNaN(color) ? SOSType.DEFAULT_COLOR : color) ;
		
		// --- Init XMLSocket object
		
		_xs = new XMLSocket() ;
		_xs.onConnect = Delegate.create(this, _connect) ;
		
		// ----o Init Colors
		
		setLevelColor(LogEventLevel.ALL) ;
		setLevelColor(LogEventLevel.DEBUG) ;
		setLevelColor(LogEventLevel.ERROR) ;
		setLevelColor(LogEventLevel.FATAL) ;
		setLevelColor(LogEventLevel.INFO) ;
		setLevelColor(LogEventLevel.WARN) ;
		
		levelPolicy = SOSType.ENABLE ;
		
		// ----o Connect Console
		
		connect() ;
		
	}
	
	// ----o Public Properties
	
	public var isConnected:Boolean ; // [R/W]
	public var levelPolicy:Number ;
	
	// ----o Public Methods

	public function clear():Void {
		sendMessage(SOSType.CLEAR) ;
	}

	public function close():Void {
		_isConnected = false ;
		_xs.close() ;
	}

	public function connect() {
		if (_isConnected) close() ;
		_xs.connect(SOSType.HOST, SOSType.PORT) ;
	}

	public function exit():Void {
		sendMessage(SOSType.EXIT) ;
	}

	public function getIdentify():Void {
		sendMessage("!SOS<identify/>") ;
	}

	public function getIsConnected():Boolean {
		return _isConnected ;
	}

	/*override*/ public function logEvent(e:LogEvent) {
		var msg:String = formatLogEvent(e) ;
		sendLevelMessage(e.level, msg) ;
	}

	public function sendLevelMessage(level:Number, message:String):Void {
		if (levelPolicy == SOSType.ENABLE) {
			message = "!SOS<showMessage key='" + String(level) + "'>" + String(message) + "</showMessage>\n" ;
		}
		sendMessage(message) ;
	}

	public function sendMessage(msg:String):Void {
		if (_isConnected) {
			_xs.send(msg) ;
		} else {
			_queue.enqueue(msg) ;
		}
	}

	public function setAppName(name:String):Void {
		sendMessage("!SOS<appName>" + name + "</appName>") ;
	}
	
	public function setAppColor(color:Number):Void {
		sendMessage("!SOS<appColor>" + color + "</appColor>") ;
	}
	
	public function setLevelColor(level:LogEventLevel, color:Number):Void {
		if (!LogEventLevel.isValidLevel(level)) return ;
		var msg:String = "!SOS<setKey>" ;
		msg += "<name>" + level.toString() + "</name>" ;
		msg += "<color>"+ (color || SOSType[level.toString()+"_COLOR"]) + "</color>" ;
		msg += "</setKey>\n" ;
		sendMessage(msg) ;
	}
	
	// ----o Virtual Properties
	
	static private var __ISCONNECTED__:Boolean = PropertyFactory.create(SOSTarget, "isConnected", true, true) ;
	
	// ----o Private Properties
	
	private var _color:Number ;
	private var _isConnected:Boolean ;
	private var _queue:LinearQueue ;
	private var _xs:XMLSocket ;
	
	// ----o Private Methods
	
	private function _connect(success:Boolean):Void {
		if (success) {
			_flush() ;
			_isConnected = true ;
		} else {
			throw new Error("SOS Socket connection failed") ;
		}
	}
	
	private function _flush() {
		if (_queue.size() > 0) {
			var it:Iterator = _queue.iterator() ;
			while (it.hasNext()) _xs.send(it.next()) ;
		}
	}
	
}