import andromeda.util.visitor.IVisitable;
import andromeda.util.visitor.IVisitor;

import test.visitor.diaporama.Picture;

import vegas.core.CoreObject;
import vegas.errors.IllegalArgumentError;

/**
 * This class release the view and the properties of a Picture instance.
 * @author eKameleon
 */
class test.visitor.diaporama.visitors.ReleaseVisitor extends CoreObject implements IVisitor 
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