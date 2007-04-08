
import vegas.events.Event ;
import vegas.events.EventListener;

/**
 * The DebugHandler class.
 */
class test.events.DebugHandler implements EventListener 
{

	/**
	 * Creates a new DebugHandler instance.
	 */
	public function DebugHandler(name) 
	{
		_name = name || "default" ;
	}
	
	/**
	 * Returns tne name of the debugger.
	 */
	public function getName():String 
	{
		return _name || "" ;
	}

	/**
	 * Handles the event.
	 */
    public function handleEvent(e:Event) 
    {
        trace( "-------- DebugHandler : Event has been triggered." ) ;
        trace( "Event type     : " + e.getType()    ) ;
        trace( "Event target   : " + e.getTarget()  ) ;
        trace( "Event context  : " + e.getContext() ) ;
        trace( "Event in queue : " + e.isQueued()   ) ;
    }
	
	/**
	 * Returns the String representation of the object.
	 * @return the String representation of the object.
	 */
	public function toString():String 
	{
		return "[DebugHandler name:" + _name + "]" ;
	}
	
	/**
	 * The internal private name property of this instance.
	 */
	private var _name:String ;
	
}