/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

/**
 * All loggers within the logging framework must implement this interface. 
 */
if ( system.logging.Logger == undefined ) 
{
    /**
     * @requires system.signals.Signal
     */
    require( "system.signals.Signal" ) ;
    
    /**
     * Creates a new Logger instance.
     */
    system.logging.Logger = function () 
    {
        //
    }
    
    /**
     * @extends system.signals.Signal
     */
    proto = system.logging.Logger.extend( system.signals.Signal ) ;
    
    /**
     * Indicates the channel value for the logger.
     */
    proto.channel = null ;
    
    /**
     * Logs the specified data using the LogEventLevel.DEBUG level.
     */
    proto.debug = function ( context ) /*void*/ 
    {
        // 
    }
    
    /**
     * Logs the specified data using the LogEventLevel.ERROR level.
     */
    proto.error = function ( context ) /*void*/ 
    {
        // 
    }
    
    /**
     * Logs the specified data using the LogEventLevel.FATAL level.
     */
    proto.fatal = function ( context ) /*void*/ 
    {
        // 
    }
    
    /**
     * Logs the specified data using the LogEvent.INFO level.
     */
    proto.info = function ( context ) /*void*/ 
    {
        // 
    }
    
    /**
     * Logs the specified data using the LogEvent.ALL level.
     * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
     * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
     */
    proto.log = function ( context ) /*void*/ 
    {
        // 
    }
    
    /**
     * Logs the specified data using the LogEventLevel.WARN level.
     */
    proto.warn = function ( context ) /*void*/ 
    {
        // 
    }
    
    /**
     * What a Terrible Failure: Report an exception that should never happen.
     */
    proto.wtf = function ( context ) /*void*/ 
    {
        // 
    }
}