package observer.model
{
    import andromeda.util.observer.Observable;
    
    import observer.event.PictureModelEvent;
    
    import system.data.Iterator;
    import system.data.Set;
    import system.data.sets.HashSet;
    import system.process.Runnable;    

    /**
     * The model to change the Picture with differents external files.
     * @author eKameleon
     */
    public class PictureModel extends Observable implements Runnable
    {
    
    	/**
    	 * Creates a new PictureModel.
    	 */
        public function PictureModel()
        {
            _set = new HashSet() ;
        }

    	/**
    	 * Clears the model.
    	 */
    	public function clear():void
    	{
    		_set.clear() ;
    		_it = _set.iterator() ;
    		notifyChanged( new PictureModelEvent( PictureModelEvent.CLEAR ) );	
    	}

    	/**
    	 * Returns the string representation of the current picture url.
    	 * @return the string representation of the current picture url.
    	 */
    	public function getUrl():String
    	{
    		return _url ;	
    	}

    	/**
    	 * Hide the picture.
    	 */
    	public function hide():void
    	{
    		notifyChanged(new PictureModelEvent( PictureModelEvent.VISIBLE, null, false ) ) ;		
    	}

    	/**
    	 * Inserts a new picture's url in the model, if the url exist the url isn't inserted.
    	 * @return 'true' if the url is inserted else 'false' if the url allready exist in the model.
    	 */
    	public function insertUrl( sUrl:String ):Boolean
    	{
    		var b:Boolean = _set.add( sUrl ) ;
    		trace(this + " insert : " + sUrl + " :: " + b) ;
    		return b ;
    	}

    	/**
    	 * Launch the loading of the next Picture in the model. If the model hasn't a next picture, the model load the first picture.
    	 * This method used an Iterator to keep the next url in the model. If the user use the 
    	 */
        public function run(...arguments):void
        {
        	if (_it == null)
        	{
        		_it = _set.iterator() ;	
        	}
	    	if (!_it.hasNext()) 
    		{
    			_it.reset() ;
    		}
    		var uri:String = _it.next() ;
    		trace(this + " run : " + uri) ;
    		load( uri ) ;
    	}

    	/**
    	 * Notify a PictureModelEvent when the model change.
    	 */
    	public function notifyChanged( e:PictureModelEvent ):void
    	{
    		setChanged ();
    		notifyObservers( e );	
    	}
    	
    	/**
    	 * Loads the picture defined bu the url specified in argument.
    	 * @param url the string representation of the file name to load.
    	 */
    	public function load( url:String ):void
    	{
    		_url = url ;
    		notifyChanged( new PictureModelEvent( PictureModelEvent.LOAD , _url ) ) ;
    	}
    
    	/**
    	 * Reset the internal Iterator of this model.
    	 */
    	public function reset():void
    	{
    		_it.reset() ;
    	}
    
       	/**
    	 * Show the picture.
    	 */
    	public function show():void
    	{
    		notifyChanged(new PictureModelEvent( PictureModelEvent.VISIBLE, null, true ) ) ;	
    	}
            	
    	/**
    	 * Defined the internal Iterator of this model.
    	 */
    	private var _it:Iterator ;
    	
    	/**
    	 * The internal Set of this model.
    	 */
    	private var _set:Set ;
        
        /**
         * @private
         */
        private var _url:String ;
    
    }

}