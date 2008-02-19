
package test.factory 
{
	import test.User;
	
	import vegas.errors.IllegalArgumentError;		

	/**
	 * This factory creates User instances but use a filter with a black list array.
	 * @author eKameleon
	 */
	public class UserFilterFactory 
	{
		
		/**
		 * Creates a new UserFilterFactory instance.
		 * @param blackList The optional array of string pseudo to banish in this factory.
		 */
		public function UserFilterFactory ( blackList:Array=null )
		{
			this.blackList = blackList || [] ;
		}
		
		/**
		 * The blackList of this factory.
		 */
		public var blackList:Array ;

		/**
		 * Creates a new User instance with the specified pseudo.
		 * @param pseudo The pseudo String representation of the new User.
		 */
		public function create( pseudo:String ):User
		{
			if ( blackList.indexOf( pseudo ) > -1 )
			{
				throw new IllegalArgumentError(this + " create failed, the user with the pseudo '" + pseudo + "' is in the black list of this factory") ;
			}
			return new User( pseudo ) ;
		}
		
	}
}
