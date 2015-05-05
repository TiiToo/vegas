# The AbstractCoreEventDispatcher class #

## Description ##

The **vegas.events.AbstractCoreEventDispatcher** class is an abstract class who implements the **IEventDispatcher** interface.

This class used the **composition** pattern with an internal **vegas.events.EventDispatcher** reference. By default the internal **EventDispatcher** reference is initialized with the public  method **initEventDispatcher()**. This method return an internal **local EventDispatcher** reference.

The **AbstractCoreEventDispatcher** constructor is private and implement an **abstract factory** pattern . You must inherit this class with your custom class. In **VEGAS** and this extensions the AbstractCoreEventDispatcher is really important.

## The setGlobal method ##

The difference between the **EventDispatcher** class and the **AbstractCoreEventDispatcher** class is the special method : **setGlobal( flag:Boolean , channel:Boolean)**.

The **setGlobal** method modify the internal **EventDispatcher** reference of the **AbstractCoreEventDispatcher** class to dispatch the events of the **EventTarget** object in the global event flow.

If you use this method with a passed-in **true** flag parameter, the AbstractCoreEventDispatcher object used an **EventDispatcher** singleton reference created by the **EventDispatcher.getInstance()** method.

The second argument **channel** is the name of the singleton **EventDispatcher** used to dispatch the events and register the **EventListener** references.

You can use the two arguments **flag** and **channel** in the constructor of the class to initialize your dispatcher when you creates it.

## Example ##

First, we must implement a **GlobalEventDispatcher** class to test the **AbstractCoreEventDispatcher** features.

```

import vegas.events.AbstractCoreEventDispatcher ;
import vegas.events.BasicEvent ;
import vegas.events.Event ;

class test.events.GlobalEventDispatcher extends AbstractCoreEventDispatcher
{

	/**
	 * Creates a new GlobalEventDispatcher instance.
	 */
	public function GlobalEventDispatcher( bGlobal:Boolean , sChannel:String  ) 
	{
		
		super( bGlobal , sChannel ) ;	
		
		initEvents() ;
		
	}

	
	static public var CHANGE:String = "onChanged" ;

	/**
	 * Sets the type of the change event.
	 */
	public function getEventTypeCHANGE():String
	{
		return _eChange.getType() ;
	}

	/**
	 * Initialize the events.
	 */
	public function initEvents():Void
	{
		_eChange = new BasicEvent( CHANGE , this ) ;
	}

	/**
	 * Sets the type of the change event.
	 */
	public function setEventTypeCHANGE( type:String ):Void
	{
		_eChange.setType( type ) ;
	}
	
	/**
	 * Update the object.
	 */
	public function update():Void 
	{
		dispatchEvent( _eChange ) ;
	}
	
	/**
	 * The internal event to notify a change.
	 */
	private var _eChange:Event ;
	
}
```

This class can trigger a **BasicEvent** if the **update** method is called. The event is initialize in the constructor of the class with the method **initEvents**

By default, the type valye of the event is determinates by the static property **CHANGE** with the value **"onChanged"**.

Now we can use the difference between the local and the global difference of this class.

### Basic example (local EventDispatcher reference) ###

```

import test.events.GlobalEventDispatcher ;

import vegas.events.Event ;
import vegas.events.Delegate ;

var change:Function = function( e:Event ):Void
{
	trace( e.getTarget() + " " + e.getType() ) ;	
}


var dispatcher:GlobalEventDispatcher = new GlobalEventDispatcher() ;
dispatcher.addEventListener( GlobalEventDispatcher.CHANGE, new Delegate(this, change)) ;

dispatcher.update() ;

```

This classical example is easy. No comment about it ;)

### Global event flow with FrontController ###

The best example to illustrate the global feature of the **AbstractCoreEventDispatcher** inherit class is the **FrontController** pattern.

```
import test.events.DebugHandler ;
import test.events.GlobalEventDispatcher ;

import vegas.events.Event ;
import vegas.events.Delegate ;
import vegas.events.FrontController ;

var GLOBAL_CHANGE:String = "onGlobalChanged" ;

// creates the frontcontroller of the application

var controller:FrontController = new FrontController( "global_channel" ) ;

// insert a controller in the frontcontroller with the type GLOBAL_CHANGE
controller.insert ( GLOBAL_CHANGE , new DebugHandler( "global debug" ) ) ;

// creates a global reference of the GlobalEventDispatcher class.
var dispatcher:GlobalEventDispatcher = new GlobalEventDispatcher( true , "global_channel" ) ;

// change the type name of the event invoqued to notify a change in the 'update' method.
dispatcher.setEventTypeCHANGE( GLOBAL_CHANGE ) ;

// test the update method.
dispatcher.update() ;
```

The output of this example is explicite !

```
[DebugHandler name:global debug] handle : [BasicEvent onGlobalChanged, AT TARGET, bubbles]
event-type     : onGlobalChanged
event-target   : [GlobalEventDispatcher]
event-context  : undefined
event-queue    : false
```

Now the object used a global event flow to notify this events in the global front controller of the application. The DebugHandler event listener reference handles the event when the frontcontroller receive the event dispatched in the update method of the **GlobalEventDispatcher** reference.

## Conclusion ##

The **AbstractCoreEventDispatcher** class is an important implementation in **VEGAS**. I used this class to creates the models in my applications and switch the event flow of this objects in the global event flow of the application.

This class is important to implement a global **MVC design pattern**.
