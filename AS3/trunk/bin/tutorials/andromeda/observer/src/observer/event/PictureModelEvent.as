
package observer.event
{
	import flash.events.Event;	

	/**
     * The PictureModelEvent used in the observer pattern with the PictureModel.
     * @author eKameleon
     */
    public class PictureModelEvent extends Event
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
    	static public const CLEAR:String = "onClear" ;
    
    	/**
    	 * The name of the event type when the picture model load a new picture.
    	 */
    	static public const LOAD:String = "onLoad" ;
    
    	/**
    	 * The name of the event type when the picture visibility is changed.
    	 */
    	static public const VISIBLE:String = "onVisible" ;
    
    	/**
    	 * Returns true if the picture is visible else false.
    	 * @return true if the picture is visible else false.
    	 */
    	public function isVisible():Boolean
    	{
    		return _isVisible ;
    	}	
    
    	/**
    	 * Returns the url string representation of the picture.
    	 * @return the url string representation of the picture.
    	 */
    	public function getUrl():String
    	{
    		return _url ;
    	}
    
    	/**
    	 * Sets the url string representation of the picture.
    	 */
    	public function setUrl( uri:String ):void
    	{
    		_url = uri ;
    	}
    	
    	/**
    	 * Sets the visible property of the picture.
    	 */
    	public function setVisible( b:Boolean ):void
    	{
    		_isVisible = b ;
    	}
    	
    	private var _isVisible:Boolean ;
    	
    	private var _url:String ;
    
    }
}