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

import vegas.events.Delegate;
import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.logging.LogEventLevel;
import vegas.logging.targets.TraceTarget;
import vegas.util.ConstructorUtil;

/**
 * Provides a logger target that uses the XPanel console to output log messages. 
 * Thanks Farata System and <a href='http://www.faratasystems.com/xpanel/readme.pdf'>XPanel</a> console.
 * <p><b>Example :</b></p>
 * <p>
 * {@code
 * import vegas.logging.* ;
 * import vegas.logging.targets.XPanelTarget ;
 * 
 * var target:XPanelTarget = new XPanelTarget("Test") ;
 * target.includeLines = true ;
 * target.includeLevel = true ;
 * target.filters = ["namespace.*"] ;
 * target.level = LogEventLevel.ALL ; // level filter !
 * 
 * // register target
 * Log.addTarget(target); 
 * 
 * // create a log writer
 * var logger:ILogger = Log.getLogger("namespace.myApplication") ;
 * 
 * logger.log(LogEventLevel.DEBUG, "here is some myDebug info : {0} and {1}", 2.25 , true) ;
 * logger.debug("DEBUG !!") ;
 * logger.error("ERROR !!") ;
 * logger.fatal("FATAL !!") ;
 * logger.info("INFO !!") ;
 * logger.warn("WARNING !!") ;
 * logger.warn([3, 2, 4]) ;
 * }
 * </p>
 * @author eKameleon
 */
class vegas.logging.targets.XPanelTarget extends TraceTarget {

    /**
     * Creates a new XPanelTarget instance.
     */ 
	public function XPanelTarget( name:String ) 
	{
		super();
		
		if (name == null)
		{
			name = "unknow" ;	
		}
		
		_logger = Log.getLogger( ConstructorUtil.getPath(this) ) ;
            
        _lc = new LocalConnection() ;
        _lc.onStatus = Delegate.create(this, _onStatus) ;
        _lc.send( CONNECTION_ID, DISPATCH_MESSAGE, (new Date()).valueOf(), START + " " + name, LEVEL_START );
		
	}

	/**
	 * The id of the LocalConnection.
	 */
    static public var CONNECTION_ID:String = "_xpanel1" ;
       
    /**
     * The dispatch message label.
     */
    static public var DISPATCH_MESSAGE:String = "dispatchMessage" ;

    /**
     * The 'all' level value of the XPanel console.
     */ 
	static public var LEVEL_ALL:Number = 0x00 ;
		
	/**
	 * The 'debug' level value of the XPanel console.
	 */ 
	static public var LEVEL_DEBUG:Number = 0x0001 ;

	/**
	 * The 'error' level value of the XPanel console.
	 */ 
	static public var LEVEL_ERROR:Number = 0x0008 ;

	/**
	 * The 'fatal' level value of the XPanel console.
	 */ 
	static public var LEVEL_FATAL:Number = 0x0010 ;

	/**
     * The 'information' level value of the XPanel console.
     */ 
	static public var LEVEL_INFORMATION:Number = 0x0002 ;

    /**
     * The 'none' level value of the XPanel console.
     */ 
	static public var LEVEL_NONE:Number = 0xFF ;

    /**
     * The 'start' level value of the XPanel console.
     */ 
	static public var LEVEL_START:Number = 0x0100 ;
	
    /**
     * The 'warning' level value of the XPanel console.
     */ 
	static public var LEVEL_WARNING:Number = 0x0004 ;

	/**
	 * The started value.
	 */
	static public var START:String = "Started" ;

    /**
	 * The name of the connection
	 */
    public var name:String ;

	/**
     * Descendants of this class should override this method to direct the specified message to the desired output.
     *
     * @param message String containing preprocessed log message which may include time, date, category, etc. 
     *        based on property settings, such as <code>includeDate</code>, <code>includeCategory</code>, etc.
	 */
	public function internalLog( message , level:LogEventLevel):Void
	{
	        
	        var targetLevel:Number ;
	        
	    	switch (level)
	    	{
	    		case LogEventLevel.DEBUG:
	    		{
	    			targetLevel = LEVEL_DEBUG;
	    			break;
	    		}
	    		case LogEventLevel.ERROR:
	    		{
	    			targetLevel = LEVEL_ERROR;
	    			break;
	    		}
	    		case LogEventLevel.FATAL:
	    		{
	    			targetLevel = LEVEL_FATAL;
	    			break;
	    		}
	    		case LogEventLevel.INFO:
	    		{
	    			targetLevel = LEVEL_INFORMATION;
	    			break;
	    		}
	    		case LogEventLevel.WARN:
	    		{
	    			targetLevel = LEVEL_WARNING;
	    			break;
	    		}
	    		default:
	    		{
	    			targetLevel = LEVEL_ALL;
	    			break;
	    		}
	    	}
	    	
			_lc.send( CONNECTION_ID , DISPATCH_MESSAGE , (new Date()).valueOf(), message, targetLevel ) ;
	        
	    }   

   	/**
   	 * Invoqued when the LocalConnection notify a status change.
   	 */
   	private function _onStatus( info ):Void
	{
		_logger.info( "> " + this + " onStatus : " + info.code ) ;
	}
		
	/**
	 * Internal LocalConnection reference.
	 */
	private var _lc:LocalConnection ;
       
    /**
	 * The internal logger of this instance.
	 */
	private var _logger:ILogger ;


}