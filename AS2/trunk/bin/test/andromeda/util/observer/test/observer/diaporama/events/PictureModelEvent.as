import vegas.events.BasicEvent;

/**
 * The PictureModelEvent used in the observer pattern with the PictureModel.
 * @author eKameleon
 */
class test.observer.diaporama.events.PictureModelEvent extends BasicEvent 
{
	
	/**
	 * Creates a PictureModelEvent instance.
	 */
	public function PictureModelEvent( type:String ) 
	{
		super(type);
	}
	
	/**
	 * The name of the event type when the picture model is clear.
	 */
	static public var CLEAR:String = "onClear" ;

	/**
	 * The name of the event type when the picture model load a new picture.
	 */
	static public var LOAD:String = "onLoad" ;

	/**
	 * The name of the event type when the picture visibility is changed.
	 */
	static public var VISIBLE:String = "onVisible" ;

	/**
	 * Returns true if the picture is visible else false.
	 */
	public function isVisible():Boolean
	{
		return _isVisible ;
	}	

	/**
	 * Returns the url string representation of the picture.
	 */
	public function getUrl():String
	{
		return _url ;
	}

	/**
	 * Sets the url string representation of the picture.
	 */
	public function setUrl( uri:String ):Void
	{
		_url = uri ;
	}
	
	/**
	 * Sets the visible property of the picture.
	 */
	public function setVisible( b:Boolean ):Void
	{
		_isVisible = b ;
	}
	
	private var _isVisible:Boolean ;
	
	private var _url:String ;

}