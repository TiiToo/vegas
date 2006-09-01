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


/** ILogger

	AUTHOR

		Name : ILogger
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2006-08-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

package vegas.logging
{
    
    import flash.events.IEventDispatcher;

    public interface ILogger extends IEventDispatcher
    {
     
        // ----o Public Properties
        
        /**
	     * The category value for the logger.
    	 *
	     * @return String containing the category for this logger.
         */
    	function get category():String ;
     
        // ----o Public Methods
     
        /**
         * Logs the specified data using the LogEventLevel.DEBUG level. 
         */
     	function debug( context:* , ...rest:Array ):void ;

        /**
         * Logs the specified data using the LogEventLevel.ERROR level.. 
         */
    	function error( context:* , ...rest:Array ):void ;
        	
        /**
         * Logs the specified data using the LogEventLevel.FATAL level.
         */
	    function fatal( context:* , ...rest:Array ):void ;

        /**
         * Logs the specified data using the LogEvent.INFO level.
         */
        function info( context:* , ...rest:Array ):void ;

        /**
         * Logs the specified data at the given level.
         */
        function log( level:LogEventLevel,  context:* , ...rest:Array ):void ;

        /**
         * Logs the specified data using the LogEventLevel.WARN level.
         */
    	function warn( context:* , ...rest:Array ):void ;
        
    }
}