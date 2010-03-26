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
    import graphics.Align;
    import graphics.geom.EdgeMetrics;

    import lunas.logging.logger;

    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    /**
     * The builder of the IconButton component.
     */
    public class IconButtonBuilder extends LabelButtonBuilder 
    {
        /**
         * Creates a new IconButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function IconButtonBuilder( target:DisplayObject )
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
            if  ( container is InteractiveObject )
            {
                (container as InteractiveObject).mouseEnabled = false ;
            }
            ( target as IconButton ).addChild( container ) ;
            ( target as IconButton ).update() ;
        }
        
        /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            super.clear() ; 
            var b:IconButton = target as IconButton ;
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
            container = new Loader() ;
            var c:Loader = container as Loader ;
            c.mouseEnabled = false ; 
            c.contentLoaderInfo.addEventListener( Event.INIT                           , _initialize ) ;
            c.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR                , _error      ) ;
            c.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , _error      ) ;
            c.load( request ) ;
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
            ( target as IconButton ).addChild(container) ;
            update() ;
        }
        
        /**
         * Refresh the container.
         */
        protected function refreshContainer():void
        {
            if ( container != null )
            {
                var t:IconButton      = target as IconButton ;    
                var s:IconButtonStyle = t.style as IconButtonStyle ;
                var a:uint            = t.iconAlign ;
                
                if ( s == null )
                {
                    return ;
                }
                container.filters = s.iconFilters ;
                
                var ml:Number = EdgeMetrics.filterNaNValue( s.margin.left ) ;
                var mr:Number = EdgeMetrics.filterNaNValue( s.margin.right ) ;
                var pb:Number = EdgeMetrics.filterNaNValue( s.padding.bottom ) ;
                var pl:Number = EdgeMetrics.filterNaNValue( s.padding.left ) ;
                var pr:Number = EdgeMetrics.filterNaNValue( s.padding.right ) ;
                var pt:Number = EdgeMetrics.filterNaNValue( s.padding.top ) ;
                
                if ( a == Align.RIGHT )
                {
                    container.x  = t.w - mr - container.width ;;
                    field.width  = container.x - pl - pr - mr ; 
                    field.x      = pl ;
                }
                else if ( a == Align.LEFT )
                {
                    container.x  = ml ;
                    field.x      = container.x + container.width + pl ;
                    field.width  = isNaN( s.width  ) ? ( t.w - ( field.x + mr ) ) : s.width ; 
                }
                field.height = isNaN( s.height ) ? ( t.h - pb - pt ) : s.height ;
                container.y = (t.h - container.height) / 2 ;
            }
        }
        
        /**
         * @private
         */
        private function _releaseContainer():void
        {
            if ( container != null )
            {
                if ( container is Loader )
                {
                    var c:Loader = container as Loader ;
                    c.contentLoaderInfo.removeEventListener( Event.INIT                        , _initialize ) ;
                    c.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR             , _error      ) ;
                    c.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , _error      ) ;
                    if( (container as Loader).content != null )
                    {
                        (container as Loader).unload() ;
                    }
                }
                if ( ( target as IconButton ).contains( container ) )
                {
                    ( target as IconButton ).removeChild( container ) ;
                }
                container = null ;
            }
        }
        
        /**
         * @private
         */
        private function _error( e:Event ):void
        {
            logger.error( this + " ioError : " + e ) ;
        }
    }
}
