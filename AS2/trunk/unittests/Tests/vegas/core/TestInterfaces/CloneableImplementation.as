
import vegas.core.ICloneable;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.CloneableImplementation implements ICloneable 
{
	
	function clone() 
	{
		return new CloneableImplementation() ;
	}

}