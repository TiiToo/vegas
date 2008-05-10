
package visitor.visitor
{
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import visitor.display.PictureDisplay;    

    /**
     * This visitor clear the view of a PictureDisplay instance.
     * @author eKameleon
     */
    public class ClearVisitor implements IVisitor
    {

    	/**
    	 * Creates a new ClearVisitor instance.
    	 */
        public function ClearVisitor()
        {
            super();
        }

    	/**
	     * Clear a PictureDisplay object. 
	     * Visit the IVisitable object. 
    	 */
        public function visit( o:IVisitable ):void
        {
            var picture:PictureDisplay = o as PictureDisplay ;
            trace( this + " visit : " + picture ) ;
            if ( picture != null )
            {
                if ( picture.contains( picture.loader ) )
                {
                    picture.removeChild( picture.loader ) ;
                }
            }
            else
            {
                throw new Error(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
}