# Remove event listeners #

## Description ##

If you need to remove an event listener, that has been added before, you can use the **removeEventListener()** method of **EventDispatcher**.

```
import vegas.events.EventDispatcher ;
import vegas.events.EventListener   ;

var disp:EventDispatcher = EventDispatcher.getInstance() ;

var one:EventListener = new DebugHandler("one") ;
var two:EventListener = new DebugHandler("two") ;

disp.addEventListener("onLogin", one ) ;
disp.addEventListener("onLogin", two ) ;

var removed:Boolean = disp.removeEventListener( "onLogin", one ) ;
if (removed == true) 
{
    trace("The event listener has succesfully been removed.") ;
}

disp.dispatchEvent("onLogin") ;
```
The triggered event will be only caught by the **DebugHandler** named _two_.

If you added an event listener more than once, only the first occurance will be removed.

To finish this example i write the **DebugHandler** class :

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
        trace( this + " handle : " + e ) ;
        trace( "event-type     : " + e.getType()    ) ;
        trace( "event-target   : " + e.getTarget()  ) ;
        trace( "event-context  : " + e.getContext() ) ;
        trace( "event-queue    : " + e.isQueued()   ) ;
        trace("---") ;
    }
    
    /**
     * Returns the String representation of the object.
     * @return the String representation of the object.
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

## Removing global event listeners ##

You can also remove event listeners, that you added globally, using the **removeGlobalEventListener()** method.