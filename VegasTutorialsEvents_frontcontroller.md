# Design pattern FrontController with VEGAS #

The Front Controller pattern defines a single **EventDispatcher** that is responsible for processing application requests.

A front controller centralizes functions such as view selection, security, and templating, and applies them consistently across all pages or views. Consequently, when the behavior of these functions need to change, only a small part of the application needs to be changed: the controller and its helper classes.

```
import vegas.events.BasicEvent ;
import vegas.events.Delegate ;
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.FrontController ;

// creating a proxy method (use Delegate)

var action:Function = function (ev:Event) 
{
	trace("> " + this + " :: " + ev.getType() + " - " + ev.getTarget()) ;
}

// creating the event listener

var listener = {} ;

listener.handleEvent = function(ev:Event):Void 
{
	trace("> " + this + " :: " + ev.getType() + " - " + ev.getTarget()) ;
}

listener.toString = function () {
	
	return "[MY_LISTENER]" ;
}

// using the front controller.

var controller:FrontController = new FrontController() ;

controller.insert("MY_EVENT1", new Delegate(this, action)) ;
controller.insert("MY_EVENT2", listener) ;

// test

EventDispatcher.getInstance().dispatchEvent( new BasicEvent("MY_EVENT1", this) ) ;

EventDispatcher.getInstance().dispatchEvent( new BasicEvent("MY_EVENT2", this) ) ;
```

you can customize the channel of your front controller with the second argument of the constructor :

```

var controller:FrontController = new FrontController( null, "myChannel" ) ;

EventDispatcher.getInstance("myChannel").dispatchEvent( new BasicEvent("MY_EVENT1", this) ) ;

```

You must use an **EventDispatcher** singleton with the channel's name of your frontcontroller to dispatch the event in the good channel.


You can use the fireEvent methods of your FrontController instances to dispatch your events in the good channel quickly.

```

import vegas.events.BasicEvent ;
import vegas.events.Delegate ;
import vegas.events.Event ;
import vegas.events.FrontController ;

var action1:Function = function (ev:Event) 
{
    trace("> action1 : " + ev.getType() ) ;
}

var action2:Function = function (ev:Event) 
{
    trace("> action2 : " + ev.getType() ) ;
}
var controller:FrontController = new FrontController( "myChannel" ) ;

controller.insert("MY_EVENT1", new Delegate(this, action1) ) ;
controller.insert("MY_EVENT2", new Delegate(this, action2) ;

// use the fireEvent method with an easy *String* event type.
controller.fireEvent( "MY_EVENT1" ) ;

// use the fireEvent method with an Event object.
controller.fireEvent( new BasicEvent( "MY_EVENT2" ) ) ;

```

The FrontController class can be used with the factory static method getInstance(channel:String)

```

import vegas.events.BasicEvent ;
import vegas.events.Delegate ;
import vegas.events.Event ;
import vegas.events.FrontController ;


var action1:Function = function (ev:Event) 
{
    trace("action1 : " + ev.getType() ) ;
}

var action2:Function = function (ev:Event) 
{
    trace("action2 : " + ev.getType() ) ;
}

var controller:FrontController = FrontController.getInstance( "myChannel" ) ;

controller.insert("MY_EVENT1", new Delegate(this, action1) ) ;
controller.insert("MY_EVENT2", new Delegate(this, action2) ;

EventDispatcher.getInstace("myChannel").dispatchEvent( "MY_EVENT1" ) ;
EventDispatcher.getInstace("myChannel").dispatchEvent( "MY_EVENT2" ) ;

```

You can read the documentation of the **FrontController** class to know all other methods of this class.