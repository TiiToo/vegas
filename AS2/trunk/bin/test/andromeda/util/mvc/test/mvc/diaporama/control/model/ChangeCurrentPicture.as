
import test.mvc.diaporama.events.PictureEvent;
import test.mvc.diaporama.Picture;
import test.mvc.diaporama.visitors.HideVisitor;
import test.mvc.diaporama.visitors.ShowVisitor;

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.events.EventListener;

/**
 * This control is invoqued when the current picture in the GalleryModel change.
 * @author eKameleon
 */
class test.mvc.diaporama.control.model.ChangeCurrentPicture extends CoreObject implements EventListener 
{
	
	/**
	 * Creates a new ChangeCurrentPicture instance.
	 */
	public function ChangeCurrentPicture() 
	{
		super();
	}

	/**
	 * Handle the event.
	 */
	public function handleEvent(e : Event) 
	{
		
		trace("> " + this + " handleEvent.") ;
		
		var cur:Picture = PictureEvent(e).getPicture() ;
		var old:Picture = PictureEvent(e).oldPicture ;
		
		if (old != null)
		{
			old.accept(new HideVisitor()) ;
		}
		
		if (cur != null)
		{
			cur.accept(new ShowVisitor()) ;
		}
		
	}

}