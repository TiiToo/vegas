
package observer.controller
{
	import andromeda.util.observer.IObserver;
	import andromeda.util.observer.Observable;
	
	import observer.display.PictureDisplay;
	import observer.event.PictureModelEvent;
	import observer.visitor.ClearVisitor;
	import observer.visitor.HideVisitor;
	import observer.visitor.LoaderVisitor;
	import observer.visitor.ShowVisitor;
	
	import vegas.core.CoreObject;	

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