
import test.observer.diaporama.events.PictureModelEvent;

import vegas.util.observer.Observable;

/**
 * The model to change the picture.
 * @author eKameleon
 */
class test.observer.diaporama.model.PictureModel extends Observable 
{
	
	/**
	 * Creates a new PictureModel.
	 */
	public function PictureModel() 
	{
		super();
		_eClear   = new PictureModelEvent( PictureModelEvent.CLEAR) ;
		_eLoad = new PictureModelEvent( PictureModelEvent.LOAD) ;
		_eVisible = new PictureModelEvent( PictureModelEvent.VISIBLE ) ;
	}
	
	/**
	 * Clear the picture.
	 */
	public function clear():Void
	{
		notifyChanged( _eClear );	
	}

	/**
	 * Returns the string representation of the picture url.
	 */
	public function getUrl():String
	{
		return _eLoad.getUrl() ;	
	}

	/**
	 * Hide the picture.
	 */
	public function hide():Void
	{
		_eVisible.setVisible(false);
		notifyChanged(_eVisible) ;		
	}

	/**
	 * Notify a PictureModelEvent when the model change.
	 */
	public function notifyChanged( e:PictureModelEvent ):Void
	{
		setChanged ();
		notifyObservers( e );	
	}
	
	/**
	 * Load the picture defined bu the url specified in the setUrl method.
	 */
	public function load():Void
	{
		clear() ;
		notifyChanged( _eLoad ) ;
	}
	
	/**
	 * Sets the url of the picture.
	 */
	public function setUrl( uri:String ):Void
	{
		_eLoad.setUrl( uri ) ;
	}
	
	/**
	 * Show the picture.
	 */
	public function show():Void
	{
		_eVisible.setVisible(true);
		notifyChanged(_eVisible) ;		
	}
	
	private var _eClear:PictureModelEvent ;
	
	private var _eLoad:PictureModelEvent ;
	
	private var _eVisible:PictureModelEvent ;
		

}