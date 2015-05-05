# The Delegate event listener #

The **Delegate** class is an event listener, that is included in the vegas.event.**distribution.**

It acts as a proxy to any method of any object that you want to use as a handler for the events.

```

import vegas.events.BasicEvent ;
import vegas.events.Delegate ;
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

var debug = function(ev:Event) 
{
	trace("debug :: " + this + " : " + ev.getType()) ;
}

var listener:EventListener = new Delegate(this, debug) ;

var oDispatcher:EventDispatcher = EventDispatcher.getInstance("myDispatcher") ;
oDispatcher.addEventListener("onTest", listener) ;

oDispatcher.dispatchEvent( new BasicEvent("onTest", this, "Hello World") ) ;

```

The **Delegate** class was originally created by Mike Chambers for Macromedia mx.events package in FlashMX 2004.

The Delegate class can be used with the static method **create** to create a proxy with a specified scope object and a specified method. The result of the static **create** method is a new virtual **Function**.

```

var listener:Object = {} ;
listener.toString = function()
{
   return "[listener]" ;
}    

var method:Function = function()
{
    trace (this + " method(" + arguments + ")" ) ;
}

var proxy:Function = Delegate.create( listener , method, "arg1", "arg2" ) ;

proxy("arg3", "arg4")  ; // [listener] method(arg1,arg2,arg3, arg4)

```

In **VEGAS**, the **Delegate** class can be instantiate with the **new** key word and implements the **EventListener** interface.

This class is very useful to create an event listener with all scope object and all methods that you want.

In the **vegas.events** package you can use the **EventListenerProxy** class, this class inherit from the **Delegate** class. The difference between the two class are in the second argument constructor of the class. You can use a **Function** but you can use a **String** too. The second argument can be the name of the method to call over the scope object passed-in first parameter.

**Example :**

```
import vegas.events.Event ;

/**
 * The AnyClass class
 */
class test.events.AnyClass 
{

    /**
     * Creates a new AnyClass object.
     */
    public function AnyClass() {}
    
    /**
     * The login method of this class.
     */
    public function login( ev:Event ) 
    {
        trace ( this + " -> login method : " + ev.getType() ) ;
    }
    
    /**
     * Returns the String representation of the object.
     */
    public function toString():String 
    {
        return "[AnyClass]" ;
    }
    
}
```

And now i want use this class to creates an event listener with the method **login**.

```

import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;
import vegas.events.EventListenerProxy ;

import test.events.AnyClass ;

var myObj:AnyClass = new AnyClass();

var listener:EventListener = new EventListenerProxy(myObj, "login") ;

var dispatcher:EventDispatcher = new EventDispatcher() ;

dispatcher.addEventListener("onLogin", listener) ;

dispatcher.dispatchEvent( { type : "onLogin", target : this } ) ; // [AnyClass] -> login method : onLogin

```