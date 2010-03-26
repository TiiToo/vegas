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
    import graphics.display.DisplayObjectContainers;
    import graphics.display.ReflectionBitmapData;
    
    import lunas.containers.ScrollContainer;
    import lunas.events.ButtonEvent;
    
    import system.events.ActionEvent;
    
    import vegas.strings.HTMLFormatter;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    /**
     * The builder of the DashboardButton component.
     */
    public class DashboardButtonBuilder extends PictureButtonBuilder 
    {
        /**
         * Creates a new DashboardButtonBuilder reference.
         * @param target the target of the component reference to build.
         */
        public function DashboardButtonBuilder( target:DisplayObject )
        {
            super( target ) ;
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
            if ( bitmap )
            {
                if ( bitmap.bitmapData )
                {
                    bitmap.bitmapData.dispose() ;
                }
                bitmap = null ;
            }
            var scope:DashboardButton = target as DashboardButton ;
            if ( scope )
            {
                DisplayObjectContainers.clear( scope ) ;
            }
            if ( fieldContainer )
            {
                DisplayObjectContainers.clear( fieldContainer ) ;
                fieldContainer = null ;
            }
            field1 = null ;
            field2 = null ; 
        }
        
        /**
         * Invoked when the component is disabled.
         */
        public override function disabled( e:ButtonEvent = null ):void 
        {
            super.disabled() ;
            var d:DashboardButton = target as DashboardButton ;
            var s:DashboardButtonStyle = d.style as DashboardButtonStyle ;
            
            if ( s.useTextColor )
            {
                field1.textColor = s.textDisabledColor ;
                field2.textColor = s.textDisabledColor ;
            }
            
            picture.y = 0 ;
            fieldContainer.speedScroll( 0 ) ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public override function down( e:ButtonEvent = null ):void 
        {
            super.down() ;
            var d:DashboardButton = target as DashboardButton ;
            var s:DashboardButtonStyle = d.style as DashboardButtonStyle ;
            if ( s.useTextColor )
            {
                field1.textColor = s.color ;
                field2.textColor = s.textSelectedColor ;
            }
        }
        
        /**
         * Invoked when the button is over.
         */
        public override function over( e:ButtonEvent = null ):void 
        {
            super.over() ;
            var d:DashboardButton = target as DashboardButton ;
            var s:DashboardButtonStyle = d.style as DashboardButtonStyle ;
            if(( field1 != null )&&( field2 != null ))
            {
                if (s.useTextColor )
                {
                    field1.textColor = s.color ;
                    field2.textColor = s.textRollOverColor ;
                }
            }
            
            if (( d.label != null ) && ( d.label.length > 0  ))
            {
                fieldContainer.scroll++ ;
            }
            else
            {
                fieldContainer.scroll-- ;
            }
        }
        
        /**
         * Run the view initialize of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run() ;
            
            var d:DashboardButton = target as DashboardButton ;
            
            d.registerView( background ) ;
            
            bitmap = new Bitmap() ;
            bitmap.smoothing  = true ;
            
            fieldContainer = new ScrollContainer() ;
            field1 = new TextField() ;
            field2 = new TextField() ;
            
            fieldContainer.direction     = Direction.VERTICAL ;
            fieldContainer.childCount    = 1  ;
            fieldContainer.space         = 10 ;
            
            fieldContainer.mouseEnabled  = false ;
            fieldContainer.mouseChildren = false ;
            
            field1.autoSize = TextFieldAutoSize.LEFT ;
            field2.autoSize = TextFieldAutoSize.LEFT ;
            
            fieldContainer.addChild( field1 ) ;
            fieldContainer.addChild( field2 ) ;
        }
        
        /**
         * Invoked when the button is up.
         */
        public override function up( e:ButtonEvent = null ):void 
        {
            super.up() ;
            
            var d:DashboardButton = target as DashboardButton ;
            var s:DashboardButtonStyle = d.style as DashboardButtonStyle ;
            
            if (s.useTextColor )
            {
                field1.textColor = s.color ;
                field2.textColor = s.textRollOverColor ;
            }
            
            if (( d.label != null ) && ( d.label.length > 0  ))
            {
                fieldContainer.scroll-- ;
            }
            else
            {
                fieldContainer.scroll++ ;
            }
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void
        {
            super.update() ;
            var t:DashboardButton = target as DashboardButton ;
            if ( t == null )
            {
                return ;
                
            }
            var s:DashboardButtonStyle = t.style as DashboardButtonStyle ;
            if ( s == null )
            {
                return ;
            }
            
            var txt1:String = HTMLFormatter.paragraph( t.label || "", s.labelStyleName) ;
            
            var txt2:String = t.selectLabel ;
            if (txt2 == null)
            {
                txt2 = t.label || "" ;
            }
               txt2 = ( txt2 != null ) ? HTMLFormatter.paragraph( txt2 , s.labelStyleName ) : txt1 ;
            
            refreshField( field1 , txt1, 0 ) ;
            refreshField( field2 , txt2 , - field1.height ) ;
            
            if ( s.useTextColor )
            {
                field1.textColor = s.color ;
                field2.textColor = s.textRollOverColor ;
            }
            
            refreshContainers() ;
            
            if ( current && t.contains( current ) )
            {
                t.removeChild(current) ;
            }
            
            current = s.reflection ? bitmap : fieldContainer ;
            
            if( current )
            {
                t.addChild( current ) ; 
            }
            
            if ( s.reflection )
            {
                fieldContainer.addEventListener( ActionEvent.FINISH , scrollFinish  ) ;
                fieldContainer.addEventListener( ActionEvent.START  , scrollStart   ) ;
            }
            else
            {
                fieldContainer.removeEventListener( ActionEvent.FINISH , scrollFinish  ) ;
                fieldContainer.removeEventListener( ActionEvent.START  , scrollStart   ) ;
            }
        }
        
        /**
         * @private
         */
        protected var bitmap:Bitmap ;
        
        /**
         * @private
         */
        protected var current:DisplayObject ;
        
        /**
         * @private
         */
        protected function refreshContainers():void
        {
            var d:DashboardButton = target as DashboardButton ;
            var s:DashboardButtonStyle = d.style as DashboardButtonStyle ;
            var p:Number = (s.padding as Number > 0) ? (s.padding as Number) : 0 ;
            
            fieldContainer.y = background.height + p ;
            fieldContainer.scrollDuration = s.scrollDuration ;
            fieldContainer.scrollEasing   = s.scrollEasing ;
            fieldContainer.update() ;
            if ( Math.max((field1.width > 0) ? field1.width : 0 , (field2.width > 0) ? field2.width : 0 ) > background.width ) 
            {
                background.x = ( Math.max((field1.width > 0) ? field1.width : 0 , (field2.width > 0) ? field2.width : 0 ) - background.width) / 2 ;
                fieldContainer.x = 0 ;
            }
            else
            {
                background.x = 0 ;
                fieldContainer.x = (background.width - fieldContainer.width) / 2 ;
            }
            
            field1.x = 0 ;
            field2.x = 0 ;
            
            if ( field1.width < field2.width )
            {
                field1.x = (field2.width - field1.width) / 2 ;
            }
            else  if ( field2.width < field1.width )
            {
                field2.x = (field1.width - field2.width) / 2 ;
            }
            if( bitmap && s.reflection )
            {
                bitmap.x = (picture.width - bitmap.width) / 2 ;
                bitmap.y = fieldContainer.y ;
                updateBitmap() ;
            }
        }
        
        /**
         * @private
         */
        protected function refreshField( field:TextField, txt:String, offsetY:Number ):void
        {
            var d:DashboardButton      = target as DashboardButton       ;
            var s:DashboardButtonStyle = d.style as DashboardButtonStyle ;
            
            field.antiAliasType = s.antiAliasType ;
            field.embedFonts    = s.embedFonts ;
            field.gridFitType   = s.gridFitType ;
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
            
            field.y = -1 ;
            if ( !isNaN(offsetY) )
            {
                field.y += offsetY ;
            }
        }
        
        /**
         * @private
         */
        protected function scrollFinish( e:Event = null ):void
        {
            fieldContainer.removeEventListener(Event.ENTER_FRAME, updateBitmap) ;
        }
        
        /**
         * @private
         */
        protected function scrollStart( e:Event = null ):void
        {
            fieldContainer.addEventListener(Event.ENTER_FRAME, updateBitmap) ;
        }
        
        /**
         * @private
         */
        protected function updateBitmap( e:Event = null ):void
        {
            if ( bitmap )
            {
                if ( bitmap.bitmapData )
                {
                    bitmap.bitmapData.dispose() ;
                }
                var bmp:BitmapData = new BitmapData(fieldContainer.width, fieldContainer.height/2, true, 0xFFFFFF) ;
                bmp.draw(fieldContainer) ;
                bitmap.smoothing  = true ;
                bitmap.bitmapData = new ReflectionBitmapData(bmp, 0.3) ;
                bmp.dispose() ;
            }
        }
    }
}
