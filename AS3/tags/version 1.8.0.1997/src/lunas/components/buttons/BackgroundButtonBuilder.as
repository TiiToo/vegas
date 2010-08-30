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
    import graphics.IFillStyle;
    import graphics.ILineStyle;
    import graphics.transitions.TweenLite;

    import lunas.events.ButtonEvent;

    import system.hack;

    import vegas.colors.LightColor;
    import vegas.display.Background;

    import flash.display.DisplayObject;

    /**
     * The builders of the BackgroundButton component.
     */
    public class BackgroundButtonBuilder extends CoreButtonBuilder 
    {
        /**
         * Creates a new BackgroundButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function BackgroundButtonBuilder( target:DisplayObject )
        {
            super( target );
        }
        
        /**
         * The background reference of the component.
         */
        public var background:Background ;
        
        /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            if ( background )
            {
                (target as BackgroundButton).removeChild( background ) ;
                background = null ;
            }
            if ( _lightTw )
            {
                _lightTw = null ;
            }
            if( _lightColor )
            {
                _lightColor = null ; 
            }
        }
        
        /**
         * Invoked when the button is down.
         */
        public function disabled( e:ButtonEvent = null ):void
        {
            var b:BackgroundButton      = target as BackgroundButton ;
            var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
            refreshBackground( s.themeDisabled ) ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public function down( e:ButtonEvent = null ):void
        {
            var b:BackgroundButton      = target as BackgroundButton ;
            var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
            refreshBackground( s.themeSelected ) ;
            _resetLightTween() ;
            if ( s.useLight && s.tweenSelected )
            {
                _lightTw        = s.tweenSelected.clone() ;
                _lightTw.target = _lightColor ;
                _lightTw.run() ;
            }
        }
        
        /**
         * Initialize all register type of this builder.
         */
        public override function initType():void
        {
            registerType( ButtonEvent.DISABLED , disabled ) ;
            registerType( ButtonEvent.DOWN     , down     ) ;
            registerType( ButtonEvent.OVER     , over     ) ;
            registerType( ButtonEvent.UP       , up       ) ;
        }
        
        /**
         * Invoked when the button is over.
         */
        public function over( e:ButtonEvent = null ):void 
        {
            var b:BackgroundButton      = target as BackgroundButton ;
            var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
            refreshBackground( s.themeRollOver, s.themeBorderRollOver ) ;
            _resetLightTween() ;
            if ( s.useLight && s.tweenOver )
            {
                _lightTw        = s.tweenOver.clone() ;
                _lightTw.target = _lightColor ;
                _lightTw.run() ;
            }
        }
        
        /**
         * Register the scope of the light effect of the component.
         */
        public function registerLight( target:DisplayObject ):void
        {
            _lightColor = new LightColor( target ) ;
        }
        
        /**
          * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
             background = new Background() ;
             registerLight( background ) ;
             (target as BackgroundButton).addChild( background ) ;
        }
        
        /**
         * Invoked when the button is up.
         */
        public function up( e:ButtonEvent = null ):void 
        {
            refreshBackground() ;
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            refreshBackground() ;
        }
        
        /**
         * Refresh the internal background.
         */
        protected function refreshBackground( theme:IFillStyle=null , themeBorder:ILineStyle=null ):void
        {
            var b:BackgroundButton      = target as BackgroundButton ;    
            var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
            if ( b  && s )
            {
                background.filters = s.themeFilters ;
                background.lock() ;
                background.align               = s.align ;
                background.line                = (themeBorder != null) ? themeBorder : ( b.enabled ? ( b.selected ? s.themeBorderSelected : s.themeBorder) : s.themeBorderDisabled ) ; 
                background.fill                = (theme != null) ? theme : ( b.enabled ? ( b.selected ? s.themeSelected : s.theme ) : s.themeDisabled ) ; 
                background.h                   = b.hack::_h ;                background.w                   = b.hack::_w ;                background.topLeftRadius       = s.topLeftRadius > 0 ? s.topLeftRadius : 0 ;                background.topRightRadius      = s.topRightRadius > 0 ? s.topRightRadius : 0 ;
                background.bottomLeftRadius    = s.bottomLeftRadius > 0 ? s.bottomLeftRadius : 0 ;
                background.bottomRightRadius   = s.bottomRightRadius > 0 ? s.bottomRightRadius : 0 ;
                background.gradientMatrix      = s.gradientMatrix ;
                background.gradientRotation    = s.gradientRotation ;
                background.gradientTranslation = s.gradientTranslation ;
                background.useGradientBox      = s.useGradientBox ;
                background.unlock() ;
                background.update() ;
            }
        }
        
        /**
         * @private
         */ 
        protected var _lightColor:LightColor ;
        
        /**
         * @private
         */
        protected var _lightTw:TweenLite ;
        
        /**
         * @private
         */
        protected function _resetLightTween():void
        {
            if( _lightTw && _lightTw.running )
            {
                _lightTw.stop() ;
                _lightTw = null ;
            }
        }
    }
}
