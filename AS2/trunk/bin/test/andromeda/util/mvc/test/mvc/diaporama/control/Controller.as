
import test.mvc.diaporama.control.model.AddPicture;
import test.mvc.diaporama.control.model.ChangeCurrentPicture;
import test.mvc.diaporama.control.model.ClearPicture;
import test.mvc.diaporama.control.model.RemovePicture;
import test.mvc.diaporama.events.EventList;

import vegas.events.FrontController;

/**
 * The FrontController of this application.
 * @author eKameleon
 */
class test.mvc.diaporama.control.Controller extends FrontController 
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
		
		// control.model
		
		insert( EventList.ADD_PICTURE , new AddPicture() ) ;
		insert( EventList.CLEAR_PICTURE , new ClearPicture() ) ;
		insert( EventList.REMOVE_PICTURE , new RemovePicture() ) ;
		insert( EventList.CHANGE_CURRENT_PICTURE , new ChangeCurrentPicture() ) ;
		
	}

	/**
	 * The internal singleton reference.
	 */
	private static var _instance:Controller;

}