
import vegas.core.IComparator;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.ComparatorImplementation implements IComparator 
{
	
	public function compare(o1, o2) : Number 
	{
		return 0 ;
	}

	public function equals(o) : Boolean 
	{
		return true ;
	}

}