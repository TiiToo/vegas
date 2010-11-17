﻿/*

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
    import lunas.logging.logger;
    
    import vegas.display.Background;
    
    import flash.display.Loader;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    
    /**
     * The builder of the ThumbButton component.
     */
    public class ThumbButtonBuilder extends LightButtonBuilder
    {
        /**
         * Creates a new ThumbButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function ThumbButtonBuilder( target:ThumbButton )
        {
            super( target );
        }
        
        /**
         * The background of the component.
         */
        public var background:Background ;
        
        /**
         * The loader of the component.
         */
        public var loader:Loader ;
        
        /**
         * Clear the view of the component.
         */
        public override function clear():void
        {
            var t:ThumbButton = target as ThumbButton ;
            if ( background != null )
            {
                t.removeChild( background ) ;
                background = null ;
            }
            if ( loader != null )
            {
                t.removeChild( loader ) ;
                loader = null ;
            }
        }
        
        /**
         * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            var t:ThumbButton = target as ThumbButton ;
            
            background = new Background() ;
            loader     = new Loader() ;
            
            loader.contentLoaderInfo.addEventListener( Event.INIT , _init ) ;
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _error);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _error);
            
            t.addChild( background ) ;
            t.addChild( loader ) ;
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void
        {
            var $s:ThumbButtonStyle = (target as ThumbButton).style as ThumbButtonStyle ;
            var $w:Number  = (target as ThumbButton).w ;
            var $h:Number  = (target as ThumbButton).h ;
            if (background != null)
            {
                background.line = $s.themeBorder ;
                background.fill = $s.theme ;
                background.setSize($w, $h) ;
                background.cacheAsBitmap = true ;
            }
            loader.x = ( (target as ThumbButton).w - loader.width ) / 2 ;
            loader.y = ( (target as ThumbButton).h - loader.height ) / 2 ;
        }
        
        /**
         * @private
         */
        private function _init( e:Event = null ):void
        {
            (target as ThumbButton).setSize( loader.width , loader.height ) ;
        }
        
        /**
         * @private
         */
        private function _error(e:ErrorEvent):void 
        {
            logger.error (this + " error : " + e ) ;
        }
    }
}