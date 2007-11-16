
import test.mvc.diaporama.events.PictureEvent;
import test.mvc.diaporama.visitors.ReleaseVisitor;

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.events.EventListener;

/**
 * This control is invoqued when a picture is removed in the GalleryModel.
 * @author eKameleon
 */
class test.mvc.diaporama.control.model.RemovePicture extends CoreObject implements EventListener 
{
	
	/**
	 * Creates a new RemovePicture instance.
	 */
	public function RemovePicture() 
	{
		super();
	}

	/**
	 * Handle the event.
	 */
	public function handleEvent(e : Event) 
	{
		
		trace("> " + this + " handleEvent.") ;
		
		// release the Picture.
		PictureEvent(e).getPicture().accept( new ReleaseVisitor() ) ;
		
	}

}