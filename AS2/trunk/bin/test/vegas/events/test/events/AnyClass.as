
import vegas.events.Event ;
import test.events.Author ;

class test.events.AnyClass {

	// ----o Constructor
	
	public function AnyClass() {}
	
	// ----o Public Methods

    public function login( ev:Event ) {
		trace (this + " -> login method : " + ev) ;
		trace ("type : " + ev.getType()) ;
		trace ("target : " + ev.getTarget()) ;
		trace ("context : " + ev.getContext()) ;
    }
	
	public function toString():String {
		return "[AnyClass Object]" ;
	}
	
}