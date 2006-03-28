import vegas.events.Event ;
import vegas.events.EventListener ;

class test.events.BlackList implements EventListener {
    
	// ----o Constructor
	
	public function BlackList() {}
	

	// ----o Public Methods

	public function handleEvent(ev:Event) {
		var name:String  = ev.getContext().getUsername() ;
		if ( name == "ekameleon" ) {
			ev.cancel() ; // cancel the event
        }
    }

	public function toString():String {
		return "<BlackList>" ;
	}

	// ----o Private Properties

	private var _username:String ;
    
}