
import test.visitor.diaporama.Picture;

import vegas.events.ModelChangedEvent;

/**
 * The PictureEvent used in the GalleryModel to notify a change in the model.
 * @author eKameleon
 */
class test.visitor.diaporama.events.PictureEvent extends ModelChangedEvent 
{

	/**
	 * Creates a new PictureEvent instance.
	 */	
	public function PictureEvent(name:String, picture:Picture) 
	{
		super(name);
		_picture = picture ;
		
	}
	
	/**
	 * Returns the Picture reference.
	 */
	public function getPicture():Picture
	{
		return _picture  ;
	}

	/**
	 * Sets the Picture reference.
	 */
	public function setPicture(p:Picture):Void
	{
		_picture  = p ;
	}

	private var _picture:Picture ;
	
}