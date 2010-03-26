/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is NinjAS Framework.
  
  The Initial Developer of the Original Code is 
  ALCARAZ Marc <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2009-2010
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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
*/

package lunas.components.labels 
{
    import graphics.geom.EdgeMetrics;
    
    import system.Strings;
    
    import vegas.models.PageByPageModel;
    import vegas.strings.HTMLFormatter;
    
    import flash.display.DisplayObject;
    import flash.events.TextEvent;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    
    /**
     * The builder of the PaginationLabelcomponent.
     */
    public class PaginationLabelBuilder extends LabelBuilder 
    {
        /**
         * Creates a new PaginationLabelBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function PaginationLabelBuilder( target:DisplayObject )
        {
            super( target ) ;
        }
        
        /**
         * Returns the formatted label of the component.
         * @return the formatted label of the component.
         */
        public function getFieldText():String
        {
            var b:PaginationLabel = target as PaginationLabel ;
            var p:PageByPageModel = b.pagination as PageByPageModel ;
            var pages:Array        = p.pages ; 
            if ( b && p && pages )
            {
                var o:Object = 
                { 
                    body     : "" ,
                    first    : "" ,
                    last     : "" , 
                    next     : "" , 
                    previous : "" , 
                    title    : b.title || ""
                } ;
                var c:uint                  = p.currentPage ;
                var s:PaginationLabelStyle  = b.style as PaginationLabelStyle ;
                if( c > 1 && b.firstLabel != null && b.firstLabel.length > 0 )
                {
                    o.first = Strings.format( s.firstPattern, 1 , b.firstLabel ) ; 
                }
                if( c > 1 && b.previousLabel != null && b.previousLabel.length > 0 )
                {
                    o.previous = Strings.format( s.previousPattern, p.currentPage - 1 , b.previousLabel ) ; 
                }
                o.body = "" ;
                var i:uint ;
                var size:uint  = pages.length ;
                var value:uint ; 
                for ( i = 0 ; i < size ; i++ )
                {
                    value = pages[i] ;
                    if ( value == c )
                    {
                        o.body += HTMLFormatter.span( value.toString() , s.currentStyleName ) ;
                    }
                    else
                    {
                        o.body += Strings.format( s.linkPattern , value, value ) ;
                    }
                    if ( i != (size-1) )
                    {
                        o.body += s.separator || "" ;
                    }
                }
                
                if( p.currentPage < p.totalPage  && b.nextLabel != null && b.nextLabel.length > 0 )
                {
                    o.next = Strings.format( s.nextPattern , p.currentPage + 1 , b.nextLabel ) ;
                }
                
                if( p.currentPage < p.totalPage && b.lastLabel != null && b.lastLabel.length > 0 )
                {
                    o.last = Strings.format( s.lastPattern, p.totalPage , b.lastLabel ) ; 
                }
                
                return HTMLFormatter.paragraph( Strings.format( s.pattern , o ) ) ;
            }
            else
            {
                return "" ;
            }
        }
        
        /**
         * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run.apply(this, arguments) ;
            field.mouseEnabled = true ;
            field.addEventListener( TextEvent.LINK , onLink ) ;
        }
         
        /**
         * Invoked when a link is selected in the field.
         */
        protected function onLink( e:TextEvent=null ):void 
        {
            (target as PaginationLabel).notifyChange( uint(e.text) as uint ) ;
        }
         
        /**
         * Returns the formatted label of the component.
         * @return the formatted label of the component.
         */
        protected override function refreshField():void
        {
            var b:Label      = target as Label ;
            var s:LabelStyle = b.style as LabelStyle ;
            
            var txt:String = getFieldText() ;
            
            field.border        = s.border ;
            field.borderColor   = s.borderColor ;
            field.antiAliasType = s.antiAliasType || AntiAliasType.NORMAL ;
            field.embedFonts    = s.embedFonts ;
            field.gridFitType   = s.gridFitType || GridFitType.NONE ;
            field.multiline     = s.multiline ;
            field.selectable    = s.selectable ;
            field.wordWrap      = s.wordWrap ;
            field.styleSheet    = s.styleSheet ;
            
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
                field.textColor = b.enabled ? s.color : s.textDisabledColor ;
            }
        }
        
        /**
         * Refresh the field layout.
         */
        protected override function refreshFieldLayout():void
        {
            var t:Label      = target as Label ;
            var s:LabelStyle = t.style as LabelStyle ;
            field.height = t.h - ( EdgeMetrics.filterNaNValue( s.padding.vertical ) ) ;
            field.width = t.w - field.x - ( EdgeMetrics.filterNaNValue(s.padding.horizontal) ) ;
            field.x = EdgeMetrics.filterNaNValue(s.padding.left) ;
            field.y = EdgeMetrics.filterNaNValue(s.padding.top) ; 
        }
    }
}
