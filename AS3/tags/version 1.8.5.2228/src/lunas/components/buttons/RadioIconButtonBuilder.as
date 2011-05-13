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
    import graphics.Direction;

    import lunas.components.labels.IconLabel;
    import lunas.containers.ListContainer;
    import lunas.events.ButtonEvent;

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.errors.IllegalOperationError;

    /**
     * The builder of the RadioIconButton component.
     */
    public class RadioIconButtonBuilder extends CoreButtonBuilder 
    {
        /**
         * Creates a new RadioIconButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function RadioIconButtonBuilder( target:DisplayObject )
        {
            super( target );
        }
        
        /**
         * The checkIcon reference.
         */
        public var checkIcon:MovieClip ;
        
        /**
         * The icon title component inside the component.
         */
        public var element:IconLabel ;
        
        /**
         * Attachs a linked MovieClip to create the check icon of the component.
         */
        public function attachCheckIcon( state:MovieClip ):void
        {
            _releaseCheckIcon() ;
            if ( container != null && state != null )
            {
                checkIcon = state ;
                container.addChildAt(checkIcon, 0) ;
                ( target as RadioIconButton ).update() ;
            }
            else
            {
                throw new IllegalOperationError(this + " failed with the component " + target + ", the internal container of the component don't exist.") ;    
            }
        }        
        
        /**
         * Release the container.
         */
        private function _releaseCheckIcon():void
        {
            if ( container != null && checkIcon != null  )
            {
                if ( container.contains( checkIcon ) )
                {
                    container.removeChild(checkIcon) ;
                }
                checkIcon = null ;
            }
        }        
        
          /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            if ( container != null )
            {
                if ( ( target as RadioIconButton ).contains( container ) )
                {
                    ( target as RadioIconButton ).removeChild(container) ;
                }
                container.clear() ;
                container = null ;
            }
            element   = null ;
            checkIcon = null ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public function disabled( e:ButtonEvent = null ):void
        {
            if ( checkIcon != null )
            {
                checkIcon.gotoAndStop( ButtonEvent.DISABLED ) ;
            }
        }
        
        /**
         * Invoked when the button is down.
         */
        public function down( e:ButtonEvent = null ):void
        {
            if ( checkIcon != null )
            {
                checkIcon.gotoAndStop( ButtonEvent.DOWN ) ;
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
            if ( checkIcon != null )
            {
                checkIcon.gotoAndStop( ButtonEvent.OVER ) ;
            }
        }
        
        /**
         * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            var b:RadioIconButton = target as RadioIconButton ;
            
            container           = new ListContainer() ;
            container.direction = Direction.HORIZONTAL ;
            
            b.addChild( container ) ;
            
            element = new IconLabel() ;
            container.addChild(element) ;
            container.mouseEnabled = false ;
            container.w = 0 ;
            container.h = 0 ;
        }
        
        /**
         * Invoked when the button is up.
         */
        public function up( e:ButtonEvent = null ):void 
        {
            if ( checkIcon != null )
            {
                checkIcon.gotoAndStop( ButtonEvent.UP ) ;
            }
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            var b:RadioIconButton      = target as RadioIconButton ;
            var s:RadioIconButtonStyle = b.style as RadioIconButtonStyle ;
            
            element.label = b.label ;
            element.icon  = b.icon  ;
            
            var w:Number = b.w ;
            var h:Number = b.h ;
            
            element.style = s ;
            element.setSize( w , h ) ;
            
            if ( checkIcon != null )
            {
                checkIcon.y = ( h - checkIcon.height) / 2 ;
            }
            
            container.space = isNaN(s.space) ? 0 : s.space ;
        }
        
        /**
         * The list container of the button.
         */
        protected var container:ListContainer ;
    }
}
