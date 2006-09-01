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

/** XPanelTarget

	AUTHOR
	
		Name : XPanelTarget
		Package : vegas.logging.targets
		Version : 1.0.0.0
		Date :  2006-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

// FIXME : bug au premier build de l'application. Si la console XPanel vient de s'ouvrir il faut relancer le build une seconde fois !

package vegas.logging.targets
{

    import flash.events.AsyncErrorEvent;    
   	import flash.events.StatusEvent;
	import flash.events.SecurityErrorEvent;
    import flash.net.LocalConnection ;

    import vegas.logging.LogEventLevel;


    public class XPanelTarget extends LineFormattedTarget
    {
        
        // ----o Constructor
        
        public function XPanelTarget( name:String="unknow" )
        {
            super();
            
            _lc = new LocalConnection() ;
    	    _lc.addEventListener ( AsyncErrorEvent.ASYNC_ERROR, _onAsyncError ) ;
    	    _lc.addEventListener ( StatusEvent.STATUS, _onStatus ) ;
    		_lc.addEventListener ( SecurityErrorEvent.SECURITY_ERROR , _onSecurityError ) ;    			
            
           // _lc.connect( CONNECTION_ID ) ;
            
            _lc.send ( 
		        CONNECTION_ID ,
    		    DISPATCH_MESSAGE , 
    		    new Date().valueOf() ,
    		    START + " " + name ,
    		    LEVEL_START
	    	);

        }

        // ----o Constants
        
        static public const CONNECTION_ID:String = "_xpanel1" ;
        static public const DISPATCH_MESSAGE:String = "dispatchMessage" ;
        static public const START:String = "Started" ;
        
        static public const LEVEL_DEBUG       : uint = 0x0001 ;
		static public const LEVEL_INFORMATION : uint = 0x0002 ;
		static public const LEVEL_WARNING     : uint = 0x0004 ;
		static public const LEVEL_ERROR       : uint = 0x0008 ;
		static public const LEVEL_FATAL       : uint = 0x0010 ;
		static public const LEVEL_START       : uint = 0x0100 ;

		static public const LEVEL_NONE        : Number = 0xFF ;
		static public const LEVEL_ALL         : Number = 0x00 ;

        // ----o Public Properties
        
        public var name:String ;

        // ----o Public Methods
   	   	
   	   	/**
    	 * Descendants of this class should override this method to direct the specified message to the desired output.
    	 *
    	 * @param message String containing preprocessed log message which may include time, date, category, etc. 
    	 *        based on property settings, such as <code>includeDate</code>, <code>includeCategory</code>, etc.
	     */

	    override public function internalLog( message:* , level:LogEventLevel):void
	    {
	        
	        var targetLevel:int ;
	        
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
	    	
			_lc.send(
			    CONNECTION_ID , 
			    DISPATCH_MESSAGE , 
			    new Date().valueOf(), 
			    message, targetLevel
			) ;
	        
	    }
	    
        // ----o Protected Methods
        
        override protected function formatMessage(message:*, level:String, category:String, date:Date):String 
        {
	    	
	    	message = (typeof message == "xml") ? (message as XML).toXMLString() : message.toString();
	    	return super.formatMessage(message, level, category, date) ;
	    	
    	}
    	
    	private function _onAsyncError(e:AsyncErrorEvent):void
    	{
    	    trace( "> " + this + " : " + e ) ;
    	}
    	
    	private function _onStatus( e:StatusEvent ):void
		{
			trace( "> " + this + " : " + e ) ;
		}

		private function _onSecurityError( e:SecurityErrorEvent ):void
		{
		    
		    trace( "> " + this + " : " + e ) ;
		    
		}
		
		// ----o Private Properties
		
		private var _lc:LocalConnection ;
        
    }
}