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
    import graphics.Direction;

    import lunas.containers.ScrollContainer;
    import lunas.events.ButtonEvent;

    import system.hack;

    import vegas.strings.HTMLFormatter;

    import flash.display.DisplayObject;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    /**
     * The builder of the SwitchLabelButton component.
     */
    public class SwitchLabelButtonBuilder extends BackgroundButtonBuilder 
    {
        /**
         * Creates a new SwitchLabelButtonBuilder reference.
         * @param target the target of the component reference to build.
         */
        public function SwitchLabelButtonBuilder( target:DisplayObject )
        {
            super( target );
        }
        
        /**
         * The field of the button when is up.
         */
        public var field1:TextField ;
            
        /**
         * The field of the button when is over or selected.
         */
        public var field2:TextField ;
            
        /**
         * The scroll container of this button.
         */
        public var fieldContainer:ScrollContainer ;
        
        /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            super.clear() ;
            var d:SwitchLabelButton = target as SwitchLabelButton ;
            if ( fieldContainer != null )
            {
                d.removeChild( fieldContainer ) ;
            }
        }
        
        /**
         * Invoked when the component is disabled.
         */
        public override function disabled( e:ButtonEvent = null ):void 
        {
            super.disabled() ;
            var b:SwitchLabelButton = target as SwitchLabelButton ;
            var s:SwitchLabelButtonStyle = b.style as SwitchLabelButtonStyle ;
            if ( s.useTextColor )
            {
                field1.textColor = s.textDisabledColor ;
                field2.textColor = s.textDisabledColor ;
            }
            fieldContainer.speedScroll( 0 ) ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public override function down( e:ButtonEvent = null ):void 
        {
            super.down() ;
            var b:SwitchLabelButton = target as SwitchLabelButton ;
            var s:SwitchLabelButtonStyle = b.style as SwitchLabelButtonStyle ;
            if ( s.useTextColor )
            {
                field1.textColor = s.textSelectedColor ;
                field2.textColor = s.textSelectedColor ;
            }
            if ( s.useSwitch )
            {
                if (( b.label != null ) && ( b.label.length > 0  ))
                {
                    fieldContainer.scroll++ ;
                }
                else
                {
                    fieldContainer.scroll-- ;
                }
            }
            else
            {
                fieldContainer.speedScroll( 0 ) ;
            }
        }
        
        /**
         * Invoked when the button is over.
         */
        public override function over( e:ButtonEvent = null ):void 
        {
            super.over() ;
            var b:SwitchLabelButton      = target as SwitchLabelButton ;
            var s:SwitchLabelButtonStyle = b.style as SwitchLabelButtonStyle ;
            if( field1 && field2 )
            {
                if ( s.useTextColor )
                {
                    field1.textColor = s.color ;
                    field2.textColor = s.textRollOverColor ;
                }
            }
            if ( s.useSwitch )
            {
                if (( b.label != null ) && ( b.label.length > 0  ))
                {
                    fieldContainer.scroll++ ;
                }
                else
                {
                    fieldContainer.scroll-- ;
                }
            }
            else
            {
                fieldContainer.speedScroll( 0 ) ;
            }
        }
        
        /**
         * Run the view initialize of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run() ;
            
            fieldContainer            = new ScrollContainer() ;
            fieldContainer.direction  = Direction.VERTICAL ;
            fieldContainer.childCount = 1  ;
            fieldContainer.space      = 10 ;
            
            fieldContainer.propWidth  = "width" ;
            fieldContainer.propHeight = "height" ;
            
            field1 = new TextField() ;
            field2 = new TextField() ;
            
            //field1.border = true ;
            //field2.border = true ;
            
            field1.autoSize = TextFieldAutoSize.LEFT ;
            field2.autoSize = TextFieldAutoSize.LEFT ;
            
            fieldContainer.addChild( field1 ) ;
            fieldContainer.addChild( field2 ) ;
            
            (target as SwitchLabelButton).addChild( fieldContainer ) ;
            
            registerLight( fieldContainer ) ;
        }
        
        /**
         * Invoked when the button is up.
         */
        public override function up( e:ButtonEvent = null ):void 
        {
            super.up() ;
            var d:SwitchLabelButton      = target as SwitchLabelButton ;
            var s:SwitchLabelButtonStyle = d.style as SwitchLabelButtonStyle ;
            if (s.useTextColor )
            {
                field1.textColor = s.color ;
                field2.textColor = s.textRollOverColor ;
            }
            
            if ( s.useSwitch )
            {
                if (( d.label != null ) && ( d.label.length > 0  ))
                {
                    fieldContainer.scroll-- ;
                }
                else
                {
                    fieldContainer.scroll++ ;
                }
            }
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void
        {
            var b:SwitchLabelButton = target as SwitchLabelButton ;
            var s:SwitchLabelButtonStyle = b.style as SwitchLabelButtonStyle ;
            
            var txt1:String = b.label || "" ;
            var txt2:String = ( b.selectLabel != null ) ? b.selectLabel : txt1 ;
            
            refreshField( field1 , HTMLFormatter.paragraph( txt1 , s.labelStyleName ) ) ;
            refreshField( field2 , HTMLFormatter.paragraph( txt2 , s.labelStyleName ) , - field1.height ) ;
            
            if ( s.useTextColor )
            {
                field1.textColor = b.selected ? s.textRollOverColor : s.color ;
                field2.textColor = s.textRollOverColor ;
            }
            
            refreshContainer() ;
            
            b.hack::_w = fieldContainer.width + s.padding.left + s.padding.right ;
            
            refreshBackground() ;
        }
        
        /**
         * @private
         */
        protected function refreshContainer():void
        {
            var d:SwitchLabelButton       = target as SwitchLabelButton ;
            var s:SwitchLabelButtonStyle  = d.style as SwitchLabelButtonStyle ;
            
            fieldContainer.update() ;
            
            fieldContainer.y              = s.padding.top ;
            fieldContainer.scrollDuration = s.scrollDuration ;
            fieldContainer.scrollEasing   = s.scrollEasing ;
            fieldContainer.x              = s.padding.left ;
            
            field1.x = 0 ;
            field2.x = 0 ;
            
            if ( field1.width < field2.width )
            {
                field1.x = (field2.width - field1.width) / 2 ;
            }
            else if ( field2.width < field1.width )
            {
                field2.x = (field1.width - field2.width) / 2 ;
            }
            
            //fieldContainer.w = Math.max( field1.width , field2.width ) ;
        }
        
        /**
         * @private
         */
        protected function refreshField( field:TextField, txt:String, offsetY:Number = 0 ):void
        {
            var d:SwitchLabelButton = target as SwitchLabelButton ;
            var s:SwitchLabelButtonStyle = d.style as SwitchLabelButtonStyle ;
            if ( field && s )
            {
                field.embedFonts    = s.embedFonts ;
                field.multiline     = s.multiline ;
                field.selectable    = s.selectable ;
                field.wordWrap      = s.wordWrap ;
                field.styleSheet    = s.styleSheet ;
                field.mouseEnabled  = false ;
                if ( s.html )
                {
                    field.htmlText = txt ;
                }
                else
                {    
                    field.text = txt ;
                }
                
                field.y = -1 ;
                if ( !isNaN(offsetY) )
                {
                    field.y += offsetY ;
                }
            }
        }
    }
}
