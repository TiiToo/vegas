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
package lunas.components.textinputs 
{
    import lunas.components.buttons.LightFrameLabelButton;
    import lunas.events.ButtonEvent;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    /**
     * This textinput contains a button to open a combo window or launch a command.
     */
    public class VisualComboTextInput extends VisualTextInput 
    {
        /**
         * Creates a new VisualComboTextInput instance.
         * @param skin Indicates the skin view of this visual textinput component.
         */
        public function VisualComboTextInput( skin:Sprite = null )
        {
            super( skin ) ;
        }
        
        /**
         * The combo button reference.
         */
        public var comboButton:LightFrameLabelButton ;
        
        /**
         * The internal background name of this TextInput.
         */
        public function get comboButtonName():String
        {
            return _comboButtonName ;
        }
        
        /**
         * @private
         */
        public function set comboButtonName( name:String ):void
        {
            _comboButtonName = name ;
        }
        
        /**
         * Invoked when the style of the component is changed.
         */
        public override function getStyleRenderer():Class 
        {
            return VisualComboTextInputStyle ;
        }
        
        /**
         * Invoked when the combo is selected.
         */
        public function select( e:Event = null ):void
        {
            dispatchEvent( new ButtonEvent( ButtonEvent.SELECT ) ) ;
        }
        
        /**
         * @private
         */
        protected var _comboButtonName:String = "comboButton" ;
        
        /**
         * Invoked to resolve the content of the skin.
         */
        protected override function resolveSkin():void
        {
            lock() ;
            super.resolveSkin() ;
            unlock() ;
            if ( _skin != null )
            {
                if ( comboButton != null )
                {
                    removeChild( comboButton ) ;
                }
                comboButton = ( comboButtonName in _skin ) ? new LightFrameLabelButton( _skin[comboButtonName] ) : null ;
                if ( comboButton != null )
                {
                    comboButton.addEventListener( MouseEvent.CLICK , select ) ;
                    addChild( comboButton ) ;
                }
            } 
            update() ;
        }
    }
}
