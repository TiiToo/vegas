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
package lunas.components.labels 
{
    import graphics.geom.EdgeMetrics;
    
    import lunas.logging.logger;
    
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    
    /**
     * The builder of the IconLabel component.
     */
    public class IconLabelBuilder extends LabelBuilder 
    {
        /**
         * Creates a new IconTitleBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function IconLabelBuilder( target:DisplayObject )
        {
            super( target );
        }
        
        /**
         * The picture container reference of the component.
         */
        public var container:DisplayObject ;
        
        /**
         * Attach a linked DisplayObject to create the icon of the component.
         */
        public function attach( state:DisplayObject ):void
        {
            _releaseContainer() ;
            container = state ;
            ( target as IconLabel ).addChild( container ) ;
            ( target as IconLabel ).update() ;
        }
        
         /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            super.clear() ; 
            var b:IconLabel = target as IconLabel ;    
            if ( container != null && b.contains( container) )
            {
                b.removeChild( container ) ;
            }
            container = null ;
        }
        
        /**
         * Loads an external picture or swf in the component to create the icon.
         */
        public function load( request:URLRequest ):void
        {
            _releaseContainer() ;
            var loader:Loader   = new Loader() ;
            var info:LoaderInfo = loader.contentLoaderInfo ;
            container = loader ;
            info.addEventListener( Event.INIT                        , _initialize ) ;
            info.addEventListener( IOErrorEvent.IO_ERROR             , _error      ) ;
            info.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _error      ) ;
            loader.load( request ) ;
        }
        
        /**
          * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run() ;
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            super.update() ;
            refreshContainer() ;
        }
        
        /**
         * The method invoked when the loading is finished and initialize.
         */
        private function _initialize( e:Event ):void
        {
            update() ;
            ( target as IconLabel ).addChild(container) ;
        }
        
        /**
         * Refresh the container.
         */
        protected function refreshContainer():void
        {
            if ( container != null )
            {
                var t:IconLabel      = target as IconLabel ;
                var s:IconLabelStyle = t.style as IconLabelStyle ;
                
                var ml:Number = EdgeMetrics.filterNaNValue( s.margin.left ) ;
                var mr:Number = EdgeMetrics.filterNaNValue( s.margin.right ) ;
                
                var pb:Number = EdgeMetrics.filterNaNValue( s.padding.bottom ) ;
                var pl:Number = EdgeMetrics.filterNaNValue( s.padding.left ) ;
                var pt:Number = EdgeMetrics.filterNaNValue( s.padding.top ) ;
                
                container.x   = ml ;
                
                field.x      = container.x + container.width + pl ;
                field.width  = isNaN( s.width ) ? ( t.w - ( field.x + mr ) ) : s.width ; 
                field.height = isNaN( s.height) ? ( t.h - pb - pt ) : s.height ;
                
                container.y = (t.height - container.height) / 2-2 ;
            }
            
        }
        
        /**
         * Release the container.
         */
        private function _releaseContainer():void
        {
            if ( container != null )
            {
                if ( container is Loader )
                {
                    var loader:Loader   = container as Loader ;
                    var info:LoaderInfo = loader.contentLoaderInfo ;
                    info.removeEventListener( Event.INIT , _initialize ) ;
                    info.removeEventListener( IOErrorEvent.IO_ERROR , _error ) ;
                    info.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , _error ) ;
                    if( loader.content != null )
                    {
                        loader.unload() ;
                    }
                }
                if ( ( target as IconLabel ).contains( container ) )
                {
                    ( target as IconLabel ).removeChild( container ) ;
                }
                container = null ;
            }
        }
        
        /**
         * The method invoked when the loader notify an error.
         */
        private function _error( e:Event ):void
        {
            logger.error( this + " error : " + e ) ;
        }
    }
}
