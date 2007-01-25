
package visitors
{
    import display.*;
    
    import vegas.core.CoreObject;
    import vegas.errors.IllegalArgumentError;
    import vegas.util.visitor.IVisitable;
    import vegas.util.visitor.IVisitor;

    public class HideVisitor extends CoreObject implements IVisitor
    {
        public function HideVisitor()
        {
            super();
        }
        
    	/**
	     * Hide a Picture object. Visit the IVisitable object. 
    	 */
        public function visit(o:IVisitable):void
        {
            var picture:PictureDisplay = (o as PictureDisplay) ;

            if ( picture != null )
            {
               picture.visible = false ;
            }
            else
            {
                throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
        
}