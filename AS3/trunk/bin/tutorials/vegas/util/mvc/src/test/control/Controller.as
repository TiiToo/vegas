package test.control
{
	
	import test.control.model.AddPicture ;
	import test.control.model.ChangeCurrentPicture ;
	import test.control.model.ClearPicture ;
	import test.control.model.RemovePicture ;
	import test.events.EventList ;

	import vegas.events.FrontController;

	public class Controller extends FrontController
	{
	
		/**
		 * Creates the singleton FrontController of this application.
		 */
		function Controller() 
		{
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
		override public function initialize():void
		{
			
			// control.model
			
			insert( EventList.ADD_PICTURE , new AddPicture() ) ;
			insert( EventList.CHANGE_CURRENT_PICTURE , new ChangeCurrentPicture() ) ;
			insert( EventList.CLEAR_PICTURE , new ClearPicture() ) ;
			insert( EventList.REMOVE_PICTURE , new RemovePicture() ) ;
			
		}
	
		/**
		 * The internal singleton reference.
		 */
		private static var _instance:Controller;
	
	}



}