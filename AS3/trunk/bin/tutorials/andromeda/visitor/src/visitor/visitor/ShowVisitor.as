
package visitor.visitor
{
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;
    
    import vegas.core.CoreObject;
    
    import visitor.display.PictureDisplay;	

    /**
     * This visitor show the PictureDisplay reference of the application.
     */
	public class ShowVisitor extends CoreObject implements IVisitor
    {
        
        /**
         * Creates a new ShowVisitor instance.
         */
        public function ShowVisitor()
        {
            super();
        }

    	/**
	     * Clear a PictureDisplay object. 
	     * Visit the IVisitable object. 
    	 */
        public function visit(o:IVisitable):void
        {
            var picture:PictureDisplay = o as PictureDisplay ;
			trace( this + " visit : " + picture ) ;
            if ( picture != null )
            {
               picture.visible = true ;
            }
            else
            {
                throw new Error(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
	}
}
