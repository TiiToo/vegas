

import vegas.core.CoreObject ;

class test.User extends CoreObject
{
	

	public function User() {}
	
	/**
	 * The pseudo of the user.
	 */
	public var pseudo:String ;
	
	/**
	 * The url of the User.
	 */
	public var url:String ;
	
	public function initialize():Void
	{
	    trace( this + " initialize.") ;
	}
	
}