
package visitor.visitor
{
    import flash.display.Loader;
    
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import vegas.core.CoreObject;
    import vegas.errors.IllegalArgumentError;
    
    import visitor.display.PictureDisplay;	

    /**
     * This visitor clear the view of a PictureDisplay instance.
     * @author eKameleon
     */
    public class ClearVisitor extends CoreObject implements IVisitor
    {

    	/**
    	 * Creates a new ClearVisitor instance.
    	 */
        public function ClearVisitor()
        {
            super();
        }

    	/**
	     * Clear a PictureDisplay object. Visit the IVisitable object. 
    	 */
        public function visit( o:IVisitable ):void
        {
            var picture:PictureDisplay = o as PictureDisplay ;
            trace( this + " visit : " + picture ) ;
            if ( picture != null )
            {
               var loader:Loader = picture.loader ;
               if (loader != null)
               {
                    if ( picture.contains(loader) )
                    {
                        picture.removeChild(loader) ;
                    }
               }
            }
            else
            {
                throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
}