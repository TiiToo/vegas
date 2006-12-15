
import test.observer.diaporama.Picture;

import vegas.core.CoreObject;
import vegas.errors.IllegalArgumentError;
import vegas.util.visitor.IVisitable;
import vegas.util.visitor.IVisitor;

/**
 * This class release the view and the properties of a Picture instance.
 * @author eKameleon
 */
class test.observer.diaporama.visitors.ReleaseVisitor extends CoreObject implements IVisitor 
{
	
	/**
	 * Creates a new ReleaseVisitor instance.
	 */
	public function ReleaseVisitor() 
	{
		super();
	}

	/**
	 * Release a Picture object. Visit the IVisitable object. 
	 * Initialize the Picture and remove the target reference. 
	 */
	public function visit( o:IVisitable ):Void
	{
		if (o instanceof Picture)
		{
			trace("> " + this + " visit " + o) ;
			Picture(o).view.removeMovieClip() ;
			Picture(o).url = null ;
			Picture(o).name = null ;	
		}
		else
		{
			throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a Picture instance.") ;	
		}
	}

}