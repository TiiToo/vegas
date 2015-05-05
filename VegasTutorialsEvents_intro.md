# Event Model : Introduction #

To use the **EventDispatcher** class with VEGAS you must creates 3 objects : the dispatcher, the eventlistener and the event.

To explain how **EventDispatcher** works, i start off with a suite of very simple examples :

**1 - Creating an event listener**

The EventListener interface must be implemented by your listener with the **handleEvent(e:Event)** method. For example you can create a new class to debug the propagation of the events with all your **EventDispatcher** reference or singletons.

```
import vegas.events.Event ;
import vegas.events.EventListener;

/**
 * The DebugHandler class.
 */
class test.events.DebugHandler implements EventListener 
{

    /**
     * Creates a new DebugHandler instance.
     */
    public function DebugHandler(name) 
    {
        _name = name || "default" ;
    }
	
    /**
     * Returns tne name of the debugger.
     */
    public function getName():String 
    {
        return _name || "" ;
    }

    /**
     * Handles the event.
     */
    public function handleEvent(e:Event) 
    {
        trace( "-------- DebugHandler : Event has been triggered." ) ;
        trace( "Event type     : " + e.getType()    ) ;
        trace( "Event target   : " + e.getTarget()  ) ;
        trace( "Event context  : " + e.getContext() ) ;
    }
	
    /**
     * Returns the String representation of the object.
     */
     public function toString():String 
     {
          return "[DebugHandler name:" + _name + "]" ;
     }
	
     /**
      * The internal private name property of this instance.
      */
     private var _name:String ;
	
}
```
When this listener receives an event, it only displays the type of the event, the context of the event and the target of the dispatcher.

**2 - Registering an event listener**

Registering this listener for an event is extremely easy. At first you need to use an instance of event dispatcher (an instance who implement the **EventTarget** or **IEventDispatcher** class).

You can now create a new instance of the **DebugHandler** you just implemented and pass it to the **addEventListener** method. This method requires two parameters to be set (the other parameters are optionals).

The first parameter is the **type** or the **event name** of the event for which you want to register the listener.

The second parameter is the listener instance.

```
import vegas.events.EventListener ;
import vegas.events.EventDispatcher ;

import test.events.DebugHandler ;

var listener:EventListener = new DebugHandler();

var disp:EventDispatcher = new EventDispatcher() ;
disp.addEventListener( "onLogin", listener ) ;
```

**3 - Dispatching an event**

To dispatch an event you call the **dispatchEvent()** method and pass in the **type** of the event as the first parameter to the method.

```
import vegas.events.BasicEvent ;
import vegas.events.EventListener ;
import vegas.events.EventDispatcher ;

import test.events.DebugHandler ;

var listener:EventListener = new DebugHandler();

var disp:EventDispatcher = new EventDispatcher() ;
disp.addEventListener( "onLogin", listener ) ;

disp.dispatchEvent( new BasicEvent("onLogin", this, "the context") ;

```

The **dispatchEvent()** method has various signature

`dispatchEvent( event , isQueue:Boolean, target, context):Event`

The first _event_ parameter can be a class who implements the **Event** interface (basically a class who extends the **BasicEvent** class or directly the **BasicEvent** class).

This first parameter can be too a **String** value who represents the **type** of the new **Event** to creates in the method.

```
import vegas.events.BasicEvent ;
import vegas.events.Event ;
import vegas.events.EventListener ;
import vegas.events.EventDispatcher ;

import test.events.DebugHandler ;

var listener:EventListener = new DebugHandler();

var disp:EventDispatcher = new EventDispatcher() ;
disp.addEventListener( "onLogin", listener ) ;

var e:Event = disp.dispatchEvent( "onLogin", this ) ;

trace(e) ; // output : [BasicEvent]

```

The **dispatchEvent()** method use my tool class [vegas.util.factory.EventFactory](http://vegas.googlecode.com/svn/trunk/AS2/trunk/src/vegas/util/factory/EventFactory.as) to creates the new **Event**.

you can use the optionals **target** and **context** parameter to complete the creation of your event.

The second parameter of the method defines, whether you want the event to be queued (more about queueing later in an other page of this wiki).

The **dispatchEvent()** method will return the created Event object, which contains the context , the type, the target and all informations of your event to be dispatch.