# Global event-listeners #

In some rare cases (especially for debugging purposes) it might be useful to add an event listener that catches all events that are thrown in your application.

In order to achive this, you do **not** need to register the event listener separately for each event that might be triggered, but use the **addGlobalEventListener()** instead :

```

import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

import test.events.DebugHandler ;

var disp:EventDispatcher = new EventDispatcher() ;

var global:EventListener = new DebugHandler("global") ;

// register the global event listener.
disp.addGlobalEventListener( global ) ;

disp.dispatchEvent( "onLogin"  ) ;
disp.dispatchEvent( "onLogout" ) ;


// unregister the global event listener.
disp.removeGlobalEventListener(global) ;

disp.dispatchEvent( "onLogin"  ) ;
disp.dispatchEvent( "onLogout" ) ;

```

This event listener will now be called for both events, the **onLogin** and the **onLogout** event.

However, you should be aware, that global event listeners are processed after all local event listeners handled the event.

The **removeGlobalEventListener()** method unregister the global event listener.

In VEGAS you can apply a global event listener with the method addEventListener and the **magic type** : **"ALL"**


```

import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

import test.events.DebugHandler ;

var disp:EventDispatcher = new EventDispatcher() ;

var global:EventListener = new DebugHandler() ;

// register the global event listener.
disp.addEventListener( "ALL", global ) ;

disp.dispatchEvent( "onLogin"  ) ;
disp.dispatchEvent( "onLogout" ) ;


// unregister the global event listener.
disp.removeEventListener( "ALL", global ) ;

disp.dispatchEvent( "onLogin"  ) ;
disp.dispatchEvent( "onLogout" ) ;

```

NB : In this examples, the **DebugHandler** class is an easy **EventListener** implementation.

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
    public function DebugHandler(){}
    
    /**
     * Handles the event.
     */
    public function handleEvent(e:Event) 
    {
        trace( this + " handled event : " + e.getType() ) ;
    }
    
    /**
     * Returns the String representation of the object.
     * @return the String representation of the object.
     */
    public function toString():String 
    {
        return "[DebugHandler]" ;
    }
    
    /**
     * The internal private name property of this instance.
     */
    private var _name:String ;
    
}
```