
import vegas.core.IConvertible;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.ConvertibleImplementation implements IConvertible 
{
	
	public function toBoolean():Boolean 
	{
		return true ;
	}

	public function toNumber():Number 
	{
		return 1 ;
	}

	public function toObject():Object 
	{
		return { prop:true } ;
	}

}