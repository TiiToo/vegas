import vegas.errors.AbstractError;
import vegas.errors.ErrorElement;

/**
 * @author eKameleon
 */
class Tests.vegas.errors.ConcreteAbstractError extends AbstractError 
{
	
	function ConcreteAbstractError(message : String, e : ErrorElement) 
	{
		super(message, e);
	}

}