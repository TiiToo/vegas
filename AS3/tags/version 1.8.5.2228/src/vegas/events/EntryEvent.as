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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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

package vegas.events 
{
    import core.reflect.getClassName;

    import system.data.Entry;
    import system.events.BasicEvent;

    import flash.events.Event;

    /**
     * A basic Entry event.
     */
    public class EntryEvent extends BasicEvent
    {
        /**
         * Creates a new EntryEvent instance.
         * @param type the string type of the instance.
         * @param entry Indicates the entry of this event.
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function EntryEvent( type:String , entry:Entry = null , target:Object = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:uint = 0)
        {
            super(type, target, context, bubbles, cancelable, time);
            _entry = entry ;
        }
        
        /**
         * Default event type when an entry is added in a model.
         */
        public static var ADD:String = "add" ;
        
        /**
         * Default event type notified before an entry is changed in a model.
         */
        public static var BEFORE_CHANGE:String = "beforeChange" ;
        
        /**
         * Default event type when all entries are removed in a model.
         */
        public static var CLEAR:String = "clear" ;
            
        /**
         * Default event type when an entry is changed/selected in a model.
         */
        public static var CHANGE:String = "change" ;
        
        /**
         * Default event type when an entry is removed in a model.
         */
        public static var REMOVE:String = "remove" ;
            
        /**
         * Default event type when an entry is updated in a model.
         */
        public static var UPDATE:String = "update" ;
        
        /**
         * Indicates the entry reference of this event.
         */
        public function get entry():Entry
        {
            return _entry ;
        }
        
        /**
         * @private 
         */
        public function set entry( e:Entry ):void
        {
        	_entry = e ;
        }
        
        /**
         * Indicates the key corresponding to this entry.
         */
        public function get key():*
        {
            return _entry.key ;
        }
        
        /**
         * Indicates the value corresponding to this entry.
         */
        public function get value():*
        {
            return _entry.value ;
        }
        
        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public override function clone():Event 
        {
            return new EntryEvent( type, _entry, target, context ) ;
        }
        
        /**
         * Returns the string representation of this event.
         * @return the string representation of this event.
         */
        public override function toString():String 
        {
            return formatToString( getClassName(this), "type", "entry", "target", "context", "bubbles", "cancelable", "eventPhase" ); 
        }
        
        /**
         * @private
         */
        private var _entry:Entry ;
    }
}
