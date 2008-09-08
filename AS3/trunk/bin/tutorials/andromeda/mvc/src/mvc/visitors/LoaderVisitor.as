﻿
package mvc.visitors
{
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import asgard.display.DisplayObjectCollector;
    
    import mvc.display.PictureDisplay;
    import mvc.display.UIList;
    
    import vegas.core.CoreObject;    

    public class LoaderVisitor extends CoreObject implements IVisitor
    {
        
        /**
         * Creates a new LoaderVisitor instance.
         */ 
        public function LoaderVisitor( url:String )
        {
            super();
            loader = DisplayObjectCollector.get(UIList.LOADER) as Loader ;
            if ( ! loader.contentLoaderInfo.hasEventListener( Event.COMPLETE ) )
            {
                loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete ) ;
            } ;
            request = new URLRequest() ;
            request.url = url ;
        }
        
        /**
         * The Loader of the application.
         */
        public var loader:Loader ;
        
        /**
         * The picture of the application.
         */
        public var picture:PictureDisplay ;
        
        /**
         * The URLRequest of the application.
         */
        public var request:URLRequest ;
        
        /**
         * Indicates the url of this LoaderVisitor.
         */  
        public function get url():String 
        {
            return request.url ;
        }

        /**
         * @private
         */  
        public function set url(sUrl:String):void
        {
            request.url = sUrl ;
        }

        public function complete( e:Event ):void
        {
            trace("complete : " + e) ;
            picture.addChild( loader ); 
            loader.x = (picture.width - loader.width) / 2 ;
            loader.y = (picture.height - loader.height) / 2 ;
        }

        /**
         * Loader a Picture object. Visit the IVisitable object. 
         */
        public function visit( o:IVisitable ):void
        {
            picture = o as PictureDisplay ;

            if ( picture != null )
            {
               picture.accept( new ClearVisitor() ) ;
               loader.load( request ) ;
            }
            else
            {
                throw new ArgumentError(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
        
}