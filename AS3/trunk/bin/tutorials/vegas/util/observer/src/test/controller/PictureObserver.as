package test.controller
{
    
    import test.display.PictureDisplay;
    import test.events.PictureModelEvent;
    import test.visitors.*;
    
    import vegas.core.CoreObject;
    import vegas.util.observer.IObserver;
    import vegas.util.observer.Observable;

    /**
     * This observer of the picture display.
     * @author eKameleon
     */
    public class PictureObserver extends CoreObject implements IObserver
    {
    
    	/**
    	 * Creates a new PictureObserver instance.
    	 */
        public function PictureObserver(  picture:PictureDisplay  )
        {
            super();
            _picture = picture ;
        }
       
    	/**
    	 * This method is called whenever the observed object is changed.
    	 * @param o the observable object.
    	 * @param arg an argument passed to the notifyObservers method.
	     */
        public function update(o:Observable, arg:*):*
        {
	        var event:PictureModelEvent = arg as PictureModelEvent ;
		    
		    switch (event.type)
    		{
			
	    		case PictureModelEvent.CLEAR :
		    	{
			    	_picture.accept( new ClearVisitor() ) ;
    				break ;
    			}

	    		case PictureModelEvent.LOAD :
    			{
    			    trace(this + ' update : ' + o + ' : ' + event.type + " " + event.getUrl()) ;
    				_picture.accept( new LoaderVisitor(event.getUrl()) ) ;
    				break ;
    			}

	    		case PictureModelEvent.VISIBLE :
    			{
    			    
    				var isVisible:Boolean = event.isVisible() ;
    				
    				trace(this + ' update : ' + o + ' : ' + event.type + " " + isVisible) ;
    				
    				if (isVisible)
    				{
	    				_picture.accept(new ShowVisitor()) ;
    				}
	    			else
    				{
    					_picture.accept(new HideVisitor()) ;
    				}
    				break ;
    			}
    				
            }
        }

    	private var _picture:PictureDisplay ;


    }
}