
import test.mvc.diaporama.events.PictureEvent;
import test.mvc.diaporama.Picture;
import test.mvc.diaporama.visitors.HideVisitor;
import test.mvc.diaporama.visitors.LoaderVisitor;

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.events.EventListener;

/**
 * This control is invoqued when a picture is inserted in the GalleryModel.
 * @author eKameleon
 */
class test.mvc.diaporama.control.model.AddPicture extends CoreObject implements EventListener 
{
	
	/**
	 * Creates a new AddPicture instance.
	 */
	public function AddPicture() 
	{
		super();
	}

	/**
	 * Handle the event.
	 */
	public function handleEvent(e : Event) 
	{
		
		trace("> " + this + " handleEvent.") ;
		
		var pic:Picture = PictureEvent(e).getPicture() ;
		
		// hide the picture.
		pic.accept( new HideVisitor() ) ;
		
		// load the picture.
		pic.accept( new LoaderVisitor() ) ;
		
	}

}