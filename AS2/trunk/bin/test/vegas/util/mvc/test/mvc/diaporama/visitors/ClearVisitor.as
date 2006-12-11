
import test.mvc.diaporama.Picture;

import vegas.core.CoreObject;
import vegas.errors.IllegalArgumentError;
import vegas.util.visitor.IVisitable;
import vegas.util.visitor.IVisitor;

/**
 * This class clear the view of a Picture instance.
 * @author eKameleon
 */
class test.mvc.diaporama.visitors.ClearVisitor extends CoreObject implements IVisitor 
{
	
	/**
	 * Creates a new ClearVisitor instance.
	 */
	public function ClearVisitor() 
	{
		super();
	}

	/**
	 * Clear a Picture object. Visit the IVisitable object. 
	 */
	public function visit( o:IVisitable ):Void
	{
		if (o instanceof Picture)
		{
			trace("> " + this + " visit " + o) ;
			var view = Picture(o).view ;
			if (view.container.picture != null)
			{
				view.container.picture.removeMovieClip() ;	
			}
		}
		else
		{
			throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a Picture instance.") ;	
		}
	}

}