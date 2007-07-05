
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