﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
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

package system.logging.targets
{
    import system.events.LoggerEvent;
    import system.hack;
    import system.logging.LoggerLevel;
    
    /**
     * All logger target implementations that have a formatted line style output should extend this class. It provides default behavior for including date, time, channel, and level within the output.
     */
    public class LineFormattedTarget extends CoreLoggerTarget
    {
        use namespace hack ;
        
        /**
         * Creates a new LineFormattedTarget instance.
         */
        public function LineFormattedTarget()
        {
            super();
        }
        
        /**
         * Indicates if the channel for this target should added to the trace.
         */
        public var includeChannel:Boolean ;
        
        /**
         * Indicates if the date should be added to the trace.
         */
        public var includeDate:Boolean ;
        
        /**
         * Indicates if the level for the event should added to the trace.
         */
        public var includeLevel:Boolean ;
        
        /**
         * Indicates if the line for the event should added to the trace.
         */
        public var includeLines:Boolean ;
        
        /**
         * Indicates if the milliseconds should be added to the trace. Only relevant when includeTime is <code class="prettyprint">true</code>.
         */
        public var includeMilliseconds:Boolean ;
        
        /**
         * Indicates if the time should be added to the trace.
         */
        public var includeTime:Boolean ;
        
        /**
         * The separator string.
         */
        public var separator:String = " " ;
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, channel, etc. 
         * based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeChannel</code>, etc.
         */
        public function internalLog( message:* , level:LoggerLevel ):void
        {
            // override this method.
        }
        
        /**
         *  This method handles a <code class="prettyprint">LoggerEvent</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the target's level.
         */
        public override function logEvent( event:LoggerEvent ):void
        {
            var message:*      = event.message ;
            var level:String   = LoggerEvent.getLevelString( event.level ) ;
            var channel:String = event.currentTarget.channel ;
            message            = formatMessage( message, level, channel , new Date() ) ;
            internalLog( message , event.level ) ;
        }
        
        /**
         * Resets the internal line number value (set to 1).
         */
        public function resetLineNumber():void 
        {
            _lineNumber = 1 ; 
        }
        
        /**
         * This method format the passed Date in arguments.
         */
        hack function formatDate( d:Date ):String 
        {
            var date:String = "" ;
            date += getDigit(d.getDate()) ;
            date += "/" + getDigit(d.getMonth() + 1) ;
            date += "/" + d.getFullYear();
            return date ;
        }
        
        /**
         * This method format the passed level in arguments.
         */
        hack function formatLevel(level:String):String 
        {
            return '[' + level + ']' ;
        }
        
        /**
         * This method format the current line value.
         */
        hack function formatLines():String 
        {
            return "[" + _lineNumber++ + "]" ; 
        }
        
        /**
         * This method format the log message.
         */
        hack function formatMessage( message:* , level:String , channel:String , date:Date ):String 
        {
            var msg:String = "" ;
            var d:Date = date || new Date ;
            if (includeLines) 
            {
                msg += formatLines() + separator ;
            }
            if (includeDate) 
            {
                msg += formatDate(d) + separator ;
            }
            if (includeTime) 
            {
                msg += formatTime(d) + separator ;
            }
            if (includeLevel)
            {
                msg += formatLevel(level || "" ) + separator ;
            } 
            if ( includeChannel ) 
            {
                msg += ( channel || "" ) + separator ;
            }
            msg += message.toString() ;
            return msg ;
        }
        
        /**
         * This method format the current Date passed in argument.
         */
        hack function formatTime( d:Date ):String 
        {
            var time:String = "" ;
            time += getDigit(d.getHours()) ;
            time += ":" + getDigit(d.getMinutes()) ;
            time += ":" + getDigit(d.getSeconds()) ;
            if( includeMilliseconds ) 
            {
                time += ":" + getDigit( d.getMilliseconds() ) ;
            }
            return time ;
        }
        
        /**
         * Returns the string representation of a number and use digit conversion.
         * @return the string representation of a number and use digit conversion.
         */
        hack function getDigit(n:Number):String 
        {
            if ( isNaN(n) ) 
            {
                return "00" ;
            }
            return ((n < 10) ? "0" : "") + n ;
        }
        
        /**
         * @private
         */
        private var _lineNumber:uint = 1 ;
    }
}