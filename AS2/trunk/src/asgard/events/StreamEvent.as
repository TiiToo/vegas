
import asgard.net.NetServerInfo;
import asgard.net.Stream;

import vegas.events.BasicEvent;

/**
 * The StreamEvent are dispatched when a Stream object dispatch events. 
 * @author ekameleon
 */
class asgard.events.StreamEvent extends BasicEvent 
{

	/**
	 * Creates a new StreamEvent instance.
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */	
	public function StreamEvent(type:String, stream:Stream, target, context, bubbles : Boolean, eventPhase : Number, time : Number, stop : Number) 
	{
		super(type, target, context, bubbles, eventPhase, time, stop);
	}

	/**
	 * Returns the NetServerInfo reference of this event.
	 * @return the NetServerInfo reference of this event.
	 */
	public function getInfo():NetServerInfo 
	{
		return _info ;	
	}

	/**
	 * Returns the Stream reference of this event.
	 * @return the Stream reference of this event.
	 */
	public function getStream():Stream
	{
		return _stream ;
	}
	
	/**
	 * Sets the NetServerInfo reference of this event.
	 * @param oInfo the info {@code Object} used to define the NetServerInfo reference.
	 */
	public function setInfo( oInfo ):Void 
	{
		if (oInfo instanceof NetServerInfo) 
		{
			_info = oInfo ;
		} 
		else if (typeof(oInfo) == "object") 
		{
			_info = new NetServerInfo(oInfo) ;	
		} 	
		else
		{
			_info = null ;
		}
	}
	
	/**
	 * Returns the Stream reference of this event.
	 * @return the Stream reference of this event.
	 */
	public function setStream( stream:Stream ):Void
	{
		_stream = stream ;
	}

	private var _info:NetServerInfo ;

	private var _stream:Stream ;

}