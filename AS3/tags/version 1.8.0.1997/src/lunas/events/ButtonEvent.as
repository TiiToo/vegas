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
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    /**
     * Invoked in the buttons or thumbs.
     */
    public class ButtonEvent extends ComponentEvent 
    {
        /**
         * Creates a new ButtonEvent instance.
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function ButtonEvent(type:String, target:Object = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0)
        {
            super( type, target, context, bubbles, cancelable, time );
        }
        
        /**
         * Defines the value of the type property of a click event object.
         * @eventType click
         */
        public static var CLICK:String = MouseEvent.CLICK ;
        
        /**
         * Defines the value of the type property of deselect event object.
         * @eventType deselect
         */
        public static var DESELECT:String = "deselect" ;
        
        /**
         * Defines the value of the type property of a disabled component.
         * @eventType disabled
         */
        public static var DISABLED:String = "disabled" ;
        
        /**
         * Defines the value of the type property of a doubleClick event object.
         * @eventType doubleClick
         */
        public static var DOUBLE_CLICK:String = MouseEvent.DOUBLE_CLICK ;
        
        /**
         * Defines the value of the type property of a down event object.
         * @eventType down
         */
        public static var DOWN:String = "down" ;
        
        /**
         * Defines the value of the type property of a drag event object.
         * @eventType drag
         */
        public static var DRAG:String = "drag" ;
        
        /**
         * Defines the value of the type property of a mouseDown event object.
         * @eventType mouseDown
         */
        public static var MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN ;
        
        /**
         * Defines the value of the type property of a mouseMove event object.
         * @eventType mouseMove
         */
        public static var MOUSE_MOVE:String = MouseEvent.MOUSE_MOVE ;
        
        /**
         * Defines the value of the type property of a mouseOut event object.
         * @eventType mouseOut
         */
        public static var MOUSE_OUT:String = MouseEvent.MOUSE_OUT ;
            
        /**
         * Defines the value of the type property of a mouseOver event object.
         * @eventType mouseOver
         */
        public static var MOUSE_OVER:String = MouseEvent.MOUSE_OVER ;
        
        /**
         * Defines the value of the type property of a mouseUp event object.
         * @eventType mouseUp
         */
        public static var MOUSE_UP:String = MouseEvent.MOUSE_UP ;
            
        /**
         * Defines the value of the type property of an out event object.
         * @eventType out
         */
        public static var OUT:String = "out" ;
        
        /**
         * Defines the value of the type property of an out selected event object.
         * @eventType outSelected
         */
        public static var OUT_SELECTED:String = "outSelected" ;
        
        /**
         * Defines the value of the type property of an over event object.
         * @eventType over
         */
        public static var OVER:String = "over" ;
        
        /**
         * Defines the value of the type property of a over selected event object.
         * @eventType overSelected
         */
        public static var OVER_SELECTED:String = "overSelected" ;
        
        /**
         * Defines the value of the type property of a press event object.
         * @eventType press
         */ 
        public static var PRESS:String = "press" ;
        
        /**
         * Defines the value of the type property of a release event object.
         * @eventType release
         */ 
        public static var RELEASE:String = "release" ;
        
        /**
         * Defines the value of the type property of a releaseOutside event object.
         * @eventType releaseOutside
         */ 
        public static var RELEASE_OUTSIDE:String = "releaseOutside" ;
        
        /**
         * Defines the value of the type property of a rollOut event object.
         * @eventType rollOut
         */
        public static var ROLL_OUT:String = MouseEvent.ROLL_OUT ;
        
        /**
         * Defines the value of the type property of a rollOver event object.
         * @eventType rollOver
         */
        public static var ROLL_OVER:String = MouseEvent.ROLL_OVER ;
        
        /**
         * Defines the value of the type property of a select event object.
         * @eventType select
         */
        public static var SELECT:String = "select" ;
        
        /**
         * Defines the value of the type property of a start drag event object.
         * @eventType startDrag
         */
        public static var START_DRAG:String = "startDrag" ;
        
        /**
         * Defines the value of the type property of a stop drag event object.
         * @eventType stopDrag
         */
        public static var STOP_DRAG:String = "stopDrag" ;
        
        /**
         * Defines the value of the type property of an unselect event object.
         * @eventType unSelect
         */
        public static var UNSELECT:String = "unselect" ;
        
        /**
         * Defines the value of the type property of an 'up' event object.
         * @eventType up
         */
        public static var UP:String = "up" ;
        
        /**
         * Returns the shallow copy of this event.
         * @return the shallow copy of this event.
         */
        public override function clone():Event 
        {
            return new ButtonEvent( type, target, context ) ;
        }
    }
}
