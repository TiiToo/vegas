/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
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
package lunas.events 
{
    import system.events.BasicEvent;
    
    import flash.events.Event;
    
    /**
     * The event invoked in the components.
     */
    public class ComponentEvent extends BasicEvent 
    {
        /**
         * Creates a new ComponentEvent instance.
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function ComponentEvent(type:String, target:Object = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0)
        {
            super( type, target, context, bubbles, cancelable, time );
        }
        
        /**
         * Defines the value of the type property of a 'change' event object.
         * @eventType change
         */
        public static var CHANGE:String = Event.CHANGE ;
        
        /**
         * Defines the value of the type property of a 'clear' event object.
         * @eventType clear
         */
        public static var CLEAR:String = "clear" ;
        
        /**
         * Defines the value of the type property of an 'enabled' component.
         * @eventType enabled
         */
        public static var ENABLED:String = "enabled" ;
        
        /**
         * Defines the value of the type property of an 'enter' component.
         * @eventType enter
         */
        public static var ENTER:String = "enter" ;
        
        /**
         * Defines the value of the type property of an 'hide' component.
         * @eventType hide
         */
        public static var HIDE:String = "hide" ;
        
        /**
         * Defines the value of the type property of an icon change event object.
         * @eventType iconChange
         */
        public static var ICON_CHANGE:String = "iconChange" ;
        
        /**
         * Defines the value of the type property of a label change event object.
         * @eventType labelChange
         */
        public static var LABEL_CHANGE:String = "labelChange" ;
        
        /**
         * Defines the value of the type property of an 'move' component.
         * @eventType move
         */
        public static var MOVE:String = "move" ;
        
        /**
         * Defines the value of the type property of a 'progress' event object.
         * @eventType progress
         */
        public static var PROGRESS:String = "progress" ;
        
        /**
         * Defines the value of the type property of an 'resize' component.
         * @eventType resize
         */
        public static var RESIZE:String = "resize" ;
        
        /**
         * Defines the value of the type property of an 'scroll' component.
         * @eventType scroll
         */
        public static var SCROLL:String = Event.SCROLL ;
        
        /**
         * Defines the value of the type property of an 'show' component.
         * @eventType show
         */
        public static var SHOW:String = "show" ;
        
        /**
         * Returns the shallow copy of this event.
         * @return the shallow copy of this event.
         */
        public override function clone():Event 
        {
            return new ComponentEvent( type, target, context ) ;
        }
    }
}
