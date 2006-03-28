
import vegas.events.Event ;

class test.events.Author {
    
	// ----o Constructor
	
	public function Author() {}
	
	// ----o Static
	
	static private var USER:String = "ekameleon" ;
	static private var PASS:String = "mypass" ;
	
	// ----o Public Methods

    public function authenticate(user:String, pass:String):Boolean {
        if (user == Author.USER && pass == Author.PASS ) {
            _username = user ;
            return true ;
        }
        return false ;
    }
    
	public function getUsername():String {
        return _username;
    }
	
    public function clearAuthentification():Void {
        _username = null;
    }
	
	public function toString():String {
		var txt:String = "<Author" ;
		if (_username) {
			txt += ">" ;
			txt += _username ;
			txt += "</Author>" ;
		} else {
			txt += "/>" ;
		}
		return txt ;
	}

	// ----o Private Properties

	private var _username:String ;
    
}

