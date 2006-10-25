/**
	
	AUTHOR
	
		Name : ArrayEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  25 oct. 06
		Author : eKameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

import vegas.events.DynamicEvent;

/**
 * @author eKameleon
 */
class vegas.events.ArrayEvent extends DynamicEvent 
{
	
	/**
	 * Creates a new BooleanEvent instance.
	 */
	public function ArrayEvent(type:String, ar:Array, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		
		super(type, target, context, bubbles, eventPhase, time, stop);
		_ar = ar ;
		
	}

	/**
	 * Creates and returns a shallow copy of this instance.
	 */
	public function clone() 
	{
		return new ArrayEvent(getType(), getArray(), getTarget(), getContext()) ;
	}
	
	/**
	 * Returns the array instance.
	 */
	public function getArray():Array
	{
		return _ar ;	
	}
	
	/**
	 * Sets the array instance.
	 */
	public function setArray(ar:Array):Void
	{
		_ar = ar ;	
	}
	
	/**
	 * The internal array instance.
	 */
	private var _ar:Array ;

}