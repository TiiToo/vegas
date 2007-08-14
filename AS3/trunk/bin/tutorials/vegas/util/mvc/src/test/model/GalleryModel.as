package test.model
{
	import flash.events.EventDispatcher;
	
	import test.control.Controller;
	import test.display.PictureDisplay;
	import test.events.EventList;
	import test.events.PictureEvent;
	import test.vo.PictureVO;
	
	import vegas.data.iterator.Iterator;
	import vegas.data.map.ArrayMap;
	import vegas.errors.Warning;
	import vegas.events.EventBroadcaster;
	import vegas.util.mvc.AbstractModel;
	import vegas.core.IRunnable;

	/**
	 * The model of the gallery.
	 * @author eKameleon
	 */
	public final class GalleryModel extends AbstractModel implements IRunnable
	{
		
		/**
		 * Creates a new GalleryModel singleton.
		 */
		public function GalleryModel()
		{
			_map = new ArrayMap() ;
		}

		/**
		 * Inserts a PictureVO in the model.
		 * @throws Warning if the name of the picture is null or undefined.
		 * @throws Warning if the name of the picture exist in the model. 
		 */
		public function addPicture( picture:PictureVO ):void
		{
			var name:String = picture.name ;
			
			if (name != null)
			{
			
				if ( !contains(name) )
				{
					_map.put ( name , picture ) ;
					var eAdd:PictureEvent = new PictureEvent( EventList.ADD_PICTURE , picture ) ;
					dispatchEvent( eAdd ) ;
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
		public function clear():void
		{
			_map.clear() ;
			_currentPicture = null ;
			reset() ;
			dispatchEvent( new PictureEvent( EventList.CLEAR_PICTURE ) ) ;
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
		public function getCurrentPicture():PictureVO
		{
			return _currentPicture ;	
		}
	
		/**
		 * Returns the Picture reference in the model defined by the name passed in argument or 'null'.
		 * @return the Picture reference in the model defined by the name passed in argument or 'null'.
		 */
		public function getPicture( name:String ):PictureVO
		{
			return _map.get(name) as PictureVO ;	
		}
	
		/**
		 * Returns the singleton instance of GalleryModel.
		 * @return singleton instance of GalleryModel.
		 */
		public static function getInstance():GalleryModel 
		{
			if ( _instance == null )
			{
				_instance = new GalleryModel() ;
			}
			return _instance ;
		}
	
		/**
		 * Override the original method to use the FrontController.
		 */
		override public function initEventDispatcher():EventBroadcaster 
		{
			return EventBroadcaster.getInstance() ;
	    }
	
		/**
		 * Returns the iterator of this model.
		 * @return the iterator of this model.
		 */
		public function iterator():Iterator
		{
			return _map.iterator() ;
		}
	
		/**
		 * Sets the next PictureVO in the model.
		 */
		public function next():void
		{
			if ( ! _it.hasNext() )
			{
				_it.reset() ;
			}
	
			setCurrentPicture( _it.next() ) ;
			
			_currentKey = _it.key() ;
			
		}

		/**
		 * Sets the previous PictureVO in the model.
		 */
		public function prev():void
		{
			
			_currentKey -- ;
			
			if (_currentKey < 0)
			{
				_currentKey = size() - 1 ;
			}
			
			_it.seek(  _currentKey  ) ;
	
			setCurrentPicture( _it.next() ) ;
			
		}
		
	
		/**
		 * Removes a PictureVO in the model.
		 */
		public function removePicture( picture:PictureVO ):void
		{
			var name:String = picture.name ;
			if (name != null)
			{
				if ( contains(name) )
				{
					var p:PictureVO = _map.get(name) ;
					_map.remove ( name ) ;
					var eRemove:PictureEvent = new PictureEvent( EventList.REMOVE_PICTURE , picture ) ;
					dispatchEvent( eRemove ) ;
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
		public function reset():void
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
		public function run( ...arguments:Array ):void
		{
			reset() ;
			next() ;		
		}
	
		/**
		 * Sets the current picture in the gallery.
		 */
		public function setCurrentPicture( name:String ):void
		{
			if ( contains( name ) )
			{
				_currentPicture = getPicture(name) ;
				var eChange:PictureEvent = new PictureEvent( EventList.CHANGE_CURRENT_PICTURE ) ;
				eChange.setPicture(_currentPicture) ;
 				dispatchEvent( eChange ) ;
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
		 * The internal current PictureVO reference.
		 */
		private var _currentPicture:PictureVO = null ;
	
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
		private var _map:ArrayMap ;


	}
}