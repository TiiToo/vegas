
package observer.visitor
{
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import visitor.display.PictureDisplay;    

    /**
     * This visitor hide the PictureDisplay reference of the application.
     */
    public class HideVisitor implements IVisitor
    {
        
        /**
         * Creates a new HideVisitor instance.
         */
        public function HideVisitor()
        {
            super();
        }
        
        /**
         * Hide a Picture object. 
         * Visit the IVisitable object. 
         */
        public function visit(o:IVisitable):void
        {
            var picture:PictureDisplay = o as PictureDisplay ;
            trace( this + " visit : " + picture ) ;
            if ( picture != null )
            {
               picture.visible = false ;
            }
            else
            {
                throw new Error(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
        
}