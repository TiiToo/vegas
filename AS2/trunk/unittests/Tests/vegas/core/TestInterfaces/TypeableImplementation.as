
import vegas.core.ITypeable;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.TypeableImplementation implements ITypeable 
{
	
	private var _type:Function ;
	
	function getType() : Function 
	{
		return _type ;
	}

	function setType(type : Function) : Void 
	{
		_type = type ;
	}

}