import vegas.core.CoreObject;

/**
 * The CuePoint information object.
 * @author eKameleon
 * @see VideoLoader
 */
class asgard.media.CuePoint extends CoreObject 
{

	/**
	 * Creates a new CuePoint instance.
	 * @param o An Object with the properties 'name', 'time' and 'type' used to define this CuePoint object.
	 */	
	public function CuePoint( o ) 
	{
		this.name = o.name ;
		this.time = o.time ;
		this.type = o.type ;
	}
	
	/**
	 * The name of the CuePoint.
	 */
	public var name:String ;

	/**
	 * The time of the CuePoint.
	 */
	public var time:String ;
	
	/**
	 * The type of the CuePoint.
	 */
	public var type:String ;
	
	/**
	 * Returns the String representation of this object.
	 * @return the String representation of this object.
	 */
	public function toString():String
	{
		var txt:String = "[CuePoint" ;
		if (name != null)
		{
			txt += " name:" + name ;
			if (time != null || type != null)
			{
				txt += "," ;
			}
		}
		if (time != null)
		{
			txt += "time:" + time ;
			if (type != null)
			{
				txt += "," ;
			}
		}
		if (type != null)
		{
			txt += "type:" + type ;
		} 
		txt += "]" ;
		return txt ; 	
	}
}