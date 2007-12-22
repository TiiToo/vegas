
package test
{
	import system.Reflection;
	
	import vegas.core.CoreObject;	

	/**
	 * The Job class.
	 */
	public class Job extends CoreObject
	{
	
		/**
		 * Creates a new Job instance.
		 */
		public function Job( name:String = null )
		{
			this.name = name ;
		}
		
		/**
		 * The name of this Job.
		 */
		public var name:String ;
		
		/**
		 * Returns the string representation of this object.
		 * @return the string representation of this object.
		 */
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + " " + name + "]" ;
		}
		
	}

}