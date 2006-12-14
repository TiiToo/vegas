
import vegas.events.BasicEvent ;

/**
 * @author eKameleon
 */
class UserEvent extends BasicEvent 
{

	/**
	 * Creates a new UserEvent instance.
	 */
	public function UserEvent( type:String ) 
	{
		super( type ) ;
	}

	/**
	 * Register the class to AMF communication.
	 */
	static public function register():Boolean
	{
		return Object.registerClass("UserEvent", UserEvent) ;
	}


}
