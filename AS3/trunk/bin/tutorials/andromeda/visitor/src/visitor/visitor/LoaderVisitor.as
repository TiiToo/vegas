
package visitor.visitor
{
    import flash.display.Loader;
    import flash.net.URLRequest;
    
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import vegas.core.CoreObject;
    
    import visitor.display.PictureDisplay;    

    public class LoaderVisitor extends CoreObject implements IVisitor
    {
        
        /**
         * Creates a new LoaderVisitor instance.
         * @param url The String representation of the full qualified file name to load.
         */ 
        public function LoaderVisitor( url:String=null )
        {
            request = new URLRequest(url) ;
        }
        
        /**
         * The URLRequest of the visitor.
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
        
    	/**
	     * Loader a Picture object. 
	     * Visit the IVisitable object. 
    	 */
        public function visit( o:IVisitable ):void
        {
            var picture:PictureDisplay = o as PictureDisplay ;
			trace( this + " visit : " + picture ) ;
            if ( picture != null )
            {
                picture.accept( new ClearVisitor() ) ;
                picture.loader.load( request ) ;
            }
            else
            {
                throw new Error(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
}

