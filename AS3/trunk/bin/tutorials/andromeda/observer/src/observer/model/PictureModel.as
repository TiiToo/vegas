package observer.model
{
	import andromeda.util.observer.Observable;
	
	import observer.event.PictureModelEvent;
	
	import vegas.core.IRunnable;
	import vegas.data.Set;
	import vegas.data.iterator.Iterator;
	import vegas.data.sets.HashSet;    

	/**
     * The model to change the Picture with differents external files.
     * @author eKameleon
     */
    public class PictureModel extends Observable implements IRunnable
    {
    
    	/**
    	 * Creates a new PictureModel.
    	 */
        public function PictureModel()
        {
        	_eClear = new PictureModelEvent( PictureModelEvent.CLEAR) ;
    		_eLoad = new PictureModelEvent( PictureModelEvent.LOAD) ;
    		_eVisible = new PictureModelEvent( PictureModelEvent.VISIBLE ) ;
    		_set = new HashSet() ;
        }

    	/**
    	 * Clears the model.
    	 */
    	public function clear():void
    	{
    		_set.clear() ;
    		_it = _set.iterator() ;
    		notifyChanged( _eClear );	
    	}

    	/**
    	 * Returns the string representation of the current picture url.
    	 * @return the string representation of the current picture url.
    	 */
    	public function getUrl():String
    	{
    		return _eLoad.getUrl() ;	
    	}

    	/**
    	 * Hide the picture.
    	 */
    	public function hide():void
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
    		var b:Boolean = _set.insert( sUrl ) ;
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
    	 * @param uri the string representation of the file to load.
    	 */
    	public function load( uri:String ):void
    	{
    		_eLoad.setUrl( uri ) ;
    		notifyChanged( _eLoad ) ;
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
}