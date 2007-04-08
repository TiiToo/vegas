
import vegas.events.* ;

class test.events.CompoClassA implements EventTarget 
{

	/**
	 * Creates a new CompoClassA instance.
	 */
	public function CompoClassA() 
	{
		dispatcher = new EventDispatcher(this) ;
	}

	/**
	 * The EventTarget reference of this class.
	 */ 
	public var dispatcher:EventTarget ;
	
	
	public function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void 
	{
		dispatcher.addEventListener.apply(dispatcher, [].concat(arguments)) ;
	}

	public function dispatchEvent(event, isQueue:Boolean, target, context):Event 
	{
		return dispatcher.dispatchEvent(event, isQueue, target || this, context) ;
	}

	public function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener 
	{
		return dispatcher.removeEventListener.apply(dispatcher, [].concat(arguments)) ;
	}

	/**
	 * Returns the String representation of this object.
	 */
	public function toString():String 
	{
		return "[CompoClassA Object]" ;
	}
	
}