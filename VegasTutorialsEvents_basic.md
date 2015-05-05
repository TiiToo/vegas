# Basic Example (real-life example) #

I need to use a typical use case.

Imagine, you have an authentication mechanism in your application, which could be implemented like this :
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
This example is an extremely easy example of authentification application to illustrate a real-life application with the model events of **VEGAS**.

Now you want to display the user a login page in the ActionScript application and write a logfile if somebody successfully logged in and another logfile, if the authentication failed :
```
import test.events.Author ;

var user:Author = new Author() ;
var result:Boolean = user.authenticate( username, password ) ;
if ( result ) 
{
    trace("log success....") ;
}
else 
{
    trace("log failed...") ;
}
```

Although this code will work, it can be greatly improved using a more flexible approach and the **EventDispatcher** package :
```
import test.events.Author ;

var disp:EventDispatcher = new EventDispatcher() ;

var user:Author = new Author() ;
var result:Boolean = user.authenticate( username, password ) ;
if ( result ) 
{
    disp.dispatchEvent("onLogin", user) ;
}
else 
{
    disp.dispatchEvent("onFail", user) ;
}
```

Instead of writing any logfiles you are just triggering new events. To actually write the logfiles, you need to register event listeners prior to launching your application.

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
        
        trace("AuthorLogger : Event has been triggered");
        
        trace( "event-type   : " + type ) ;
        trace( "event-target : " + author ) ;
        trace( "author-name  : " + name ) ;
        
        trace("---") ;
        
    }
}
```
To finish this example, a little script in the main script of your application :
```
import vegas.events.BasicEvent ;
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

import test.events.Author ;
import test.events.AuthorLogger ;

var log:EventListener    = new AuthorLogger() ;
var disp:EventDispatcher = new EventDispatcher() ;

disp.addEventListener("onLogin" , log) ;
disp.addEventListener("onFail"  , log) ;

var user1:Author = new Author() ;
var result:Boolean = user1.authenticate("ekameleon", "mypass") ;
if ( result ) 
{
    disp.dispatchEvent( new BasicEvent("onLogin", user1) ) ;
}
else 
{
    disp.dispatchEvent( new BasicEvent("onFail", user1) ) ;
}

var user2:Author = new Author() ;
var result:Boolean = user2.authenticate("ekameleon", "otherPass") ;
if ( result ) 
{
    disp.dispatchEvent( new BasicEvent("onLogin", user2) ) ;
}
else 
{
    disp.dispatchEvent( new BasicEvent("onFail", user2) ) ;
}
```
This way, you've achieved a clean separation of the logging code from the business logic. At a first glance, it seems a lot more complicated, than just checking the return value of authenticate() and then writing a logfile, but this approach has several benefits :

  * remove all logging functionality, by just removing the **addEventListener()** calls, or with the **removeEventListener()** method.
  * add logging to any other event (e.g. onLogout) by just adding the event listener to this event.
  * change the logging code to anything else (e.g. sending mails) without touching the business logic.