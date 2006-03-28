
import vegas.events.Event ;
import vegas.events.EventListener;

class test.events.DebugHandler implements EventListener {

	// ----o Constructor
	
	public function DebugHandler(name) {
		_name = name || "noName" ;
	}
	
	// ----o Public Methods

	public function getName():String {
		return _name ;
	}

    public function handleEvent(e:Event) {
        trace("-------- DebugHandler : Event has been triggered.");
        trace("Event type     : " + e.getType()) ;
        trace("Event target   : " + e.getTarget()) ;
        trace("Event context  : " + e.getContext()) ;
        trace("Event in queue : " + e.isQueued()) ;
    }
	
	public function toString():String {
		return "<DebugHandler>" + _name + "</DebugHandler>" ;
	}
	
	// ----o Private Properties
	
	private var _name:String ;
	
}