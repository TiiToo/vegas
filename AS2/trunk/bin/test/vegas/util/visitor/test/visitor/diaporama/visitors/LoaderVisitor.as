
import test.visitor.diaporama.Picture;
import test.visitor.diaporama.visitors.ClearVisitor;
import test.visitor.diaporama.visitors.ShowVisitor;

import vegas.core.CoreObject;
import vegas.errors.IllegalArgumentError;
import vegas.errors.Warning;
import vegas.events.Delegate;
import vegas.util.visitor.IVisitable;
import vegas.util.visitor.IVisitor;

/**
 * This class load an external picture in a Picture instance.
 * @author eKameleon
 */
class test.visitor.diaporama.visitors.LoaderVisitor extends CoreObject implements IVisitor 
{

	/**
	 * Creates a new LoaderVisitor instance.
	 */
	public function LoaderVisitor() 
	{
		super();
	}

	/**
	 * Load a Picture object with this current url. Visit the IVisitable object. 
	 */
	public function visit( o:IVisitable ):Void
	{
		if (o instanceof Picture)
		{
			trace("> " + this + " visit " + o) ;
			var view = Picture(o).view ;
			var url:String = Picture(o).url ;
			
			// clear the picture.
			Picture(o).accept( new ClearVisitor() ) ;
			
			if (url.length > 0)
			{
			
				var listener:Object = {} ;
				listener.onLoadInit = Delegate.create(this, onLoadInit, Picture(o) ) ;
				
				var target:MovieClip = view.container.createEmptyMovieClip("picture", 1) ;
				var loader:MovieClipLoader = new MovieClipLoader() ;
				loader.addListener(listener) ;
				
				loader.loadClip(url , target) ;
			}
			else
			{
				throw new Warning(this + " the picture '" + o + "' can't be loading with an empty url property.") ; 	
			}
			
		}
		else
		{
			throw new IllegalArgumentError(this + " 'visit' method failed, the argument of this method must be a Picture instance.") ;	
		}
	}

	/**
	 * Invoqued when the loading of a Picture is finished and initialized.
	 */
	public function onLoadInit( target:MovieClip , picture:Picture ):Void
	{
		
		trace("> " + this + " picture " + picture + " is loading and init.") ;
		
		// show the picture.
		picture.accept( new ShowVisitor() ) ;
		
	}

}