
package test.visitors
{
    
    import test.display.*;
    
    import vegas.core.CoreObject;
    import vegas.errors.IllegalArgumentError;
    import vegas.util.visitor.IVisitable;
    import vegas.util.visitor.IVisitor;

    public class ShowVisitor extends CoreObject implements IVisitor
    {
        
        public function ShowVisitor()
        {
            super();
        }
        
        public function visit(o:IVisitable):void
        {
            var picture:PictureDisplay = (o as PictureDisplay) ;

            if ( picture != null )
            {
               picture.visible = true ;
            }
            else
            {
                throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a PictureDisplay instance.") ;
            }
        }
        
    }
}