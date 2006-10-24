/**
	
	AUTHOR
	
		Name : BooleanEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  24 oct. 06
		Author : eKameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

import vegas.events.DynamicEvent;

/**
 * @author eKameleon
 */
class vegas.events.BooleanEvent extends DynamicEvent 
{
	
	/**
	 * Creates a new BooleanEvent instance.
	 */
	public function BooleanEvent(type:String, b:Boolean, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		
		super(type, target, context, bubbles, eventPhase, time, stop);
		_b = b ;
		
	}

	/**
	 * Creates and returns a shallow copy of this instance.
	 */
	public function clone() 
	{
		return new BooleanEvent(getType(), getBoolean(), getTarget(), getContext()) ;
	}
	
	/**
	 * Returns the boolean instance.
	 */
	public function getBoolean():Boolean
	{
		return _b ;	
	}
	
	/**
	 * Sets the boolean instance.
	 */
	public function setBoolean(b:Boolean):Void
	{
		_b = b ;	
	}
	
	/**
	 * The internal boolean instance.
	 */
	private var _b:Boolean ;

}