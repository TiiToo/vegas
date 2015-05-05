# Event Queue #

**EventDispatcher** supports event queuing, that means, that events can be stored after they had been triggered and if you add a new listener after the event had been triggered, the event listener will receive the event right after you added it.

```
import vegas.events.BasicEvent ;
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

import test.events.DebugHandler ;

var dispatcher:EventDispatcher = EventDispatcher.getInstance() ;

var myEvent:Event = new BasicEvent("onTest", "target", "context") ;

// wait to dispatch the event
dispatcher.dispatchEvent( myEvent , true) ;
dispatcher.dispatchEvent( myEvent , true) ;

var debug:EventListener = new DebugHandler();
dispatcher.addEventListener("onTest", debug) ;
```

Although the handler was added after the event has been triggered, **EventDispatcher** will pass the event to the handler, as it has been stored in the queue.

To avoid this behaviour, set the second parameter of the call to **dispatchEvent()** to **false** or **null**, which tells **EventDispatcher** that the event should not be stored in the queue.