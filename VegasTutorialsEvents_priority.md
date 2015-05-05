# EventListener priority #

When you register an event listener with the addEventListener method of the EventDispatcher class you can apply a priority over your event listener.

The priority is designated by an uint value( an integer > 0 ).

The higher the number, the higher the priority. All listeners with priority **n** are processed before listeners of priority **n-1**.

If two or more listeners share the same priority, they are processed in the order in which they were added.

The default priority is **0**.

```

import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;
import vegas.events.Delegate ;

function debug( ev:Event, msg:String ):Void 
{
	trace ( "debug " + ev.getType() + " message -> " + msg ) ;
}

var listener1:EventListener = new Delegate(this, debug,  "listener1") ;
var listener2:EventListener = new Delegate(this, debug,  "listener2") ;
var listener3:EventListener = new Delegate(this, debug,  "listener3") ;
var listener4:EventListener = new Delegate(this, debug,  "listener4") ;

var dispatcher:EventDispatcher = new EventDispatcher() ;

dispatcher.addEventListener("onTest", listener1, false, 3) ;
dispatcher.addEventListener("onTest", listener2, false, 1) ;
dispatcher.addEventListener("onTest", listener3, false, 2) ;
dispatcher.addEventListener("onTest", listener4, false, 1000) ; // high priority

dispatcher.dispatchEvent( { type : "onTest", target : this } ) ;

}

```

The result of the previous script in the output panel :

```
debug onTest message -> listener4
debug onTest message -> listener1
debug onTest message -> listener3
debug onTest message -> listener2
```