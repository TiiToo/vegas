/**
	
	AUTHOR
	
		Name : NumberEvent
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
class vegas.events.NumberEvent extends DynamicEvent 
{
	
	/**
	 * Creates a new NumberEvent instance.
	 */
	public function NumberEvent(type:String, n:Number, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		
		super(type, target, context, bubbles, eventPhase, time, stop);
		_n = n ;
		
	}

	/**
	 * Creates and returns a shallow copy of this instance.
	 */
	public function clone() 
	{
		return new NumberEvent(getType(), getNumber(), getTarget(), getContext()) ;
	}
	
	/**
	 * Returns the number instance.
	 */
	public function getNumber():Number
	{
		return _n ;	
	}
	
	/**
	 * Sets the number instance.
	 */
	public function setNumber(n:Number):Void
	{
		_n = n ;	
	}
	
	/**
	 * The internal number instance.
	 */
	private var _n:Number ;

}