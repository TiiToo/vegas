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
    import graphics.ILineStyle;
    import graphics.display.DisplayObjectContainers;
    import graphics.drawing.RectanglePen;
    
    import lunas.events.ButtonEvent;
    import lunas.logging.logger;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.geom.Rectangle;
    import flash.net.URLRequest;

    /**
     * The builder of the PictureButton component.
     */
    public class PictureButtonBuilder extends BackgroundButtonBuilder 
    {
        /**
         * Creates a new PictureButtonBuilder reference.
         * @param target the target of the component reference to build.
         */
        public function PictureButtonBuilder( target:DisplayObject )
        {
            super( target ) ;
        }
        
        /**
         * The border reference of the component.
         */
        public var border:Shape ;
        
        /**
         * The picture container reference of the component.
         */
        public var picture:Loader ;
        
        /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            super.clear() ;
            if ( target )
            {
                DisplayObjectContainers.clear( target as DisplayObjectContainer ) ;
            }
            borderPen = null ;
            border    = null ;
            picture   = null ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public override function disabled( e:ButtonEvent = null ):void
        {
            super.disabled( e ) ; 
            refreshBorder( ( (target as BackgroundButton ).style as PictureButtonStyle ).themeBorderDisabled ) ;
        }
        
        /**
         * Invoked when the button is down.
         */
        public override function down( e:ButtonEvent = null ):void
        {
            super.over( e ) ; 
            refreshBorder( ( (target as BackgroundButton ).style as PictureButtonStyle ).themeBorderSelected ) ;
        }
        
        /**
         * Loads an external picture or swf in the component.
         */
        public function load( request:URLRequest ):void
        {
            ( target as BackgroundButton ).enabled = false ;
            picture.load( request ) ;
        }
        
        /**
         * Invoked when the button is over.
         */
        public override function over( e:ButtonEvent = null ):void 
        {
            super.over( e ) ;
            refreshBorder( ( (target as BackgroundButton ).style as PictureButtonStyle ).themeBorderRollOver ) ;
        }
        
        /**
          * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run() ;
            var b:PictureButton = target as PictureButton ;
             
            picture   = new Loader() ;
            border    = new Shape() ;
            borderPen = new RectanglePen( border ) ;
            
            picture.contentLoaderInfo.addEventListener( Event.INIT , initialize ) ;
            picture.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR , error ) ; 
            picture.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, error ) ;  
            
            b.addChild( picture ) ;
            b.addChild( border ) ;
             
            registerLight( picture ) ;
        }
        
        /**
         * Invoked when the button is up.
         */
        public override function up( e:ButtonEvent = null ):void 
        {
            super.up( e ) ;
            refreshBorder() ;
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            super.update() ;
            refreshPicture() ;
            refreshBorder() ;
        }
        
        /**
         * The internal pen to draw the border of the button.
         * @private
         */
        protected var borderPen:RectanglePen ;
        
        /**
         * Refreshs the internal border.
         * @private
         */
        protected function refreshBorder( themeBorder:ILineStyle = null ):void
        {
            var b:BackgroundButton      = target as BackgroundButton ;
            var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
            borderPen.line = (themeBorder != null) ? themeBorder : ( b.enabled ? ( b.selected ? s.themeBorderSelected : s.themeBorder) : s.themeBorderDisabled ) ;
            borderPen.draw( b.w , b.h ) ;
        }
        
        /**
         * Refreshs the internal picture picture.
         * @private
         */
        protected function refreshPicture():void
        {
            var b:BackgroundButton = target as BackgroundButton ;
            picture.x = 0 ;
            picture.y = 0 ;
            picture.scrollRect = new Rectangle(0,0, b.w , b.h ) ;
        }
        
        /**
         * Invoked when the loading is finished and initialize.
         * @private
         */
        protected function initialize( e:Event ):void
        {
            picture.visible = true ;
            (target as PictureButton).enabled = picture.content != null ;
            update() ;
        }
        
        /**
         * The method invoked when the loading is finished and initialize.
         * @private
         */
        protected function error( e:Event ):void
        {
            logger.error( this + " ioError : " + e ) ;
        }
    }
}
