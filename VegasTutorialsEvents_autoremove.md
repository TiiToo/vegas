# Using Auto-remove feature #

In some cases you want an event listener only to handle one event of a certain type. you can use the last boolean argument of the **addEventListener()** method with the value **true** to remove the event listener when the listener receive for the first time an event dispatching by the current EventDispatcher instance or singleton.

```
import vegas.events.BasicEvent ;
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

import test.events.DebugHandler ;

var debug:EventListener = new DebugHandler();
var dispatcher:EventDispatcher = EventDispatcher.getInstance() ;

var myEvent:Event = new BasicEvent("onTest", this, "context") ;

dispatcher.addEventListener("onTest", debug, false, null, true) ; // autoRemove = true

dispatcher.dispatchEvent( myEvent ) ;
dispatcher.dispatchEvent( myEvent ) ; // autoRemove the listener, this event can't be handle.
```

It is also possible to use the auto-remove feature in conjunction with global event listeners, which allows to only to catch the first event that is triggered, regardless of the event type.

Complete the previous example with this script :

```
dispatcher.addGlobalEventListener(debug, null, true) ; // autoRemove Global listener

dispatcher.dispatchEvent("onTest") ;
dispatcher.dispatchEvent("onTest") ;
```