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
package lunas.components.labels 
{
    import core.html.span;
    import core.maths.replaceNaN;

    import lunas.CoreBuilder;

    import system.hack;

    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    /**
     * The builder of the Label component.
     */
    public class LabelBuilder extends CoreBuilder 
    {
        /**
         * Creates a new LabelBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function LabelBuilder( target:DisplayObject )
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
            var t:Label = (target as Label) ;
            if ( field )
            {
                if ( t.contains( field ) )
                {
                    t.removeChild( field ) ;
                }
                field = null ;
            }
        }
        
        /**
         * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            var t:Label  = (target as Label) ;
            field        = new TextField() ;
            field.mouseEnabled = false ;
            t.addChild( field ) ;
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            refreshField()  ;
            refreshFieldLayout() ;
        }
        
        /**
         * Refreshs the internal field.
         */
        protected function refreshField():void
        {
            var b:Label         = target as Label ;
            var s:LabelStyle    = b.style as LabelStyle ;
            
            var txt:String      = span( b.label || "", s.styleName ) ;
            
            field.antiAliasType = s.antiAliasType || AntiAliasType.NORMAL ;
            field.autoSize      = s.autoSize || TextFieldAutoSize.NONE ;
            field.border        = s.border ;
            field.borderColor   = s.borderColor ;
            field.embedFonts    = s.embedFonts ;
            field.gridFitType   = s.gridFitType || GridFitType.NONE ;
            field.multiline     = s.multiline ;
            field.selectable    = s.selectable ;
            field.wordWrap      = s.wordWrap ;
            field.styleSheet    = s.styleSheet ;
            
            if ( s.html )
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
                field.textColor = b.enabled ? s.color : s.textDisabledColor ;
            }
        }
        
        /**
         * Refresh the field layout.
         */
        protected function refreshFieldLayout():void
        {
            var b:Label      = target as Label ;
            var r:Rectangle  = b.hack::_real ;
            var s:LabelStyle = b.style as LabelStyle ;
            
            field.x      = r.x + replaceNaN( s.padding.left ) + replaceNaN( s.margin.left ) ;
            field.y      = r.y + replaceNaN( s.padding.top ) + replaceNaN( s.margin.top ) ; 
            field.width  = isNaN( s.width )  ? ( r.width  - replaceNaN( s.padding.horizontal ) - replaceNaN( s.margin.horizontal ) ) : s.width ;
            field.height = isNaN( s.height ) ? ( r.height - replaceNaN( s.padding.vertical ) - replaceNaN( s.margin.vertical ) ) : s.height  ;
        }
    }
}
