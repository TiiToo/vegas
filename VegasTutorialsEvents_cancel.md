# Cancelling events #

Event listeners can not only act on events, they can even modify them. One of the most important feature is, that event listeners can cancel (i.e. abbort) the event.

The following piece of code is an example of how easy it can be to implement a blacklist-check for a shown login mechanism :

```
import test.events.Author ;

import vegas.core.CoreObject ;
import vegas.events.Event ;
import vegas.events.EventListener ;
import vegas.util.ArrayUtil ;

class test.events.BlackList extends CoreObject implements EventListener 
{
    
    /**
     * Creates a new BlackList instance.
     */
    public function BlackList() {}
    
    /**
     * The static 'black list' array representation.
     */
    static public var BLACK_LIST:Array = [ "ekameleon" , "kronos" ] ;
    
    /**
     * Handles the event.
     */
    public function handleEvent(ev:Event) 
    {
        
        var name:String  = Author( ev.getContext() ).getUsername() ;
        
        if ( ArrayUtil.contains( BLACK_LIST, name ) ) 
        {
            ev.cancel() ; // cancel the event
        }
        
    }
}
```

This **blacklist** check compares the **username** to the users that are blocked, and if a blocked user tries to login, it cancels the event. Now all you need to to, is add this event listener to the dispatcher.

```

import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

import test.events.Author ;
import test.events.AuthorLogger ;
import test.events.BlackList ;

var check:EventListener = new BlackList() ;
var log:EventListener = new AuthorLogger() ;

var d:EventDispatcher = EventDispatcher.getInstance() ;

d.addEventListener("onLogin", check) ;
d.addEventListener("onLogin", log) ;
d.addEventListener("onFail", log) ;
```

If the user now logs into the site and the username is **"ekameleon"**, the **Blacklist** listener will cancel the event.

If the event is cancelled, it will not be propagated to all following event listeners and thus, there will be no log written for this user.



```
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

import test.events.Author ;
import test.events.AuthorLogger ;
import test.events.BlackList ;

var check:EventListener = new BlackList() ;
var log:EventListener = new AuthorLogger() ;

var d:EventDispatcher = EventDispatcher.getInstance() ;

d.addEventListener("onLogin", check) ;
d.addEventListener("onLogin", log) ;
d.addEventListener("onFail", log) ;

// ---- pass invalid

var author:Author = new Author() ;
var result:Boolean = author.authenticate("ekameleon", "mypass") ;
if ( result )
{
	var e:Event = d.dispatchEvent("onLogin", null, this, author) ;

	if ( e.isCancelled() ) 
	{
		author.clearAuthentification() ;
		d.dispatchEvent("onFail", null, this, author) ;
	}
	
}
else 
{
	d.dispatchEvent("onFail", null, "target", author) ;
}

```
Don't forget the modification of the **author** reference with the **clearAuthentification** method.

So all you had to do is add three lines of code and your application is even more flexible, as you can add any checks wihtout modifying the business logic.

Now you can ban users based on any criteria or even ban all users if you need to do some maintanance work by just adding a new event handler.

I write at the end of this example the description of the two class **AuthorLogger** and **Author** :

**The Author class**

```

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

```

**The AuthorLogger class**

```
import test.events.Author ;

import vegas.events.Event ;
import vegas.events.EventListener ;

class test.events.AuthorLogger implements EventListener 
{
    
    /**
     * Creates a new AuthorLogger instance.
     */
    public function AuthorLogger() 
    {
        //
    }
    
    /**
     * Handle the event.
     */
    public function handleEvent(e:Event) 
    {
        
        var type:String   = e.getType();
        var author:Author  = Author( e.getTarget() ) ;
        var name:String   = author.getUsername() ;
        
        trace("-------- AuthorLogger : Event has been triggered");
        
        trace( "event-type   : " + type ) ;
        trace( "event-target : " + author ) ;
        trace( "author-name  : " + name ) ;
        
    }
}
```