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
    import lunas.Style;

    import system.events.BasicEvent;

    import flash.events.Event;

    /**
     * The <code class="prettyprint">StyleEvent</code> to dispatch an event with an <code class="prettyprint">IStyle</code> object.
     */
    public class StyleEvent extends BasicEvent 
    {
        /**
         * Creates a new StyleEvent instance.
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function StyleEvent( type:String, target:* = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0 )
        {
            super( type, target, context, bubbles, cancelable, time );
        }
        
        /**
         * The type event name of the StyleEvent when the style is changed in the component.
         */
        public static const STYLE_CHANGE:String = "styleChange" ;
        
        /**
         * The type event name of the StyleEvent when the styleSheet in the Style is changed.
          */
        public static const STYLE_SHEET_CHANGE:String = "styleSheetChange" ;
        
        /**
         * Returns the Style reference of this event.
         * @return the Style reference of this event.
         */
        public function get style():Style 
        {
            return target as Style ;
        }
        
        /**
         * Sets the Style reference of this event.
         */
        public function set style( style:Style ):void 
        {
            target = style ;
        }
        
        /**
         * Returns the shallow copy of this event.
         * @return the shallow copy of this event.
         */
        public override function clone():Event 
        {
            return new StyleEvent( type, style, context ) ;
        }
    }
}
