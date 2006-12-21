
import vegas.core.ISerializable;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.SerializableImplementation implements ISerializable 
{
	
	function toSource(indent : Number, indentor : String) : String 
	{
		return "SerializableImplementation" ;
	}

}