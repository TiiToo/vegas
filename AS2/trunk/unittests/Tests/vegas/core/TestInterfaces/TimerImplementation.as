
import vegas.core.ITimer;
import vegas.events.Event;
import vegas.events.EventListener;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.TimerImplementation implements ITimer 
{
	
	private var _delay:Number ;
	private var _repeatCount:Number ;
	
	public var isAddEventListener:Boolean = false ;
	public var isClear:Boolean = false ;
	public var isRestart:Boolean = false ;
	public var isRunning:Boolean = false ;
	public var isStarted:Boolean = false ;
	public var isStopped:Boolean = false ;

	public function addEventListener(eventName : String, listener : EventListener, useCapture : Boolean, priority : Number, autoRemove : Boolean) : Void 
	{
		isAddEventListener = true ;
	}

	public function clear():Void 
	{
		isClear = true ;
	}

	public function dispatchEvent(event, isQueue : Boolean, target, context) : Event 
	{
		return new Event() ;
	}

	public function getDelay():Number 
	{
		return _delay ;
	}

	public function getRepeatCount():Number 
	{
		return _repeatCount ;
	}

	public function restart(noEvent:Boolean) : Void 
	{
		isRestart = true ;
	}

	public function run() : Void 
	{
		isRunning = true ;
	}

	public function start():Void
	{
		isStarted = true ;
	}

	public function setDelay(n:Number) : Void 
	{
		_delay = n ;
	}

	public function setRepeatCount(n : Number) : Void 
	{
		_repeatCount = n ;
	}

	public function stop() : Void 
	{
		isStopped = true ;
	}

	public function removeEventListener(eventName : String, listener, useCapture : Boolean) : EventListener 
	{
		return new EventListener() ;
	}

}