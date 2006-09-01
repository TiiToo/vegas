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

/** LogEvent

	AUTHOR
	
		Name :LogEvent
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2006-08-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/

package vegas.logging
{
    import flash.events.Event;

    public class LogEvent extends Event
    {
        
        // ----o Constructor
        
        public function LogEvent(context:* , level:LogEventLevel )
        {
            super(LogEvent.LOG, false, false);
            this.message = context ;
            this.level = (level == null) ? LogEventLevel.ALL : level ;
            
        }
        
        // ----o Constants
        
        /**
         * Event type constant, identifies a logging event.
         */
        public static const LOG:String = "log";

        // ----o Public Properties

        /**
         * Provides access to the level for this log event.
         */
        public var level:LogEventLevel ;
        
        /**
         * Provides access to the message that was logged.
         */
        public var message:* ;

        // ----o Public Methods

        override public function clone():Event
        {
            return new LogEvent(message, level);
        }

        public static function getLevelString( value:LogEventLevel ):String
        {
           
           if (LogEventLevel.isValidLevel(value))
           {
                return value.toString() ;   
           }
           else
           {
            
                return "UNKNOWN" ;  
               
           }
           return "UNKNOWN";
		}

		
    }
        
}