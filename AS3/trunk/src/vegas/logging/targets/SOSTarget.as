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
       
	/**
	 * Provides a logger target that uses the SOS console to output log messages. 
	 * Thanks PowerFlasher and the <a href='http://sos.powerflasher.de/english/english.html'>SOS Console</a>
	 * <p><b>Example :</b></p>
	 * <code>
	 * import vegas.logging.* ;
	 * import vegas.logging.targets.SOSTarget ;
	 *  
	 * import vegas.errors.* ;
	 * 
	 * // setup target
	 * var target:SOSTarget = new SOSTarget(0xD8F394) ;
	 * target.filters = ["monApplication", "vegas.errors.*"] ; // use a empty array to receive all logs.
	 * target.includeLines = true ;
	 * target.includeCategory = true ;
	 * target.includeDate = true ;
	 * target.includeTime = true ;
	 * target.includeLevel = true ;
	 * target.level = LogEventLevel.ALL ; 
	 * //target.setLevelColor(LogEventLevel.DEBUG, 0xFF0000) ;
	 * //target.levelPolicy = SOSType.DISABLE ; // SOSType.ENABLE default value
	 * target.sendFoldLevelMessage(LogEventLevel.DEBUG, "Init SOS console", "test a fold message") ;
	 * target.sendMessage("Init SOS console....") ;
	 * 
	 * // register target
	 * Log.addTarget(target); 
	 * 
	 * // create a log writer
	 * var logger:ILogger = Log.getLogger("monApplication") ;
	 * 
	 * logger.log(LogEventLevel.DEBUG, "here is some myDebug info : {0} and {1}", 2.25 , true) ;
	 * logger.debug("DEBUG !!") ;
	 * logger.error("ERROR !!") ;
	 * logger.fatal("FATAL !!") ;
	 * logger.info("INFO !!") ;
	 * logger.warn("WARNING !!") ;
	 * logger.warn([3, 2, 4]) ;
	 * throw new FatalError("a fatal error") ;
	 * </code>
	 * 
	 * @author eKameleon
	 */
    public class SOSTarget extends LineFormattedTarget
    {
        
		/**
		 * Creates a new SOSTarget instance.
		 */
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
        
		/**
		 * Provides the message to send in the SOS console to clear the console. 
		 */
    	static public const CLEAR:String = "!SOS<clear/>\n" ;

		/**
		 * Provides the value if you want 'disabled' the levels colors in the SOS Console.
		 */
		static public const DISABLE:Number = 0 ; // levelPolicy

		/**
		 * Provides the value if you want 'enabled' the levels colors in the SOS Console.
		 */
    	static public const ENABLE:Number = 1 ; // levelPolicy

		/**
		 * Provides the message to send in the SOS console to exit the console. 
		 */
    	static public const EXIT:String = "!SOS<exit/>" ;

		/**
		 * Provides the color in the SOS console to display all levels. 
		 */
        static public var ALL_COLOR:Number = 0xD7EEFD ;
        
		/**
		 * Provides the 'debug' color in the SOS console. 
		 */
		static public var DEBUG_COLOR:Number = 0xDEECFE ;
		
		/**
		 * Provides the 'default' color in the SOS console. 
		 */
    	static public var DEFAULT_COLOR:Number = 0xFFFFFF ;
    	
		/**
		 * Provides the 'error' color in the SOS console. 
		 */
    	static public var ERROR_COLOR:Number = 0xEDCC81 ;

	  	/**
		 * Provides the 'fatal' color in the SOS console. 
		 */
    	static public var FATAL_COLOR:Number = 0xFDD1B5 ;

		/**
		 * Provides the 'info' color in the SOS console. 
		 */
     	static public var INFO_COLOR:Number = 0xD2FAB8 ;

		/**
		 * Provides the default host in the SOS console to connect the internal XMLSocket. 
		 */
    	static public var HOST:String = "localhost" ;

		/**
		 * Provides the 'warn' color in the SOS console. 
		 */
    	static public var WARN_COLOR:Number = 0xFDFDB5 ;

		/**
		 * Provides the default port in the SOS console to connect the internal XMLSocket. 
		 */
    	static public var PORT:Number = 4444 ;

		/**
		 * Show the level colors. Use SOSType.ENABLE or SOSType.DISABLE
		 */	
    	public var levelPolicy:Number ;

        /**
         * Returns 'true' if your application is connected with SOS Console.
         */	
    	public function get connected():Boolean 
    	{
		    return _xs.connected  ;
    	}

		/**
		 * Clear the console.
		 */	
    	public function clear():void 
    	{
		    sendMessage( CLEAR ) ;
    	}

		/**
		 * Close the console socket connection.
		 */
	    public function close():void 
	    {
		    _isConnected = false ;
    		_xs.close() ;
	    }

		/**
		 * Connect to the SOS console. 
		 */
    	public function connect():void
    	{
		    if (_isConnected) close() ;
    		_xs.connect( HOST, PORT ) ;
	    }

		/**
		 * Exit and close the SOS console.
		 */
    	public function exit():void
    	{
		    sendMessage( EXIT ) ;
    	}

		/**
		 * Flush the target.
		 */
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

		/**
		 * Shows some Information about the Connection. This time it is : HostName, HostAddress and Color.
		 */
	    public function identify():void
	    {
    		sendMessage("!SOS<identify/>") ;
	    }
        
        override public function internalLog( message:* , level:LogEventLevel ):void
	    {
        	sendLevelMessage( level, message ) ;
	    }

		/**
		 * Send a message with a specific level.
		 */
	    public function sendLevelMessage(level:LogEventLevel, message:String ):void 
	    {
	        
    		if (levelPolicy == SOSTarget.ENABLE) 
	    	{
		    	message = "!SOS<showMessage key='" + level.toString() + "'>" + message.toString() + "</showMessage>\n" ;
		    } 
    		
    		sendMessage(message) ;
    		
	    }

		/**
		 * Send message or bufferize message if the SOS console is disconnected.
		 */
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

		/**
		 * Sets the name of the application.
		 */
    	public function setAppName(name:String):void 
    	{
		    sendMessage("!SOS<appName>" + name + "</appName>") ;
    	}

		/**
		 * Sets the color of the application, the Color must be set as Integer Value. So 16768477 equals 0xffdddd.
		 */
    	public function setAppColor(color:Number):void 
    	{
		    sendMessage("!SOS<appColor>" + color + "</appColor>") ;
    	}

		/**
		 * Sets the color for a specific level.
		 * @see LogEventLevel
		 */
    	public function setLevelColor( level:LogEventLevel, color:Number=NaN ):void 
    	{
		    if (!LogEventLevel.isValidLevel(level)) return ;
    		var msg:String = "!SOS<setKey>" ;
    		msg += "<name>" + level.toString() + "</name>" ;
    		msg += "<color>"+ ( isNaN(color) ? SOSTarget[level.toString()+"_COLOR"] : color ) + "</color>" ;
    		msg += "</setKey>\n" ;
    		sendMessage(msg) ;
    	}



		/**
		 * The internal color value.
		 */	
    	private var _color:Number ;

		/**
		 * The internal value to indicated if the target is connected.
		 */
    	private var _isConnected:Boolean ;

		/**
		 * The internal buffer.
		 */
    	private var _queue:LinearQueue ;
   
		/**
		 * The internal socket reference.
		 */
    	private var _xs:XMLSocket ;
    	
    	/**
    	 * Invoqued when the socket close the connection.
    	 */
    	private function _onClose( e:Event ):void
    	{
    	    trace("> " + this + ", close socket connection : " + e ) ;
    	}

    	/**
    	 * Invoqued when the socket is connected.
    	 */
    	private function _onConnect( e:Event ):void 
    	{
    	    trace("> " + this + ", connect socket connection : " + e ) ;
   			flush() ;
    	}

    	/**
    	 * Invoqued when the socket notify an IO error.
    	 */
    	private function _onIOError ( e:IOErrorEvent ):void 
    	{
            trace("> " + this + ", io error socket connection : " + e);
        }

    	/**
    	 * Invoqued when the socket notify a security error.
    	 */
        private function _onSecurityError ( e:SecurityErrorEvent ):void 
        {
            trace("> " + this + ", security error socket connection : " + e);
        }

    }
}