
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
    	 * @param type The type of the event.
    	 * @param url The url of the picture to load.
    	 * @param visible The state of the visibility of the picture.
    	 */
        public function PictureModelEvent( type:String , url:String=null , visible:Boolean=false )
        {
            super( type ) ;
            this.url     = url ;
            this.visible = visible ;
        }

    	/**
    	 * The name of the event type when the picture model is clear.
    	 */
    	public static const CLEAR:String = "onClear" ;
    
    	/**
    	 * The name of the event type when the picture model load a new picture.
    	 */
    	public static const LOAD:String = "onLoad" ;
    
    	/**
    	 * The name of the event type when the picture visibility is changed.
    	 */
    	public static const VISIBLE:String = "onVisible" ;
    
    	/**
    	 * Indicates the url string representation of the picture.
    	 */
    	public var url:String ;
    
        /**
         * Indicates if the picture is visible.
         */
        public var visible:Boolean ;
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():Event
        {
        	return new PictureModelEvent(type, url, visible) ;
        }
        
    }

}