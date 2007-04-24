
import andromeda.model.IValueObject;

import vegas.core.CoreObject;
import vegas.util.ConstructorUtil;

/**
 * This class is a basic implementation of the IValueObject interface. This class is really useful with a remote 'AMF' value object.
 * @author eKameleon
 */
class andromeda.model.SimpleValueObject extends CoreObject implements IValueObject 
{
	
	/**
	 * Creates a new SimpleValueObject instance.
	 */
	public function SimpleValueObject() 
	{
		super();
	}

	/**
	 * The id of this value object.
	 */
	public var id ;

	/**
	 * Returns the id of the value object.
	 * @return the id of the value object.
	 */
	public function getID() 
	{
		return this.id ;
	}
	
	/**
	 * Sets the id of the value object.
	 */
	public function setID(id) : Void 
	{
		this.id = id ;		
	}

	/**
	 * Returns the {@code String} representation of this object.
	 * @return the {@code String} representation of this object.
	 */
	public function toString():String
	{
		return "[" + ConstructorUtil.getName(this) + " " + id + "]" ;
	}

}