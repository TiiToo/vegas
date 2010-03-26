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
    import graphics.geom.EdgeMetrics;
    
    import lunas.events.ButtonEvent;
    
    import vegas.strings.HTMLFormatter;
    
    import flash.display.DisplayObject;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import flash.text.TextField;
    
    /**
     * The builder of the LabelButton component.
     */
    public class LabelButtonBuilder extends BackgroundButtonBuilder 
    {
        /**
         * Creates a new LabelButtonBuilder reference.
         * @param target the target of the component reference to build.
         */
        public function LabelButtonBuilder( target:DisplayObject )
        {
            super( target );
        }
        
        /**
         * The field reference of the component.
         */
        public var field:TextField ;
        
        /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            super.clear() ;
            var b:LabelButton = target as LabelButton ;
            if ( field != null && b.contains( field) )
            {
                b.removeChild( field ) ;
            }
            field = null ;
        }
        
        /**
         * Invoked when the button is disabled.
         */
        public override function disabled( e:ButtonEvent = null ):void
        {
            super.disabled( e ) ; 
            var b:LabelButton      = target as LabelButton ;    
            var s:LabelButtonStyle = b.style as LabelButtonStyle ;
            if ( s.useTextColor )
            {
                field.textColor = s.textDisabledColor ;
            }
        }
        
        /**
         * Invoked when the button is down.
         */
        public override function down( e:ButtonEvent = null ):void
        {
            super.down( e ) ; 
            var b:LabelButton      = target as LabelButton ;    
            var s:LabelButtonStyle = b.style as LabelButtonStyle ;
            if ( s.useTextColor )
            {
                field.textColor = s.textSelectedColor ;
            }
        }
        
        /**
         * Invoked when the button is over.
         */
        public override function over( e:ButtonEvent = null ):void 
        {
            super.over( e ) ;
            var b:LabelButton      = target as LabelButton ;    
            var s:LabelButtonStyle = b.style as LabelButtonStyle ;
            if ( s.useTextColor )
            {
                field.textColor = s.textRollOverColor ;
            }
        }
        
        /**
         * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run() ; 
            field = new TextField() ;
            field.mouseEnabled = false ;
            var b:BackgroundButton = target as BackgroundButton ;
            b.addChild( field ) ;
        }
         
        /**
         * Invoked when the button is up.
         */
        public override function up( e:ButtonEvent = null ):void 
        {
            super.up( e ) ;
            
            var b:LabelButton      = target as LabelButton ;    
            var s:LabelButtonStyle = b.style as LabelButtonStyle ;
            if ( s.useTextColor )
            {
                field.textColor = s.color ;
            }
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            super.update()  ;
            refreshField()  ;
            refreshFieldLayout() ;
        }
        
        /**
         * Refreshs the internal field.
         */
        protected function refreshField():void
        {
            var b:LabelButton      = target as LabelButton ;
            var s:LabelButtonStyle = b.style as LabelButtonStyle ;
            var txt:String         = HTMLFormatter.span( b.label || "", s.labelStyleName ) ;
            field.border           = s.border ;
            field.borderColor      = s.borderColor ;
            field.antiAliasType    = s.antiAliasType || AntiAliasType.NORMAL ;
            field.embedFonts       = s.embedFonts ;
            field.gridFitType      = s.gridFitType || GridFitType.NONE ;
            field.multiline        = s.multiline ;
            field.selectable       = s.selectable ;
            field.wordWrap         = s.wordWrap ;
            field.styleSheet       = s.styleSheet ;
            if (s.html)
            {
                field.htmlText = txt ;
            }
            else
            {    
                field.text = txt ;
            }
            field.visible = txt != null || txt.length > 0 ;
            if ( s.useTextColor )
            {
                field.textColor = b.enabled ? ( b.selected ? s.textSelectedColor : s.color ) : s.textDisabledColor ;
            }
        }
        
        /**
         * Refresh the field layout.
         */
        protected function refreshFieldLayout():void
        {
            var b:LabelButton      = target as LabelButton ;
            var s:LabelButtonStyle = b.style as LabelButtonStyle ;
            var h:Number           = EdgeMetrics.filterNaNValue( s.padding.horizontal ) ;
            field.x                = EdgeMetrics.filterNaNValue( s.margin.left ) ;
            field.width            = b.w - field.x ;
            field.height           = b.h - h ;
            field.y                = EdgeMetrics.filterNaNValue( s.padding.top ) ; 
        }
    }
}
