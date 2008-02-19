
package test.factory 
{
	import test.User;	
	
	/**
	 * This factory creates User instances.
	 * @author eKameleon
	 */
	public class UserFactory 
	{
		
		/**
		 * Creates a new User instance with the specified pseudo.
		 * @param pseudo The pseudo String representation of the new User.
		 */
		public static function create( pseudo:String ):User
		{
			return new User( pseudo ) ;
		}
		
	}
}
