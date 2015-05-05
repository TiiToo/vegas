# Multi EventDispatcher & singletons #

You can create instances of the **EventDispatcher** class with the **new** key words, but you can creates statically singleton references of the class with the static method **getInstance()**.

This approach has been taken, to be able to allow more than one global dispatcher instance per application.

The **getInstance()** method accepts a **name** for the dispatcher as its sole parameter, so you can easyily create as many dispatchers as you need and still easily identify them :

```

import vegas.events.EventDispatcher ;

var default:EventDispatcher = EventDispatcher.getInstance() ; // no value in argument

var user:EventDispatcher  = EventDispatcher.getInstance("user") ;

var debug:EventDispatcher = EventDispatcher.getInstance("debug") ;

```

The name of the singleton **EventDispatcher** reference represents a **channel** to dispatch the events in your application.

You can retreive the name of the singleton reference with the read-only property **name** of the singleton.

```

var user:EventDispatcher  = EventDispatcher.getInstance("user") ;
trace( "The name of the user dispatcher : " + user.getName() ) ;

```

To add listeners you now only need to know, which dispatcher is responsible for the events you need to handle.

In web applications, you can also use this to create a new dispatcher for each session of your application.

This feature is really useful to implement the **Design Pattern FrontController** with **VEGAS**.

You can remove singleton reference with the static methods **removeInstance()** or **release()**.

```


import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;

var logger:EventDispatcher  = EventDispatcher.getInstance("logger") ;
var user:EventDispatcher  = EventDispatcher.getInstance("user") ;

var isRemove:Boolean = EventDispatcher.removeInstance( "user" ) ;
trace( "The 'user' EventDispatcher singleton is removed : " + isRemove ) ;

var logger:EventDispatcher = EventDispatcher.release("logger") ;
trace( "The 'logger' EventDispatcher is released : " + logger ) ;

```

The static **removeInstance()** returns **true** if the **removeInstance()** method is success.

The static **release()** method remove the singleton if the internal static **Map** of the **EventDispatcher** class but returns the reference of this singleton.

If you want clean all the singleton references of the **EventDispatcher** class, you can use the **flush()** method :


```

import vegas.events.EventDispatcher ;

var default:EventDispatcher = EventDispatcher.getInstance() ;
var user:EventDispatcher  = EventDispatcher.getInstance("user") ;
var debug:EventDispatcher = EventDispatcher.getInstance("debug") ;

EventDispatcher.flush() ; // Removes all singletons of the EventDispatcher class

```