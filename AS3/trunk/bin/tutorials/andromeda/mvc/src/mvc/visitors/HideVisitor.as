
package mvc.visitors
{
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import mvc.display.PictureDisplay;
    
    import vegas.core.CoreObject;    

    public class HideVisitor extends CoreObject implements IVisitor
    {
        
        /**
         * Creates a new HideVisitor instance.
         */
        public function HideVisitor()
        {
            super();
        }
        
        /**
         * Hide a Picture object. Visit the IVisitable object. 
         */
        public function visit(o:IVisitable):void
        {
            var picture:PictureDisplay = o as PictureDisplay ;

            if ( picture != null )
            {
               picture.visible = false ;
            }
            else
            {
                throw new ArgumentError(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
        
}