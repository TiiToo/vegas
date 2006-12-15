
import test.observer.diaporama.events.PictureModelEvent;

import vegas.data.iterator.Iterator;
import vegas.data.Set;
import vegas.data.set.HashSet;
import vegas.util.observer.Observable;

/**
 * The model to change the Picture with differents external files.
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
		_set = new HashSet() ;
		_it = _set.iterator() ;
	}
	
	/**
	 * Clears the model.
	 */
	public function clear():Void
	{
		_set.clear() ;
		_it = _set.iterator() ;
		notifyChanged( _eClear );	
	}

	/**
	 * Returns the string representation of the current picture url.
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
	 * Inserts a new picture's url in the model, if the url exist the url isn't inserted.
	 * @return 'true' if the url is inserted else 'false' if the url allready exist in the model.
	 */
	public function insertUrl( sUrl:String ):Boolean
	{
		return _set.insert( sUrl ) ;
	}

	/**
	 * Launch the loading of the next Picture in the model. If the model hasn't a next picture, the model load the first picture.
	 * This method used an Iterator to keep the next url in the model. If the user use the 
	 */
	public function run():Void
	{
		if (!_it.hasNext()) 
		{
			_it.reset() ;
		}
		load(_it.next()) ;
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
	 * Loads the picture defined bu the url specified in argument.
	 * @param uri the string representation of the file to load.
	 */
	public function load( uri:String ):Void
	{
		_eLoad.setUrl( uri ) ;
		notifyChanged( _eLoad ) ;
	}

	/**
	 * Reset the internal Iterator of this model.
	 */
	public function reset():Void
	{
		_it.reset() ;
	}

	/**
	 * Returns the number of picture urls in the model.
	 * @return the number of picture urls in the model.
	 */
	public function size():Number
	{
		return _set.size() ;	
	}
	
	/**
	 * Show the picture.
	 */
	public function show():Void
	{
		_eVisible.setVisible(true);
		notifyChanged(_eVisible) ;		
	}
	
	/**
	 * The internal PictureModelEvent used when the model is cleared.
	 */
	private var _eClear:PictureModelEvent ;
	
	/**
	 * The internal PictureModelEvent used when a picture is loaded.
	 */
	private var _eLoad:PictureModelEvent ;
	
	/**
	 * The internal PictureModelEvent used when property visible changed.
	 */
	private var _eVisible:PictureModelEvent ;
	
	/**
	 * Defined the internal Iterator of this model.
	 */
	private var _it:Iterator ;
	
	/**
	 * The internal Set of this model.
	 */
	private var _set:Set ;

}