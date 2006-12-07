import vegas.data.map.HashMap;
import vegas.events.EventDispatcher;
import vegas.util.mvc.AbstractModel;

/**
 * @author eKameleon
 */
class test.visitor.diaporama.model.GalleryModel extends AbstractModel 
{
	
	/**
	 * Creates a new GalleryModel singleton.
	 */
	private function GalleryModel() 
	{
		super();
		_map = new HashMap() ;
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
	 * Init the EventDispatcher reference of this EventTarget object. 
	 * Uses a global EventDispatcher to used this model with the FrontController of the application.
	 */
	public function initEventDispatcher():EventDispatcher
	{
		return EventDispatcher.getInstance() ;	
	}

	/**
	 * The internal singleton reference.
	 */
	private static var _instance:GalleryModel ;

	/**
	 * The internal map to register all pictures in the model.
	 */
	private var _map:HashMap ;

}