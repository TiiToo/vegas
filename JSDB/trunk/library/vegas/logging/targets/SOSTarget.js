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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Provides a logger target that uses the SOS console to output log messages. 
 * Thanks PowerFlasher and the <a href='http://sos.powerflasher.de/english/english.html'>SOS Console</a>
 * <code>
 * Log = vegas.logging.Log ;
 * LogEventLevel = vegas.logging.LogEventLevel ;
 * SOSTarget = vegas.logging.targets.SOSTarget ;
 * 
 * // setup writer
 * var sosTarget = new SOSTarget( 0xEEF5FF ) ;
 * sosTarget.filters = ["vegas.logging.*", "vegas.errors.*"] ;
 * 
 * sosTarget.includeDate = true ;
 * sosTarget.includeTime = true ;
 * sosTarget.includeLevel = true ;
 * sosTarget.includeCategory = true ;
 * sosTarget.includeLines = true ;
 * 
 * sosTarget.level = LogEventLevel.ALL ;
 * 
 * sosTarget.sendFoldLevelMessage( LogEventLevel.INFO , "Test SOSTarget with FMS", "We can use the SOS console with FMS and the vegas.logging.* package." )
 * 
 * // start writing log data
 * Log.addTarget( sosTarget ) ;
 * 
 * // get a logger for the 'myDebug' category
 * // and send some data to it.
 * 
 * var logger = Log.getLogger("vegas.logging.targets") ;
 * logger.log(LogEventLevel.DEBUG, "here is some myDebug info : {0} and {1}", 2.25 , true) ;
 * 
 * sosTarget.includeDate = false ;
 * sosTarget.includeTime = false ;
 * sosTarget.includeCategory = false ;
 * 
 * logger.debug( "debug message" ) ;
 * logger.info( "info message" ) ;
 * logger.warn( "warn message" ) ;
 * logger.error( "error message" ) ;
 * logger.fatal( "fatal message" ) ;
 * 
 * try
 * {
 *     throw new vegas.errors.FatalError("A fatal error") ;
 * }
 * catch(e)
 * {
 *     e.toString() ;
 * }
 * 
 * </code>
 * @author eKameleon
 * @version 1.0.0.0
 */
if (vegas.logging.targets.SOSTarget == undefined) 
{

	/**
	 * @requires vegas.logging.targets.SOSType
	 */
	require("vegas.logging.targets.SOSType") ;
	
	/**
	 * Creates a new SOSTarget instance.
	 */
	vegas.logging.targets.SOSTarget = function ( color /*Number*/ ) 
	{ 
		
		vegas.logging.AbstractTarget.call(this) ; // super
		
		// Init Buffer queue object
		
		this._queue = new vegas.data.queue.LinearQueue() ;
		
		// Init Application Color
		
		this.setAppColor( isNaN(color) ? vegas.logging.targets.SOSType.DEFAULT_COLOR : color ) ;
		
		// Init XMLSocket object
		
		this._xs = new XMLSocket() ;
		this._xs.onConnect = vegas.events.Delegate.create(this, this._connect) ;
		
		// Init Colors
		
		this.setLevelColor( vegas.logging.LogEventLevel.ALL ) ;
		this.setLevelColor( vegas.logging.LogEventLevel.DEBUG ) ;
		this.setLevelColor( vegas.logging.LogEventLevel.ERROR ) ;
		this.setLevelColor( vegas.logging.LogEventLevel.FATAL ) ;
		this.setLevelColor( vegas.logging.LogEventLevel.INFO ) ;
		this.setLevelColor( vegas.logging.LogEventLevel.WARN ) ;
		
		this.levelPolicy = vegas.logging.targets.SOSType.ENABLE ;
		
		// Connect Console
		
		this.connect() ;
		
	}

	/** 
	 * @extends vegas.logging.targets.LineFormattedTarget
	 */
	proto = vegas.logging.targets.SOSTarget.extend( vegas.logging.targets.LineFormattedTarget ) ;
	
	/**
	 * Show the level colors. Use SOSType.ENABLE or SOSType.DISABLE
	 */	
	proto.levelPolicy /*Number*/ = null ;
	
	/**
	 * Clear the console.
	 */	
	proto.clear = function ()/*Void*/ 
	{
		this.sendMessage( vegas.logging.targets.SOSType.CLEAR ) ;
	}

	/**
	 * Close the console socket connection.
	 */
	proto.close = function () /*Void*/ 
	{
		this._isConnected = false ;
		this._xs.close() ;
	}

	/**
	 * Connect to the SOS console. 
	 */
	proto.connect = function () 
	{
		if ( this._isConnected ) 
		{
			this.close() ;
		}
		this._xs.connect( vegas.logging.targets.SOSType.HOST, vegas.logging.targets.SOSType.PORT ) ;
	}

	/**
	 * Exit and close the SOS console.
	 */
	proto.exit = function ()/*Void*/ 
	{
		this.sendMessage(vegas.logging.targets.SOSType.EXIT) ;
	}


	/**
	 * Returns the string socket representation to send a fold message in the SOSConsole.
	 * @return the string socket representation to send a fold message in the SOSConsole.
	 */
	proto.getFoldMessage = function( title /*String*/ , message /*String*/, level /*Number*/ ) /*String*/
	{
		var msg /*String*/ = "";
		var levelName /*String*/ = vegas.logging.LogEvent.getLevelString(level) ;
		msg += '!SOS<showFoldMessage key="' + levelName + '">';
		msg += '<title>' + title + '</title>';
		msg += '<message><![CDATA[' + message + ']]></message>' ;
		msg += '</showFoldMessage>' ;
		return msg ;	
	} 

	/**
	 * Shows some Information about the Connection. This time it is : HostName, HostAddress and Color.
	 */
	proto.getIdentify = function ()/*Void*/ 
	{
		this.sendMessage("!SOS<identify/>") ;
	}

	/**
	 * Returns {@code true} if the socket is connected with the console.
	 * @return {@code true} if the socket is connected with the console.
	 */
	proto.getIsConnected = function () /*Boolean*/ 
	{
		return this._isConnected ;
	}

	/**
	 * (read-only) Returns {@code true} if the socket is connected with the console.
	 * @return {@code true} if the socket is connected with the console.
	 */
	proto.__defineGetter__( "isConnected", proto.getIsConnected ) ;

	/**
	 * Returns the string socket representation to send a simple message in the SOSConsole.
	 * @return the string socket representation to send a simple message in the SOSConsole.
	 */
	proto.getMessage = function( message /*String*/ , level /*Number*/ ) /*String*/
	{
		var levelName /*String*/ = vegas.logging.LogEvent.getLevelString( level ) ;
		return  "!SOS<showMessage key='" + levelName + "'>" + message + "</showMessage>\n"  ;	
	}

	/**
	 * This method handles a LogEvent from an associated logger.
	 */
	/*override*/ proto.internalLog = function ( message , level /*Number*/ ) 
	{
		this.sendLevelMessage( level , message ) ;
	}

	/**
	 * Send a fold message with a specific level.
	 */
	proto.sendFoldLevelMessage = function ( level /*Number*/ , title /*String*/ , message /*String*/ ) /*void*/
	{
		if ( this.levelPolicy == vegas.logging.targets.SOSType.ENABLE ) 
		{
			message = this.getFoldMessage( title, message, level ) ;
		}
		this.sendMessage( message ) ;
	}

	/**
	 * Send a message with a specific level.
	 */
	proto.sendLevelMessage = function (level/*Number*/, message /*String*/)/*Void*/ 
	{
		if ( this.levelPolicy == vegas.logging.targets.SOSType.ENABLE ) 
		{
			message = this.getMessage(message, level) ;
		}
		this.sendMessage(message) ;
	}

	/**
	 * Send message or bufferize message if the SOS console is disconnected.
	 */
	proto.sendMessage = function (msg /*String*/)/*Void*/ 
	{
		if (this._isConnected) 
		{
			this._xs.send(msg) ;
		}
		else 
		{
			this._queue.enqueue(msg) ;
		}
	}

	/**
	 * Sets the name of the application.
	 */
	proto.setAppName = function (name /*String*/)/*Void*/ 
	{
		this.sendMessage("!SOS<appName>" + name + "</appName>") ;
	}
	
	/**
	 * Sets the color of the application, the Color must be set as Integer Value. So 16768477 equals 0xffdddd.
	 */
	proto.setAppColor = function (color /*Number*/ )/*Void*/ 
	{
		this.sendMessage("!SOS<appColor>" + color + "</appColor>") ;
	}

	/**
	 * Sets the color for a specific level.
	 * @see LogEventLevel
	 */
	proto.setLevelColor = function (level/*LogEventLevel*/, color/*Number*/) /*Void*/ 
	{
		if ( ! vegas.logging.LogEventLevel.isValidLevel(level) )
		{
			return ;
		}
		var levelName /*String*/ = vegas.logging.LogEvent.getLevelString( level ) ;
		var msg /*String*/ = "!SOS<setKey>" ;
		msg += "<name>" + levelName + "</name>" ;
		msg += "<color>"+ (color || vegas.logging.targets.SOSType[ levelName + "_COLOR" ]) + "</color>" ;
		msg += "</setKey>\n" ;
		this.sendMessage(msg) ;
	}

	/**
	 * The internal color value.
	 */	
	proto._color /*Number*/ ;

	/**
	 * The internal buffer.
	 */
	proto._isConnected /*Boolean*/ = null ;

	/**
	 * The internal value to indicated if the target is connected.
	 */
	proto._queue /*LinearQueue*/ = null ;

	/**
	 * The internal socket reference.
	 */
	proto._xs /*XMLSocket*/ = null ;
	
	/**
	 * Invoqued if the xml socket try to connect the console.
	 */
	proto._connect = function (success /*Boolean*/ ) /*Void*/ 
	{
		if (success) 
		{
			this._flush() ;
			this._isConnected = true ;
		}
		else 
		{
			throw new vegas.errors.Warning("SOSTarget failed the connection with the console, the socket connection is failed.") ;
		}
	}

	/**
	 * Flush the internal buffer.
	 */
	proto._flush = function() 
	{
		if (this._queue.size() > 0) {
			var it /*Iterator*/ = this._queue.iterator() ;
			while (it.hasNext()) 
			{
				this._xs.send( it.next() ) ;
			}
		}
	}
	
	delete proto ;

}