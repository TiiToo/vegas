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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package vegas.logging
{
    import system.Equatable;
    import system.Serializable;
    import system.hack;

    /**
     * Static class containing constants for use in the level  property.
     */
    public class LogEventLevel implements Equatable, Serializable
    {
        use namespace hack ;
        
        /**
         * Creates a new LogEventLevel instance.
         */
        public function LogEventLevel( name:String, value:int ) 
        {
            _name = name ;
            _value = value ;
        }

        /**
         * Intended to force a target to process all messages (0).
         */
        public static const ALL:LogEventLevel = new LogEventLevel("ALL", 0) ;

        /**
         * Designates informational level messages that are fine grained and most helpful when debugging an application (2).
         */
        public static const DEBUG:LogEventLevel = new LogEventLevel("DEBUG", 2) ;

        /**
         * Designates error events that might still allow the application to continue running (8).
         */    
        public static const ERROR:LogEventLevel = new LogEventLevel("ERROR", 8) ;

        /**
         * Designates events that are very harmful and will eventually lead to application failure (1000).
         */
        public static const FATAL:LogEventLevel = new LogEventLevel("FATAL", 1000) ;

        /**
         * Designates informational messages that highlight the progress of the application at coarse-grained level (4).
         */
        public static const INFO:LogEventLevel = new LogEventLevel("INFO", 4) ;    

        /**
         * Designates events that could be harmful to the application operation (6).
         */    
        public static const WARN:LogEventLevel = new LogEventLevel("WARN", 6) ;
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o == this )
            {
                return true ;
            }
            else if ( o is LogEventLevel )
            {
                return ( (o as LogEventLevel)._name == _name) && ( (o as LogEventLevel)._value == _value) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the number level passed in argument is valid.
         * @return <code class="prettyprint">true</code> if the number level passed in argument is valid.
         */
        public static function isValidLevel( level:LogEventLevel ):Boolean 
        {
            var levels:Array = [ ALL, DEBUG, ERROR, FATAL, INFO, WARN ] ;
            var l:int = levels.length ;
            while (--l > -1)
            {
                if ( level.equals( levels[l] ) ) 
                {
                    return true ;
                }
            }  
            return false ;
        }
        
        /**
         * Returns the Eden string representation of the object.
         */    
        public function toSource( indent:int = 0 ):String  
        { 
            return 'new vegas.logging.LogEventLevel("' + this._name + '",' + this._value + ')' ;
        }

        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */    
        public function toString():String 
        { 
            return _name ; 
        }
        
        /**
         * Returns the primitive value of this object.
         * @return the primitive value of this object.
         */
        public function valueOf():int
        {
            return _value ;
        }
        
        /**
         * @private
         */
        hack var _name:String ;
        
        /**
         * @private
         */
        hack var _value:int ;
    }
}