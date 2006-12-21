
import vegas.core.IValidator;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.ValidatorImplementation implements IValidator 
{
	
	public var isValidate:Boolean = false ;
	
	function supports(value):Boolean 
	{
		return true ;
	}

	function validate(value) : Void 
	{
		isValidate = true ;
	}

}