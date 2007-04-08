
import test.events.Author ;

import vegas.events.Event ;

/**
 * The AnyClass class
 */
class test.events.AnyClass 
{

	/**
	 * Creates a new AnyClass object.
	 */
	public function AnyClass() {}
	
	/**
	 * The login method of this class.
	 */
    public function login( ev:Event ) 
	{
		trace (this + " -> login method : " + ev) ;
		trace ("type : " + ev.getType()) ;
		trace ("target : " + ev.getTarget()) ;
		trace ("context : " + ev.getContext()) ;
    }
	
	/**
	 * Returns the String representation of the object.
	 */
	public function toString():String 
	{
		return "[AnyClass]" ;
	}
	
}