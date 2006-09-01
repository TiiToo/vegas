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
		Date :  2006-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	 CONSTRUCTOR
	
		new SOSTarget(color:Number) ;

	CONSTANT SUMMARY
	
		- const static ALL_COLOR:Number
		
		- const static CLEAR:String
		
		- const static DEBUG_COLOR:Number
		
		- const static DEFAULT_COLOR:Number
		
		- const static DISABLE:Number
		
		- const static ENABLE:Number
		
		- const static ERROR_COLOR:Number
		
		- const static EXIT:String
		
		- const static FATAL_COLOR:Number
		
		- const static HOST:String
		
		- const static INFO_COLOR:Number
		
		- const static PORT:Number
		
		- const static WARN_COLOR:Number
 
	PROPERTY SUMMARY
		
		- connected:Boolean [Read Only]
		
		- includeCategory:Boolean
		
			Indicates if the category for this target should added to the trace.
		
		- includeDate:Boolean
		
			Indicates if the date should be added to the trace.
		
		- includeLevel:Boolean
		
			Indicates if the level for the event should added to the trace.
		
		- includeLines:Boolean
		
		- includeTime:Boolean
		
			Indicates if the time should be added to the trace.

		- levelPolicy:Number
		
			show level colors SOSTarget.ENABLE or SOSTarget.DISABLE

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
		
		- identify():Void
		
			Shows some Information about the Connection.
			This time it is : HostName, HostAddress and Color.
		
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

*/

package vegas.logging.targets
{
    
    import flash.events.Event ;
    import flash.events.IOErrorEvent ;
    import flash.events.SecurityErrorEvent ;
    
    import flash.net.ObjectEncoding;
    import flash.net.XMLSocket ;
        
    import vegas.data.iterator.Iterator;
    import vegas.data.queue.LinearQueue;
    
    import vegas.logging.LogEventLevel;
       
    public class SOSTarget extends LineFormattedTarget
    {
        
        // ----o Constructor
        
        public function SOSTarget( name:String=null, color:Number=NaN , isIdenfify:Boolean=true  )
        {
            super();
            
            // --- Init Buffer queue object
		
		    _queue = new LinearQueue() ;
		
       		// --- Init Application
		
		    if (name != null)
		    {
    		    setAppName( name ) ;
		    }
		
    		setAppColor(isNaN(color) ? SOSTarget.DEFAULT_COLOR : color) ;
    		
    		if (isIdenfify)
    		{
    		    
    		    identify() ;
    		    
    		}
    		
    		// --- Init XMLSocket object
    		
    		_xs = new XMLSocket() ;
 
    		_xs.addEventListener(Event.CLOSE , _onClose) ;
    		_xs.addEventListener(Event.CONNECT, _onConnect) ;
    		_xs.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
            _xs.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError );

    		// ----o Init Colors
    		
    		setLevelColor(LogEventLevel.ALL) ;
    		setLevelColor(LogEventLevel.DEBUG) ;
    		setLevelColor(LogEventLevel.ERROR) ;
    		setLevelColor(LogEventLevel.FATAL) ;
    		setLevelColor(LogEventLevel.INFO) ;
	    	setLevelColor(LogEventLevel.WARN) ;
		
		    levelPolicy = ENABLE ;
		
    		// ----o Connect Console
		
	    	connect() ;
            
        }
        
        // ----o Constants
        
    	static public const CLEAR:String = "!SOS<clear/>\n" ;
    	static public const EXIT:String = "!SOS<exit/>" ;
    	static public const DISABLE:Number = 0 ; // levelPolicy
    	static public const ENABLE:Number = 1 ; // levelPolicy

    	// ----o Public Properties

        static public var ALL_COLOR:Number = 0xD7EEFD ;
    	static public var DEBUG_COLOR:Number = 0xDEECFE ;
    	static public var DEFAULT_COLOR:Number = 0xFFFFFF ;
    	static public var ERROR_COLOR:Number = 0xEDCC81 ;
     	static public var INFO_COLOR:Number = 0xD2FAB8 ;
    	static public var FATAL_COLOR:Number = 0xFDD1B5 ;
    	static public var WARN_COLOR:Number = 0xFDFDB5 ;

    	static public var HOST:String = "localhost" ;
    	static public var PORT:Number = 4444 ;

	    
    	public var levelPolicy:Number ;

        /**
         * Returns 'true' if your application is connected with SOS Console.
         */	
    	public function get connected():Boolean 
    	{
		    return _xs.connected  ;
    	}

    	
    	// ----o Public Methods
    	
    	public function clear():void 
    	{
		    sendMessage( CLEAR ) ;
    	}

	    public function close():void 
	    {
		    _isConnected = false ;
    		_xs.close() ;
	    }

    	public function connect():void
    	{
		    if (_isConnected) close() ;
    		_xs.connect( HOST, PORT ) ;
	    }

    	public function exit():void
    	{
		    sendMessage( EXIT ) ;
    	}

	    public function identify():void
	    {
    		sendMessage("!SOS<identify/>") ;
	    }
        
        override public function internalLog( message:* , level:LogEventLevel ):void
	    {
        	sendLevelMessage( level, message ) ;
	    }


	    public function sendLevelMessage(level:LogEventLevel, message:String ):void 
	    {
	        
    		if (levelPolicy == SOSTarget.ENABLE) 
	    	{
		    	message = "!SOS<showMessage key='" + level.toString() + "'>" + message.toString() + "</showMessage>\n" ;
		    } 
    		
    		sendMessage(message) ;
    		
	    }

	    public function sendMessage(msg:String):void 
	    {
		    if (_isConnected) 
		    {
    			_xs..send(msg) ;
    		}
    		else 
    		{
	    		_queue.enqueue(msg) ;
		    }
    	}

    	public function setAppName(name:String):void 
    	{
		    sendMessage("!SOS<appName>" + name + "</appName>") ;
    	}
	
    	public function setAppColor(color:Number):void 
    	{
		    sendMessage("!SOS<appColor>" + color + "</appColor>") ;
    	}
	
    	public function setLevelColor( level:LogEventLevel, color:Number=NaN ):void 
    	{
		    if (!LogEventLevel.isValidLevel(level)) return ;
    		var msg:String = "!SOS<setKey>" ;
    		msg += "<name>" + level.toString() + "</name>" ;
    		msg += "<color>"+ ( isNaN(color) ? SOSTarget[level.toString()+"_COLOR"] : color ) + "</color>" ;
    		msg += "</setKey>\n" ;
    		sendMessage(msg) ;
    	}

    	// ----o Protected Methods
    	
    	protected function flush():void
    	{
    		if ( _queue.size() > 0 ) 
    		{
    			var it:Iterator = _queue.iterator() ;
    			while (it.hasNext()) 
    			{
        			_xs.send( it.next() ) ;
    			}
    		}
    	}


    	// ----o Private Properties
    	
    	private var _color:Number ;
    	private var _isConnected:Boolean ;
    	private var _queue:LinearQueue ;
    	private var _xs:XMLSocket ;
    	
    	// ----o Private Methods

    	private function _onClose( e:Event ):void
    	{
    	
    	    trace("> " + this + ", close socket connection : " + e ) ;
    	
    	}
    	
    	private function _onConnect( e:Event ):void 
    	{
    	    trace("> " + this + ", connect socket connection : " + e ) ;
   			flush() ;
    	}
    	
    	private function _onIOError ( e:IOErrorEvent ):void 
    	{
            trace("> " + this + ", io error socket connection : " + e);
        }

        private function _onSecurityError ( e:SecurityErrorEvent ):void 
        {
            trace("> " + this + ", security error socket connection : " + e);
        }

    }
}