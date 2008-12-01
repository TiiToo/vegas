
package observer.controller
{
    import andromeda.util.observer.Observable;
    import andromeda.util.observer.Observer;
    
    import observer.display.PictureDisplay;
    import observer.event.PictureModelEvent;
    import observer.visitor.*;    

    /**
     * This observer of the picture display.
     * @author eKameleon
     */
    public class PictureObserver implements Observer
    {
    
    	/**
    	 * Creates a new PictureObserver instance.
    	 * @param picture The PictureDisplay to control.
    	 */
        public function PictureObserver(  picture:PictureDisplay  )
        {
            _picture = picture ;
        }
       
    	/**
    	 * This method is called whenever the observed object is changed.
    	 * @param o the observable object.
    	 * @param arg an argument passed to the notifyObservers method.
	     */
        public function update(o:Observable, arg:*):void
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
    			    trace(this + ' update : ' + o + ' : ' + event.type + " " + event.url ) ;
    				_picture.accept( new LoaderVisitor( event.url ) ) ;
    				break ;
    			}

	    		case PictureModelEvent.VISIBLE :
    			{
    				trace(this + ' update:' + o + ' type:' + event.type + " visible:" + event.visible) ;
    				if ( event.visible )
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
        
        /**
         * @private
         */
    	private var _picture:PictureDisplay ;


    }
}