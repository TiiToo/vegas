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
import vegas.events.Delegate;
import vegas.logging.LogEventLevel;
import vegas.logging.targets.LineFormattedTarget;
import vegas.util.ConstructorUtil;

/**
 * @author eKameleon
 */
class vegas.logging.targets.AirLoggerTarget extends LineFormattedTarget 
{

	/**
	 * Creates a new AirLoggerTarget instance.
	 */
	public function AirLoggerTarget( name:String , autoClear:Boolean )
	{
		
		_lcOut = new LocalConnection();
		_lcOut.onStatus = Delegate.create( this, _onStatus) ;
           
        _lcIn = new LocalConnection();
		_lcIn.setID = Delegate.create( this , setID );
		_lcIn.allowDomain = function ( domain:String ) 
		{ 
			return true; 
		};
		
		_aLogStack   = [];
		_bIdentified = false;
		_bRequesting = false;
		
		if ( autoClear )
		{
			clear() ;	
		}
		
		if ( name != null )
		{
			setName( name ) ;
		}
		
		connect();		

	}
	
	/**
	 * The id message to clear the console. 
	 */
	public static var CLEAR:String = "clear" ;
	
	/**
	 * Designates informational level messages that are fine grained and most helpful 
	 * when debugging an application with the AirLogger console (10000).
	 */
	public static var DEBUG:Number = 10000 ;
	
	/**
	 * The default id in value.
	 */
	public static var DEFAULT_ID_IN : String = "" ; 
	
	/**
	 * Designates error events that might still allow 
	 * the application to continue running with the AirLogger console (40000).
	 */	
	public static var ERROR:Number = 40000 ;

	/**
	 * Designates events that are very harmful and will eventually 
	 * lead to application failure with the AirLogger console (50000).
	 */
	public static var FATAL:Number = 50000 ;
	
	/**
	 * The id who indicates if the id is already used.
	 */
	public var ID_ALREADY_USED:String = "idAlreadyUsed" ;

	/**
	 * Designates informational messages that highlight the progress of the application 
	 * at coarse-grained level with the AirLogger console (20000).
	 */
	public static var INFO:Number = 20000 ;
	
	/**
	 * The 'out' connection suffix.
	 */
	public static var IN_SUFFIX:String = "_OUT";

	/**
	 * The local connection id.
	 */
	public static var LOCAL_CONNECTION_ID:String = "_AIRLOGGER_CONSOLE" ;

	/**
	 * The 'in' connection suffix.
	 */
	public static var OUT_SUFFIX:String = "_IN" ;

	/**
	 * The id who indicates if the tab name of the current application must change this name.
	 */
	public static var SET_TAB_NAME:String = "setTabName" ;

	/**
	 * Designates events that could be harmful to the application operation with the AirLogger console (30000).
	 */	
	public static var WARN:Number = 30000;

	
	/**
	 * Clear the console.
	 */
	public function clear() : Void
	{
		_send( getAirLoggerMessage( CLEAR ) ) ;
	}
	
	/**
	 * Close the connection with the console.
	 */	
	public function close() : Void
	{
		_lcIn.close() ;
	}
	
	/**
	 * Connect the target with the console.
	 */
	public  function connect():Void
	{
		while( !_lcIn.connect(_getInConnectionName( DEFAULT_ID_IN ) ) )
		{
			_lcOut.send( _getOutConnectionName() , "mainConnectionAlreadyUsed", DEFAULT_ID_IN ) ;
			DEFAULT_ID_IN += "_" ;
		}
	}
	
	/**
	 * Focus in the console.
	 */
	public function focus() : Void
	{
		_send( getAirLoggerMessage("focus") ) ;
	}
	
	/**
	 * Returns the generic object who contains all attributes who defines the AirLogger message to send.
	 */
	public function getAirLoggerMessage( type:String, message , level : Number, date : Date, sMessageType:String ):Object 
	{
		switch (level)
		{
			case LogEventLevel.ERROR :
			{
				level = ERROR ;
				break ;	
			}
			case LogEventLevel.FATAL :
			{
				level = FATAL ;
				break ;	
			}
			case LogEventLevel.INFO :
			{
				level = INFO ;
				break ;	
			}
			case LogEventLevel.WARN :
			{
				level = WARN ;
				break ;	
			}
			default :
			{
				level = DEBUG ;
				break ;	
			}		
		}
		return { type:type , message: message, level:level, date:date, messageType:sMessageType } ;
	}
	
	/**
     * Descendants of this class should override this method to direct the specified message to the desired output.
     * @param message String containing preprocessed log message which may include time, date, category, etc. based on property settings, such as <code>includeDate</code>, <code>includeCategory</code>, etc.
     * @param level the LogEventLevel of the message.
	 */
	public /*override*/ function internalLog( message , level:Number ):Void
	{
		_send( getAirLoggerMessage("log", message, level, new Date(), ConstructorUtil.getPath(message) ) ) ;
	}

	/**
	 * Indicates if the target is requesting.
	 */
	public function isRequesting () : Boolean
	{
		return _bRequesting ;
	}

	/**
	 * Indicates if the target is isIdentified.
	 */
	public function isIdentified () : Boolean
	{
		return _bIdentified ;
	}
	
	/**
	 * Launch the ping request process of the console with this target.
	 */
	public function pingRequest():Void
	{
		_lcOut.send( _getOutConnectionName() , "requestID", DEFAULT_ID_IN );
	}
	
	/**
	 * Sets the unique id of the target in the console.
	 */
	public function setID( id : String ) : Void
	{
		try 
		{
			
			_global.clearInterval(_nPingRequest) ; 
			
			_sID = id;
				
			_lcIn.close();
			_lcIn.connect( _getInConnectionName(_sID) ) ;
				
			_lcOut.send(_getOutConnectionName(), "confirmID", id, _sName);
			
			_bIdentified = true;
			_bRequesting = false;
				
			var l:Number = _aLogStack.length ;
			if( l > 0 )
			{
				for(var i : Number = 0;i < l; i++ )
				{
					_send(_aLogStack.shift());
				}
			}
			
		}
		catch ( e:Error ) 
		{
			_lcIn.connect( _getInConnectionName( DEFAULT_ID_IN ) ) ;
			_lcOut.send( _getOutConnectionName() , ID_ALREADY_USED, id) ;
		}
	}
	

	
	/**
	 * Sets the name of the target.
	 */
	public function setName( s:String ):Void
	{
		_sName = s;
		if( _bIdentified )
		{
			_lcOut.send( _getOutConnectionName( _sID ), "setTabName", _sName  );
		}
	}

	/**
	 * @private
	 */	
    private var _aLogStack:Array ;
	
	/**
	 * @private
	 */
    private var _bIdentified:Boolean ;
	
	/**
	 * @private
	 */
    private var _bRequesting:Boolean ;
	
	/**
	 * @private
	 */
	private var _lcIn:LocalConnection ;
	
	/**
	 * @private
	 */
	private var _lcOut:LocalConnection ;
	
	/**
	 * @private
	 */
    private var _nPingRequest:Number ;

	/**
	 * @private
	 */
	private var _sID:String ;	
		
	/**
	 * @private
	 */
    private var _sName:String ;
	
	/**
	 * Returns the name of the in local connection.
	 * @return the name of the in local connection.
	 */
	private function _getInConnectionName( id:String ):String
	{
		if (arguments.length == 0)
		{
			id = "" ;
		}
		return LOCAL_CONNECTION_ID + id + IN_SUFFIX ;
	}

	/**
	 * Returns the name of the out local connection.
	 * @return the name of the out local connection.
	 */
	private function _getOutConnectionName ( id:String ) : String
	{
		if (arguments.length == 0)
		{
			id = "" ;
		}
		return LOCAL_CONNECTION_ID + id + OUT_SUFFIX ;
	}
	
	/**
	 * Invoked when the status of the LocalConnection is changed.
	 */
	private function _onStatus( event ) : Void 
	{
		//	
	}
	
	/**
	 * Send the message to the console or bufferize the message if the console isn't connected.
	 */
	private function _send ( oMessage ):Void
	{
		if( _bIdentified )
		{
			_lcOut.send( _getOutConnectionName( _sID ), oMessage.type, oMessage );
		}
		else
		{
			_aLogStack.push( oMessage );
			
			if( !_bRequesting )
			{					
				pingRequest();
				_nPingRequest = _global.setInterval( pingRequest, 1000 );
				_bRequesting  = true ;
			}
			
		}
	}	
	
}
