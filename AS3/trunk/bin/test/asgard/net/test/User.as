
package test
{
	import system.Reflection;
	
	import vegas.core.CoreObject;	

	/**
	 * The User class to test the object container.
	 */
	public class User extends CoreObject
	{
		
		/**
		 * Creates a new User instance.
		 */
		public function User( name:String = null )
		{
			this.name    = name ;
		}
		
		/**
		 * The name of the User.
		 */
		public var name:String ;
	
		/**
		 * Initialize the User.
		 */
		public function initialize():void
		{
			trace( this + " initialize.") ;
		}
		
		/**
		 * Returns the string representation of the object.
		 * @return the string representation of the object.
		 */
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + ( name != null ? " " + name : "" ) + "]" ;	
		}
	}
	
}