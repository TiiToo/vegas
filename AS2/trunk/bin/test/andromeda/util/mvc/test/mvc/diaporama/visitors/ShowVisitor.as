import andromeda.util.visitor.IVisitable;
import andromeda.util.visitor.IVisitor;

import test.mvc.diaporama.Picture;

import vegas.core.CoreObject;
import vegas.errors.IllegalArgumentError;

/**
 * This class show the view of a Picture instance.
 * @author eKameleon
 */
class test.mvc.diaporama.visitors.ShowVisitor extends CoreObject implements IVisitor 
{
	
	/**
	 * Creates a new ShowVisitor instance.
	 */
	public function ShowVisitor() 
	{
		super();
	}
	
	/**
	 * Show a Picture object. Visit the IVisitable object. 
	 */
	public function visit( o:IVisitable ):Void
	{
		if (o instanceof Picture)
		{
			trace("> " + this + " visit " + o) ;
			Picture(o).setVisible( true ) ;
		}
		else
		{
			throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a Picture instance.") ;	
		}
	}
	

}