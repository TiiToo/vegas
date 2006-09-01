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

/** LogLogger

	AUTHOR

		Name : LogLogger
		Package : vegas.logging
		Version : 1.0.0.0
		Date : 2006-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

package vegas.logging
{
    
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.events.IEventDispatcher;

    public class LogLogger extends EventDispatcher implements ILogger
    {
        
        // ----o Constructor
        
        public function LogLogger( category:String )
        {
            super() ;
            _category = category;
        }
        
        // ----o Public Properties
        
        public function get category():String
        {
            return _category ;
        }
        
        // ----o Public Methods
        
        public function debug(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.DEBUG, context].concat(rest) ) ;
        }
        
        public function error(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.ERROR, context].concat(rest) ) ;
        }

        public function fatal(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.FATAL, context].concat(rest) ) ;

        }

        public function info(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.INFO, context].concat(rest) ) ;
        }
        
        public function log(level:LogEventLevel, context:*, ...rest):void
        {
            
            if (level < LogEventLevel.DEBUG)
            {
        	    throw new ArgumentError("Level must be less than LogEventLevel.ALL.");
            }
            
           _log.apply( this, [level, context].concat(rest) ) ;
           
        }
        
        public function warn(context:*, ...rest):void
        {
            _log.apply( this, [LogEventLevel.WARN, context].concat(rest) ) ;
        }
        
        // ----o Private Properties
        
        private var _category:String ;
        
        // ----o Private Methods
        
        private function _log( level:LogEventLevel, context:*, ...rest ):void
        {
            
            if(hasEventListener(LogEvent.LOG))
		    {
			
			    if (context as String)
    			{
	    		    var len:uint = rest.length ;
		    	    for(var i:uint = 0; i<len ; i++)
    			    {
				       context = context.replace(new RegExp("\\{"+i+"\\}", "g"), rest[i]);
	    		    }
		    	}

    			dispatchEvent( new LogEvent( context, level ) ) ;
    			
            }
            
        }
        
    }

}