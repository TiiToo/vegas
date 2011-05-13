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
package lunas.components.buttons 
{
    import graphics.transitions.TweenTo;
    
    import lunas.events.ButtonEvent;
    
    import vegas.colors.LightColor;
    
    /**
     * The builder of the LightButton component.
     */
    public class LightButtonBuilder extends CoreButtonBuilder
    {
        /**
         * Creates a new LightButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function LightButtonBuilder( target:LightButton )
        {
            super( target );
            light = new LightColor( target ) ; // default
        }
        
        /**
         * The light reference of this builder.
         */
        public var light:LightColor ;
        
        /**
         * Invoked when the button is down.
         */
        public function disabled( e:ButtonEvent = null ):void
        {
            if (_tw != null &&  _tw.running )
            {
                _tw.stop() ;
            }
            light.reset() ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public function down( e:ButtonEvent = null ):void
        {
            if ( _tw != null && _tw.running )
            {
                _tw.stop() ;
            }
            if ( light != null )
            {
                light.reset() ;
            }
            var s:LightButtonStyle = (target as LightButton).style as LightButtonStyle ;
            if ( s != null )
            {
                if ( s.tweenSelected != null )
                {
                    _tw        = s.tweenSelected.clone() ;
                    _tw.target = light ;
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
            registerType( ButtonEvent.UP       , up ) ;
        }
        
        /**
         * Invoked when the button is over.
         */
        public function over( e:ButtonEvent = null ):void
        {
            if ( _tw != null && _tw.running )
            {
                _tw.stop() ;
            }
            if ( light )
            {
                light.reset() ;
            }
            var s:LightButtonStyle = (target as LightButton).style as LightButtonStyle ;
            if ( s != null )
            {
                if ( s.tweenOver )
                {
                    _tw = s.tweenOver.clone() ;
                    _tw.target = light ;
                    _tw.run() ;
                }
            }
        }
        
        /**
         * Invoked when the button is over.
         */
        public function up( e:ButtonEvent = null ):void
        {
            
        }
        
        /**
         * @private
         */
        private var _tw:TweenTo ;
    }
}
