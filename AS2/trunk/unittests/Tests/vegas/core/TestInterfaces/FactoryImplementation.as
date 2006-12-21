
import vegas.core.IFactory;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.FactoryImplementation implements IFactory 
{
	
	public function create() 
	{
		return new FactoryImplementation() ;
	}

}