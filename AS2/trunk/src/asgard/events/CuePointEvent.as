import asgard.media.CuePoint;

import vegas.events.BasicEvent;

/**
 * This event contains a CuePoint reference.
 * @author eKameleon
 */
class asgard.events.CuePointEvent extends BasicEvent 
{

	/**
	 * Creates a new CuePointEvent instance.
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 * @param oInfo the cuepoint info primitive object.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */	
	public function CuePointEvent( type:String, target, oInfo, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number ) 
	{
		super(type, target, context, bubbles, eventPhase, time, stop);
		setCuePoint(oInfo) ;
	}

	/**
	 * The name of the event when a new cue point info is notifyed.
	 */
	static public var INFO:String = "onCuePointInfo" ;

	/**
	 * Returns the CuePoint of this event.
	 * @return the CuePoint of this event.
	 */
	public function getCuePoint():CuePoint
	{
		return _cp ;	
	}
	
	/**
	 * Returns the name of the CuePoint.
	 */
	public function getName():String
	{
		return _cp.name ;
	}
	
	/**
	 * Returns the time value of the CuePoint.
	 */
	public function getTime():String
	{
		return _cp.time ;
	}
	
	/**
	 * Returns the type value of the CuePoint.
	 */
	public function getType():String
	{
		return _cp.type ;
	}

	/**
	 * Sets the CuePoint of this event.
	 */
	public function setCuePoint( o ):Void
	{
		_cp = new CuePoint(o) ;	
	}

	private var _cp ;

}