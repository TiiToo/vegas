# Capturing and Bubbling event flow with VEGAS #

The **DOM event flow** is the process through which the event originates from the **DOM Events** implementation and is dispatched into a tree.

Each event has an event target, a targeted node in the case of the **DOM Event flow**, toward which the event is dispatched by the **DOM Events** implementation.

## Phases ##

The event is dispatched following a path from the root of the tree to this target node.

It can then be handled locally at the target node level or from any target's ancestors higher in the tree.

The event dispatching (also called event propagation) occurs in three phases and the following order :

  1. **The capture phase** : the event is dispatched to the target's ancestors from the root of the tree to the direct parent of the target node.
  1. **The target phase** : the event is dispatched to the target node.
  1. **The bubbling phase** : the event is dispatched to the target's ancestors from the direct parent of the target node to the root of the tree.

In **VEGAS** the phase are enumerates in the static class **vegas.event.EventPhase**.

## Event listeners ##

Each node encountered during the dispatch of the event may contain event listeners. Event listeners can be registered on all nodes in the tree for a specific type of event.

When the event is dispatched through the tree, from node to node, event listeners registered on the node are triggered if the following three conditions are all met :

  1. they were registered for the same type of event, or the same category.
  1. they were registered for the same phase.
  1. the event propagation has not been stopped for the group.

If an event listener is removed from a node while an event is being processed on the node, it will not be triggered by the current actions. Once removed, the event listener is never invoked again (unless registered again for future processing).

## Example ##

```
import vegas.events.BasicEvent ;
import vegas.events.Delegate ;
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;
import vegas.events.EventPhase ;

var getPhaseName:Function = function( phase:Number ):String
{
	switch( phase )
	{
		case EventPhase.CAPTURING_PHASE : 
		{
			return "CAPTURING_PHASE" ;
		}
		case EventPhase.AT_TARGET : 
		{
			return "AT_TARGET" ;
		}
		case EventPhase.BUBBLING_PHASE :
		{
			return "BUBBLING_PHASE" ;
		}
		default :
		{
			return "UNKNOW" ;
		}
	}
}

/**
 * Handles the event to debug the application.
 */
var debug:Function = function (e:Event ):Void
{
	trace( "# " + e.getType() + " : " + e.getCurrentTarget().getName() + " : " + getPhaseName( e.getEventPhase() ) ) ;
}

var d1:EventDispatcher = EventDispatcher.getInstance("dispatcher 1") ;
var d2:EventDispatcher = EventDispatcher.getInstance("dispatcher 2") ;
var d3:EventDispatcher = EventDispatcher.getInstance("dispatcher 3") ;
var d4:EventDispatcher = EventDispatcher.getInstance("dispatcher 4") ;

// create the tree

d1.addChild(d2) ;
d2.addChild(d3) ;
d3.addChild(d4) ;
d4.addChild(d5) ;

// Show the tree of the EventDispatcher nodes.

trace( "d1 parent : " + d1.parent.getName() ) ; // null == root of the tree
trace( "d2 parent : " + d2.parent.getName() ) ; // d1
trace( "d3 parent : " + d3.parent.getName() ) ; // d2
trace( "d4 parent : " + d4.parent.getName() ) ; // d3

var listener:EventListener = new Delegate(this, debug) ;

// register all nodes with capturing phase

d1.addEventListener( "onLogin" , listener , true ) ;
d2.addEventListener( "onLogin" , listener , true ) ;
d3.addEventListener( "onLogin" , listener , true ) ;
d4.addEventListener( "onLogin" , listener , true ) ;

// register all nodes with target and bubbling phase

d4.addEventListener( "onLogin" , listener , false ) ;
d3.addEventListener( "onLogin" , listener , false ) ;
d2.addEventListener( "onLogin" , listener , false ) ;
d1.addEventListener( "onLogin" , listener , false ) ;

// launch the event flow propagation.

d4.dispatchEvent( new BasicEvent( "onLogin" ) ) ;

```

Result of this example in the output panel :
```
# onLogin : dispatcher 1 : CAPTURING_PHASE
# onLogin : dispatcher 2 : CAPTURING_PHASE
# onLogin : dispatcher 3 : CAPTURING_PHASE
# onLogin : dispatcher 4 : AT_TARGET
# onLogin : dispatcher 3 : BUBBLING_PHASE
# onLogin : dispatcher 2 : BUBBLING_PHASE
# onLogin : dispatcher 1 : BUBBLING_PHASE
```

**Warning :** For the moment the event flow (capturing/bubbling propagation) don't work with the global event listeners (with the **addGlobalEventListener** and **removeGlobalEventListener** methods).