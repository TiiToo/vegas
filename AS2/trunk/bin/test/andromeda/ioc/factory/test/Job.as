
import vegas.core.CoreObject ;
import vegas.util.ConstructorUtil;

/**
 * The Job class.
 */
class test.Job extends CoreObject
{
	
	/**
	 * Creates a new Job instance.
	 */
	public function Job()
	{
	
	}

	/**
	 * The name of this Job.
	 */
	public var name:String ;

	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	public function toString():String
	{
		return "[" + ConstructorUtil.getName(this) + " " + name + "]" ;
	}

}