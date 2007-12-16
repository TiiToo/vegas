
package test
{

	import vegas.core.CoreObject ;

	/**
	 * The User class to test the LightContainer.
	 */
	public class User extends CoreObject
	{
		
		/**
		 * Creates a new User instance.
		 */
		public function User( pseudo:String = null, name:String =null , address:Address = null )
		{
			this.pseudo  = pseudo ;
			this.name    = name ;
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
		public function destroy():void
		{
			trace( this + " destroy.") ;
		}
	
		/**
		 * Initialize the User.
		 */
		public function initialize():void
		{
			trace( this + " initialize.") ;
		}
		
		/**
		 * Sets the mail value of this user.
		 */
		public function setMail( sMail:String ):void
		{
			mail = sMail ;
		}
		
	}
	
}