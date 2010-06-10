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
 * Represents the log information for a single logging notification. 
 * The loging system dispatches a single message each time a process requests information be logged.
 * This entry can be captured by any object for storage or formatting.
 */
if ( system.logging.LoggerEntry == undefined ) 
{
    /**
     * Creates a new LoggerEntry.
     * @param message The context or message of the log.
     * @param level The level of the log.
     * @param logger The Logger reference of this entry.
     */
    system.logging.LoggerEntry = function ( message , level /*LoggerLevel*/ , channel /*String*/ ) 
    {
        this.channel = channel ;
        this.message = message ;
        this.level   = (level == null) ? system.logging.LoggerLevel.ALL : level ;
    }
    
    /**
     * @extends Object
     */
    proto = system.logging.LoggerEntry.extend( Object ) ;
    
    /**
     * Provides access to the channel for this log entry.
     */
    proto.channel /*String*/ = null ;
    
    /**
     * Provides access to the level for this log entry.
     */
    proto.level /*String*/ = null ;
    
    /**
     * Provides access to the message that was entry.
     */
    proto.message = null ;
    
    //////////////
    
    delete proto ;
}