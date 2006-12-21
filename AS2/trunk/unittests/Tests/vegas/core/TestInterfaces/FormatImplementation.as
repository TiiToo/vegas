
import vegas.core.IFormat;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.FormatImplementation implements IFormat 
{
	
	function formatToString(o) : String 
	{
		return o.toString() ;
	}

}