/**
	
	AUTHOR
	
		Name : StringEvent
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
class vegas.events.StringEvent extends DynamicEvent 
{
	
	/**
	 * Creates a new StringEvent instance.
	 */
	public function StringEvent(type:String, str:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		
		super(type, target, context, bubbles, eventPhase, time, stop);
		_str = str ;
		
	}

	/**
	 * Creates and returns a shallow copy of this instance.
	 */
	public function clone() 
	{
		return new StringEvent(getType(), getString(), getTarget(), getContext()) ;
	}
	
	/**
	 * Returns the string instance.
	 */
	public function getString():String
	{
		return _str ;	
	}
	
	/**
	 * Sets the string instance.
	 */
	public function setString(s:String):Void
	{
		_str = s ;	
	}
	
	/**
	 * The internal string instance.
	 */
	private var _str:String ;

}