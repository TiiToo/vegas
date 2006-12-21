
import vegas.core.ICopyable;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.CopyableImplementation implements ICopyable 
{
	
	public function copy() 
	{
		return new CopyableImplementation() ;
	}

}