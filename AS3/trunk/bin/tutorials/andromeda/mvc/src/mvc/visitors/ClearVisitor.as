
package mvc.visitors
{
	import flash.display.Loader;
	
	import andromeda.util.visitor.IVisitable;
	import andromeda.util.visitor.IVisitor;
	
	import asgard.display.DisplayObjectCollector;
	
	import mvc.display.PictureDisplay;
	import mvc.display.UIList;
	
	import vegas.core.CoreObject;
	import vegas.errors.IllegalArgumentError;	

	/**
     * This class clear the view of a Picture instance.
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
            var picture:PictureDisplay = (o as PictureDisplay) ;
            if ( picture != null )
            {
               var loader:Loader = DisplayObjectCollector.get(UIList.LOADER) as Loader;
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