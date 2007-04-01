
import test.mvc.diaporama.events.EventList;
import test.mvc.diaporama.events.PictureEvent;
import test.mvc.diaporama.Picture;

import vegas.core.IRunnable;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.errors.Warning;
import vegas.events.EventDispatcher;
import vegas.util.mvc.AbstractModel;

/**
 * The model of the gallery.
 * @author eKameleon
 */
class test.mvc.diaporama.model.GalleryModel extends AbstractModel implements IRunnable
{
	
	/**
	 * Creates a new GalleryModel singleton.
	 */
	private function GalleryModel() 
	{
		
		super();
		
		_map = new HashMap() ;
		
		_eAdd = new PictureEvent( EventList.ADD_PICTURE ) ;
		_eChange = new PictureEvent( EventList.CHANGE_CURRENT_PICTURE ) ;
		_eClear = new PictureEvent( EventList.CLEAR_PICTURE ) ;
		_eRemove = new PictureEvent( EventList.REMOVE_PICTURE ) ;
		
	}

	/**
	 * Inserts a Picture in the model.
	 * @throws Warning if the name of the picture is null or undefined.
	 * @throws Warning if the name of the picture exist in the model. 
	 */
	public function addPicture( picture:Picture ):Void
	{
		var name:String = picture.name ;
		if (name != null)
		{
			if ( !contains(name) )
			{
				_map.put ( name , picture ) ;
				_eAdd.setPicture( picture ) ;
				notifyChanged( _eAdd ) ;
			}
			else
			{
				throw new Warning(this + " addPicture failed, the name exist in the model, you must remove the picture in the model defined by this name if you want insert this Picture.") ;
			}
		}
		else
		{
			throw new Warning(this + " addPicture failed, the name of the picture not must be 'null' or 'undefined'.") ;
		}
	}
	
	/**
	 * Clear the model.
	 */
	public function clear():Void
	{
		_map.clear() ;
		_currentPicture = null ;
		reset() ;
		notifyChanged( _eClear ) ;
	}
	
	/**
	 * Returns true if the model contains the Picture defined by the specified string name in parameter.
	 * @return true if the model contains the Picture defined by the specified string name in parameter.
	 */
	public function contains( name:String ):Boolean
	{
		return _map.containsKey(name) ;
	}

	/**
	 * Returns the Picture reference of the current picture in the model.
	 * @return the Picture reference of the current picture in the model.
	 */
	public function getCurrentPicture():Picture
	{
		return _currentPicture ;	
	}

	/**
	 * Returns the Picture reference in the model defined by the name passed in argument or 'null'.
	 * @return the Picture reference in the model defined by the name passed in argument or 'null'.
	 */
	public function getPicture( name:String ):Picture
	{
		return _map.get(name) || null ;	
	}

	/**
	 * Returns the singleton instance of GalleryModel.
	 * @return singleton instance of GalleryModel.
	 */
	static public function getInstance():GalleryModel 
	{
		if ( _instance == null )
		{
			_instance = new GalleryModel() ;
		}
		return _instance ;
	}

	/**
	 * Init the EventDispatcher reference of this EventTarget object. 
	 * Uses a global EventDispatcher to used this model with the FrontController of the application.
	 */
	public function initEventDispatcher():EventDispatcher
	{
		return EventDispatcher.getInstance() ;	
	}

	/**
	 * Returns the Picture iterator of this model.
	 */
	public function iterator():Iterator
	{
		return _map.iterator() ;
	}

	/**
	 * Returns the next picture in the gallery.
	 */
	public function next():Void
	{
		if ( ! _it.hasNext() )
		{
			_it.reset() ;
		}

		setCurrentPicture( _it.next() ) ;
		
		_currentKey = _it.key() ;
		
	}
	
	/**
	 * Returns the next picture in the gallery.
	 */
	public function prev():Void
	{
		
		_currentKey -- ;
		
		if (_currentKey < 0)
		{
			_currentKey = GalleryModel.getInstance().size() - 1 ;
		}
		
		_it.seek(  _currentKey  ) ;

		setCurrentPicture( _it.next() ) ;
		
	}
	

	/**
	 * Removes a Picture in the model.
	 */
	public function removePicture( picture:Picture ):Void
	{
		var name:String = picture.name ;
		if (name != null)
		{
			if ( contains(name) )
			{
				var p:Picture = _map.get(name) ;
				_map.remove ( name ) ;
				_eRemove.setPicture( p ) ;
				notifyChanged( _eRemove ) ;
			}
			else
			{
				throw new Warning(this + " removePicture failed, the name don't exist in the model, you can't remove this picture : " + picture) ;
			}
		}
		else
		{
			throw new Warning(this + " removePicture failed, the name of the picture not must be 'null' or 'undefined'.") ;
		}
	}

	/**
	 * Reset the iterator of the Gallery.
	 */
	public function reset():Void
	{
		if (size() > 0)
		{
			_it = _map.keyIterator() ;
		}
		else
		{
			_it = null ;
		}	
	}
	
	/**
	 * Run the model to launch the next picture in the Picture display.
	 */
	public function run():Void
	{
		reset() ;
		next() ;		
	}

	/**
	 * Sets the current picture in the gallery.
	 */
	public function setCurrentPicture( name:String ):Void
	{
		
		if ( contains(name) )
		{
			trace("> " + this + " setCurrentPicture : " + name) ;
			_eChange.oldPicture = _currentPicture ;
			_currentPicture = getPicture(name) ;
			_eChange.setPicture(_currentPicture) ;
			notifyChanged(_eChange) ;
		}
		else
		{
			throw new Warning(this + " setCurrentPicture failed, the name of the picture passed in argument isn't register in the model.") ;
		}
	}
	
	/**
	 * Returns the number of elements in the model.
	 * @return the number of elements in the model.
	 */
	public function size():Number
	{
		return _map.size() ;	
	}

	/**
	 * The current key of the iterator.
	 */
	private var _currentKey:Number ;

	/**
	 * The internal current Picture reference.
	 */
	private var _currentPicture:Picture = null ;

	/**
	 * The PictureEvent used when a Picture is inserted in the model.
	 */
	private var _eAdd:PictureEvent ;

	/**
	 * The PictureEvent used when the current Picture change.
	 */
	private var _eChange:PictureEvent ;
	
	/**
	 * The PictureEvent used when a Picture is inserted in the model.
	 */
	private var _eClear:PictureEvent ;

	/**
	 * The PictureEvent used when a Picture is removed in the model.
	 */
	private var _eRemove:PictureEvent ;

	/**
	 * The internal singleton reference.
	 */
	private static var _instance:GalleryModel ;

	/**
	 * The internal iterator to show the pictures.
	 */
	private var _it:Iterator ;
	

	/**
	 * The internal map to register all pictures in the model.
	 */
	private var _map:HashMap ;

}