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
    import core.html.span;
    import core.maths.replaceNaN;

    import graphics.FillStyle;
    import graphics.LineStyle;

    import lunas.events.ButtonEvent;
    import lunas.logging.logger;

    import vegas.display.Background;
    import vegas.display.CoreLoader;

    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import flash.text.TextField;
    
    /**
     * The builder of the MediaButton component.
     */
    public class MediaButtonBuilder extends CoreButtonBuilder 
    {
        /**
         * Creates a new MediaButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function MediaButtonBuilder( target:* )
        {
            super( target );
        }
        
        /**
         * The field of the component.
         */
        public var field:TextField ;
        
        /**
         * The picture container reference of the component.
         */
        public var picture:DisplayObject ;
        
        /**
         * Attach a linked DisplayObject to create the icon of the component.
         */
        public function attach( state:DisplayObject ):void
        {
            _releaseContainer() ;
            picture = state ;
            ( target as MediaButton ).addChild( picture ) ;
            picture.mask = mask ;
            ( target as MediaButton ).update() ;
        }
        
         /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            super.clear() ; 
            var b:MediaButton = target as MediaButton ;    
            if ( picture != null && b.contains( picture) )
            {
                b.removeChild( picture ) ;
            }
            picture = null ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public function disabled( e:ButtonEvent = null ):void
        {
        //
        }
        
        /**
         * Invoked when the button is down.
         */
        public function down( e:ButtonEvent = null ):void
        {
            var b:MediaButton      = target as MediaButton ;    
            var s:MediaButtonStyle = b.style as MediaButtonStyle ;
            
            background.fill = s.themeOver ;
            background.line = s.themeBorderOver ;
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
         * Loads an external picture or swf in the component to create the icon.
         */
        public function load( request:URLRequest ):void
        {
            _releaseContainer() ;
            picture = new CoreLoader() ;
             (picture as CoreLoader).contentLoaderInfo.addEventListener( Event.INIT            , _initialize ) ;
             (picture as CoreLoader).contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR , _ioError    ) ;
            (picture as CoreLoader).load( request ) ;
        }
        
        /**
          * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run() ;
            
            var b:MediaButton = target as MediaButton ;
            
            field        = new TextField() ;
            background     = new Background( ) ;
            mask        = new Background( ) ;
            
            field.mouseEnabled = false ;
            mask.mouseEnabled  = false ;
            
            b.addChild( background ) ; 
            b.addChild( field ) ;
            b.addChild( mask ) ;
            
            update() ;
        }
        
        /**
         * Invoked when the button is over.
         */
        public function over( e:ButtonEvent = null ):void 
        {
            var b:MediaButton      = target as MediaButton ;    
            var s:MediaButtonStyle = b.style as MediaButtonStyle ;
            
            background.fill = s.themeOver ;
            background.line = s.themeBorderOver ;
        }
        
        /**
         * Invoked when the button is up.
         */
        public function up( e:ButtonEvent = null ):void 
        {
            var b:MediaButton      = target as MediaButton ;    
            var s:MediaButtonStyle = b.style as MediaButtonStyle ;
            
            background.fill = s.theme ;
            background.line = s.themeBorder ;
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            var t:MediaButton      = target as MediaButton ; 
            var s:MediaButtonStyle = t.style as MediaButtonStyle ;
            
            if ( picture != null )
            {
                var mr:Number = replaceNaN( s.margin.right ) ;
                picture.x   = mask.x - mr ;
                picture.y = ( background.height - picture.height ) / 2 ;
            }
            if (( background != null ) && ( s ))
            {
                background.w = 250 ;
                background.h =  57 ;
                
                background.bottomLeftRadius = background.bottomRightRadius = background.topLeftRadius = background.topRightRadius = 7 ;    
                background.fill = s.theme ;
                background.line = s.themeBorder ;
                
                background.update() ;
            }
            if (( mask != null ) && ( s ))
            {
                mask.w = 58 ;
                mask.h = 48 ;
                mask.x = 188 ;
                mask.y = 5 ;
                    
                mask.bottomLeftRadius = mask.bottomRightRadius = mask.topLeftRadius = mask.topRightRadius = 5 ;
                mask.fill = new FillStyle( 0xBCBDC1 , 1 ) ;
                mask.line = new LineStyle( 2, 0x666666 ) ;
                mask.update() ;
            }
            if ( s )
            {
                refreshField() ;
                refreshFieldLayout() ;
            }
        }
        
        /**
         * Refreshs the internal field.
         */
        protected function refreshField():void
        {
            var b:MediaButton      = target as MediaButton ;
            var s:MediaButtonStyle = b.style as MediaButtonStyle ;
            
            var txt:String = span( b.label || "", s.labelStyleName ) ;
            
            field.border        = s.border ;
            field.borderColor   = s.borderColor ;
            field.antiAliasType = s.antiAliasType || AntiAliasType.NORMAL ;
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
                field.textColor = b.enabled ? ( b.selected ? s.textSelectedColor : s.color ) : s.textDisabledColor ;
            }
        }
        
        /**
         * Refresh the field layout.
         */
        protected function refreshFieldLayout():void
        {
            var b:MediaButton      = target as MediaButton ;
            var s:MediaButtonStyle = b.style as MediaButtonStyle ;
             
            field.x = replaceNaN( s.margin.left ) ;
            field.y = replaceNaN( s.padding.top ) ; 
        }
        
        /**
         * The method invoked when the loading is finished and initialize.
         */
        private function _initialize( e:Event ):void
        {
            ( target as MediaButton ).addChild( picture ) ;
            picture.mask = mask ;
            update() ;
        }
        
        /**
         * Release the container.
         */
        private function _releaseContainer():void
        {
            if ( picture != null )
            {
                if ( picture is CoreLoader )
                {
                     (picture as CoreLoader).contentLoaderInfo.removeEventListener( Event.INIT            , _initialize ) ;
                     (picture as CoreLoader).contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR , _ioError    ) ;
                    if( (picture as CoreLoader).content != null )
                    {
                        (picture as CoreLoader).unload() ;
                    }
                }
                if ( ( target as MediaButton ).contains( picture ) )
                {
                    ( target as MediaButton ).removeChild( picture ) ;
                }
                picture = null ;
            }
        }
        
        /**
          * The method invoked when the loading is finished and initialize.
         */
        private function _ioError( e:Event ):void
        {
            logger.error( this + " ioError : " + e ) ;
        }
        
        /**
         * @private
         */
        private var background:Background ;
        
        /**
         * @private
         */
        private var mask:Background ;
    }
}
