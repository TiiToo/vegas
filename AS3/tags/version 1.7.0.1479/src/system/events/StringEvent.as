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

package system.events 
{
    import flash.events.Event;
    
    /**
     * The <code class="prettyprint">StringEvent</code> to dispatch an event who contains a specific Number context.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.StringEvent ;
     * var e:StringEvent = new StringEvent("change", "hello world") ;
     * trace( e.string ) ; // hello world
     * </pre>
     */
    public class StringEvent extends BasicEvent 
    {
        /**
         * Creates a new <code class="prettyprint">StringEvent</code> instance.
         * @param type the string type of the instance. 
         * ﻿@param str the String value of this event.
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function StringEvent( type:String , str:String = null , target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super(type, target, context, bubbles, cancelable, time) ;
            _s = str ;
        }
        
        /**
         * Returns the shallow copy of this event.
         * @return the shallow copy of this event.
         */
        public override function clone():Event 
        {
            return new StringEvent( type, string, target, context) ;
        }
        
        /**
         * Determinates the String value of this custom event.
         */
        public function get string():String
        {
            return _s ;
        }
        
        /**
         * @private
         */
        public function set string( str:String ):void
        {
            _s = str ;
        }
        
        /**
         * @private
         */
        private var _s:String ;
    }
}
