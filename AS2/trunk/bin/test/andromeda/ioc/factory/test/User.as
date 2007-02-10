
import test.Address ;
import test.Job ;

import vegas.core.CoreObject ;

/**
 * The User class to test the LightContainer.
 */
class test.User extends CoreObject
{
	
	/**
	 * Creates a new User instance.
	 */
	public function User( pseudo:String, name:String, address:Address )
	{
		this.pseudo  = pseudo ;
		this.name = name ;
		this.address = address ;
	}

	/**
	 * The Address reference of this object.
	 */
	public var address:Address ;

	/**
	 * The age of the user.
	 */
	public var age:Number ;

	/**
	 * The fistname of the user.
	 */
	public var firstName:String ;
	
	/**
	 * The job of this User.
	 */
	public var job:Job ;
	
	/**
	 * The mail of the user.
	 */
	public var mail:String ;
	
	/**
	 * The name of the User.
	 */
	public var name:String ;

	/**
	 * The pseudo of the user.
	 */
	public var pseudo:String ;
	
	/**
	 * The url of the User.
	 */
	public var url:String ;
	
	/**
	 * Destroy the user.
	 */
	public function destroy():Void
	{
		trace( this + " destroy.") ;
	}
	
	/**
	 * Initialize the User.
	 */
	public function initialize():Void
	{
		trace( this + " initialize.") ;
	}
	
	/**
	 * Sets the mail value of this user.
	 */
	public function setMail( sMail:String ):Void
	{
		mail = sMail ;
	}
	
}