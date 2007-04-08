
/**
 * The Author class.
 */
class test.events.Author 
{
    
    /**
     * Creates a new Author instance.
     */ 
    public function Author() {}
    
    static private var USER:String = "ekameleon" ;
    
    static private var PASS:String = "mypass" ;
    
    /**
     * Authentificate the specified user.
     */ 
    public function authenticate(user:String, pass:String):Boolean 
    {
        
        if (user == Author.USER && pass == Author.PASS ) 
        {
           
           _username = user ;
            return true ;
            
        }
        
        return false ;
    }


    /**
     * Clear the authentification of the current author.
     */
    public function clearAuthentification():Void 
    {
        _username = null;
    }

    /**
     * Returns the name of the user.
     */
    public function getUsername():String 
    {
        return _username ;
    }

    /**
     * Returns the String representation of the object.
     */
    public function toString():String 
    {
        var txt:String = "[Author" ;
        if (_username) 
        {
            txt += ", name:" + _username ;
        }
        txt += "]" ;
        return txt ;
    }

    private var _username:String ;
    
}

