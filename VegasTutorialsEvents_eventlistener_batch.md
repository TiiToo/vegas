# Batch your event listeners #

With the **EventListenerBatch** class you can handle several **EventListener** as one **EventListener**.

```
import vegas.events.BasicEvent ;
import vegas.events.Delegate ;
import vegas.events.Event ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;
import vegas.events.EventListenerBatch ;

var EVENT_TYPE:String = "onTest" ;

var action1:Function = function (e:Event):Void 
{
	trace ("> action1 : " + e.getType()) ;
}

var action2:Function = function (e:Event):Void 
{
	trace ("> action2 : " + e.getType()) ;
}

var oListener1:EventListener = new Delegate(this, action1) ;
var oListener2:EventListener = new Delegate(this, action2) ;

var batch:EventListenerBatch = new EventListenerBatch() ;
batch.insert(oListener1) ;
batch.insert(oListener2) ;

var e:Event = new BasicEvent( EVENT_TYPE , this ) ;

EventDispatcher.getInstance().addEventListener(EVENT_TYPE, batch) ;
EventDispatcher.getInstance().dispatchEvent( e ) ;
```

Result of this script :

```
> action1 : onTest
> action2 : onTest
```