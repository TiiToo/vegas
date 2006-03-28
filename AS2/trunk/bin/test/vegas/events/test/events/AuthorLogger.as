
import vegas.events.Event ;
import vegas.events.EventListener ;

class test.events.AuthorLogger implements EventListener {
    
	// ----o Constructor
	
	public function AuthorLogger() {
		//
	}
	
	// ----o Public Methods
    
    public function handleEvent(e:Event) {
        
		var eventType:String = e.getType();
		var eventContext = e.getContext();
		var eventTarget = e.getTarget();
        var username:String = e.getContext().getUsername() ;
        
		trace("-------- AuthorLogger : Event has been triggered");
		trace("event-type    : " + eventType) ;
		trace("event-context : " + eventContext) ;
		trace("event-target : " + eventTarget) ;
		// now place the logging code here...
		
    }
}