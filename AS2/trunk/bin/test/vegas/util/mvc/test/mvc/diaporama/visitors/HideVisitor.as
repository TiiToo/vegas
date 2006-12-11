
import test.mvc.diaporama.Picture;

import vegas.core.CoreObject;
import vegas.errors.IllegalArgumentError;
import vegas.util.visitor.IVisitable;
import vegas.util.visitor.IVisitor;

/**
 * This class hide the view of a Picture instance.
 * @author eKameleon
 */
class test.mvc.diaporama.visitors.HideVisitor extends CoreObject implements IVisitor 
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
	public function visit( o:IVisitable ):Void
	{
		if (o instanceof Picture)
		{
			trace("> " + this + " visit " + o) ;
			Picture(o).setVisible( false ) ;
		}
		else
		{
			throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a Picture instance.") ;	
		}	
	}
	
}