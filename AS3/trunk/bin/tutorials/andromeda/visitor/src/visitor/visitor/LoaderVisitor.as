
package visitor.visitor
{
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import vegas.core.CoreObject;
    import vegas.errors.IllegalArgumentError;
    
    import visitor.display.PictureDisplay;    

    public class LoaderVisitor extends CoreObject implements IVisitor
    {
        
        /**
         * Creates a new LoaderVisitor instance.
         */ 
        public function LoaderVisitor( url:String=null )
        {
            request = new URLRequest(url) ;
        }
        
        /**
         * The Loader reference of this visitor.
         */
        public var loader:Loader ;
        
        /**
         * The picture reference of this visitor.
         */
        public var picture:PictureDisplay ;
        
        /**
         * The URLRequest of the visitor.
         */
        public var request:URLRequest ;
        
        /**
         * Returns the url of this LoaderVisitor.
         */  
        public function get url():String 
        {
            return request.url ;
        }

        /**
         * Sets the url of this LoaderVisitor.
         */  
        public function set url(sUrl:String):void
        {
            request.url = sUrl ;
        }
        
        /**
         * Invoked when the picture loading is complete.
         */
        public function complete( e:Event ):void
        {
            trace("complete : " + e) ;
        	picture.addChild( loader ) ; 
        	loader.x = ( picture.width  - loader.width  ) / 2 ;
        	loader.y = ( picture.height - loader.height ) / 2 ;
        }

    	/**
	     * Loader a Picture object. Visit the IVisitable object. 
    	 */
        public function visit( o:IVisitable ):void
        {
            picture = o as PictureDisplay ;
			trace( this + " visit : " + picture ) ;
            if ( picture != null )
            {
                picture.accept( new ClearVisitor() ) ;
                if ( loader == null )
                {
                    loader = picture.loader ;
                    loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete ) ;
                }
                if ( loader != null )
                {
                    loader.load( request ) ;
                }
                else
                {
                	throw new Error(this + " 'visit' method failed, the internal loader not must be 'null' or 'undefined'.") ;
                }
            }
            else
            {
                throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
        
}