
import vegas.events.* ;

class test.events.CompoClassA implements EventTarget {

	// ----o Constructor
	
	public function CompoClassA() {
		dispatcher = new EventDispatcher ;
	}
	
	// ----o Public Properties
	
	public var dispatcher:IEventDispatcher ;

	// ----o Public Methods

	function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void {
		dispatcher.addEventListener.apply(dispatcher, [].concat(arguments)) ;
	}

	function dispatchEvent(event, isQueue:Boolean, target, context):Event {
		return dispatcher.dispatchEvent(event, isQueue, target || this, context) ;
	}

	function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener {
		return dispatcher.removeEventListener.apply(dispatcher, [].concat(arguments)) ;
	}

	public function toString():String {
		return "[CompoClassA Object]" ;
	}
	
}