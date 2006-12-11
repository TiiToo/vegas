
import test.observer.diaporama.events.PictureModelEvent;
import test.observer.diaporama.Picture;
import test.observer.diaporama.visitors.ClearVisitor;
import test.observer.diaporama.visitors.HideVisitor;
import test.observer.diaporama.visitors.LoaderVisitor;
import test.observer.diaporama.visitors.ShowVisitor;

import vegas.core.CoreObject;
import vegas.util.observer.IObserver;
import vegas.util.observer.Observable;

/**
 * This class clear the view of a Picture instance.
 * @author eKameleon
 */
class test.observer.diaporama.PictureObserver extends CoreObject implements IObserver
{
	
	/**
	 * Creates a new ClearVisitor instance.
	 */
	public function PictureObserver( picture:Picture ) 
	{
		super();
		_picture = picture ;
	}
	
	/**
	 * This method is called whenever the observed object is changed.
	 * @param o the observable object.
	 * @param arg an argument passed to the notifyObservers method.
	 */
	public function update(o:Observable, arg) 
	{
		
		var event:PictureModelEvent = PictureModelEvent(arg) ;
		
		switch (event.getType())
		{
			
			case PictureModelEvent.CLEAR :
			{
				_picture.accept( new ClearVisitor() ) ;
				break ;
			}

			case PictureModelEvent.LOAD :
			{
				_picture.url = event.getUrl() ;
				_picture.accept( new LoaderVisitor() ) ;
				break ;
			}

			case PictureModelEvent.VISIBLE :
			{
				var isVisible:Boolean = event.isVisible() ;
				if (isVisible)
				{
					_picture.accept(new ShowVisitor()) ;
				}
				else
				{
					_picture.accept(new HideVisitor()) ;
				}
				break ;
			}
				
			
		}
		
	}

	private var _picture:Picture ;


}