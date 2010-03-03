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
    import graphics.transitions.Motion;
    import graphics.transitions.Tween;

    import lunas.events.ButtonEvent;

    import vegas.colors.LightColor;

    import flash.display.DisplayObject;

    /**
     * The builder of the LightFrameLabelButton component.
     */
    public class LightFrameLabelButtonBuilder extends FrameLabelButtonBuilder
    {
        /**
         * Creates a new LightFrameLabelButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function LightFrameLabelButtonBuilder( target:DisplayObject )
        {
            super( target );
            _light = new LightColor( target ) ;
            _tw    = new Tween(_light) ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public function disabled( e:ButtonEvent ):void
        {
            if ( _tw.running )
            {
                _tw.stop() ;
            }
            _light.reset() ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public function down( e:ButtonEvent ):void
        {
            if ( _tw.running )
            {
                _tw.stop() ;
            }
            _style = (target as LightFrameLabelButton).style as LightFrameLabelButtonStyle ;
            if ( _style != null )
            {
                if ( _style.tweenSelected )
                {
                    _tw        = _style.tweenSelected.clone() ;
                    _tw.target = _light ;
                    _tw.run() ;
                }
            }
        }
        
        /**
         * Initialize all register type of this builder.
         */
        public override function initType():void
        {
            registerType( ButtonEvent.DISABLED , disabled ) ;
            registerType( ButtonEvent.DOWN     , down ) ;
            registerType( ButtonEvent.OVER     , over ) ;
            registerType( ButtonEvent.UP              ) ;
        }
        
        /**
         * Invoked when the button is over.
         */
        public function over( e:ButtonEvent ):void
        {
            if ( _tw.running )
            {
                _tw.stop() ;
            }
            _style = (target as LightFrameLabelButton).style as LightFrameLabelButtonStyle ;
            if ( _style != null )
            {
                if ( _style.tweenOver )
                {
                    _tw = _style.tweenOver.clone() ;
                    _tw.target = _light ;
                    _tw.run() ;
                }
            }
        }
        
        /**
         * @private
         */
        private var _light:LightColor ;
        
        /**
         * @private
         */
        private var _style:LightFrameLabelButtonStyle ;
        
        /**
         * @private
         */
        private var _tw:Motion ;
    }
}
