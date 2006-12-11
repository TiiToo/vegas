
import asgard.display.DisplayObjectCollector;

import test.mvc.diaporama.Gallery;

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.events.EventListener;

/**
 * This control is invoqued when the GalleryModel is cleared.
 * @author eKameleon
 */
class test.mvc.diaporama.control.model.ClearPicture extends CoreObject implements EventListener 
{
	
	/**
	 * Creates a new ClearPicture instance.
	 */
	public function ClearPicture() 
	{
		super();
	}

	/**
	 * Handle the event.
	 * Clear the Gallery display.
	 */
	public function handleEvent(e : Event) 
	{

		trace("> " + this + " handleEvent.") ;

		Gallery(DisplayObjectCollector.get( Gallery.GALLERY_NAME )).clear() ;

	}

}