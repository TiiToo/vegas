import andromeda.util.visitor.IVisitable;
import andromeda.util.visitor.IVisitor;

import test.observer.diaporama.Picture;

import vegas.core.CoreObject;
import vegas.errors.IllegalArgumentError;

/**
 * This class hide the view of a Picture instance.
 * @author eKameleon
 */
class test.observer.diaporama.visitors.HideVisitor extends CoreObject implements IVisitor 
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