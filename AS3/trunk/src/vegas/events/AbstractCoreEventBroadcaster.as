package vegas.events
{
    
    import vegas.core.CoreObject;
    import vegas.events.EventBroadcaster ;

    public class AbstractCoreEventBroadcaster extends CoreObject implements IEventBroadcaster
    {
    
        // ----o Constructor
    
        public function AbstractCoreEventBroadcaster() {
        
            super() ;
    		_oED = initEventDispatcher() ;
    		
        }
        
        // ----o Public Methods
        
       	public function initEventDispatcher():EventBroadcaster {
		    return new EventDispatcher( this ) ;
	    }
        
    }
    
}