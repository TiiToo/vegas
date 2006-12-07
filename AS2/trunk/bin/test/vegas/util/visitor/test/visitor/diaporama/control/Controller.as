import vegas.events.FrontController;

/**
 * The FrontController of this application.
 * @author eKameleon
 */
class test.visitor.diaporama.control.Controller extends FrontController 
{
	
	/**
	 * Creates the singleton FrontController of this application.
	 */
	private function Controller() 
	{
		super() ;
		initialize() ;
	}

	/**
	 * Returns the singleton instance of Controller.
	 * @return singleton instance of Controller.
	 */
	static public function getInstance():Controller 
	{
		if ( _instance == null )
		{
			_instance = new Controller() ;
		}
		return _instance ;
	}

	
	/**
	 * Initialize all controls of the application.
	 */
	public function initialize():Void
	{
		
	}

	/**
	 * The internal singleton reference.
	 */
	private static var _instance : Controller;

}