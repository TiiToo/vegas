/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
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
package lunas.components.buttons 
{
    import lunas.Iconifiable;
    import lunas.components.labels.IconLabel;
    import lunas.events.ButtonEvent;
    import lunas.events.ComponentEvent;

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.net.URLRequest;

    /**
     * This button display is a radiobutton component (or checkbox) with an IconTitle inside.
     */
    public class RadioIconButton extends CoreButton implements Iconifiable
    {
        /**
         * Creates a new RadioIconButton instance.
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function RadioIconButton( id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( id, isFull , name ) ;
            setSize( 140 , 18 ) ;
        }
        
        /**
         * Determinates the check visual icon of the button. 
         * This property defines the link id in the library of the internal MovieClip who contains 4 labels "up", "over", "down", "disabled"
         */
        public function get checkIcon():MovieClip
        {
            return (builder as RadioIconButtonBuilder).checkIcon ;
        }
        
        /**
         * @private
         */
        public function set checkIcon( state:MovieClip ):void
        {
            (builder as RadioIconButtonBuilder).attachCheckIcon( state ) ;
        }
        
        /**
         * Determinates the icon of the button. 
         * This property defines the uri of the external bitmap or swf to load.
         */
        public function get icon():*
        {
            return _icon ;
        }
        
        /**
         * @private
         */
        public function set icon( value:* ):void
        {
            _icon = null ;
             if ( value != null && ( value is DisplayObject || value is URLRequest || value is String ) )
             {
                 _icon = value ;
             }
            viewIconChanged() ;
            dispatchEvent( new ButtonEvent( ComponentEvent.ICON_CHANGE ) ) ;
        }
        
        /** 
         * The internal title component of this component.
         */
        public var title:IconLabel ;
        
        /**
         * Returns the IBuilder constructor use to initialize this component.
         * @return the IBuilder constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return RadioIconButtonBuilder ;
        }
        
        /**
         * Returns the IStyle constructor use to initialize this component.
         * @return the IStyle constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return RadioIconButtonStyle ;
        }
        
        /**
         * Invoked when the icon property of the component change.
         */
        public function viewIconChanged():void 
        {
            update() ;
        }
        
        /**
         * Invoked when the label property of the component change.
         */
        public override function viewLabelChanged():void 
        {
            update() ;
        }
        
        /**
         * Invoked when the component IStyle changed.
         */
        public override function viewStyleChanged( e:Event=null ):void 
        {
            update() ;
        }
        
        /**
         * @private
         */
        private var _icon:* ;
    }
}
