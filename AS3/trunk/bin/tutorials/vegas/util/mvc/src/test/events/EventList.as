package test.events
{

	/**
	 * The global event type list of this application.
	 * @author eKameleon
	 */
	public class EventList
	{
		
		/**
		 * The name of the PictureEvent when a new Picture is inserted in the model.
		 */
		static public const ADD_PICTURE:String = "onAddPicture" ;

		/**
		 * The name of the PictureEvent when the model change.
		 */
		static public const CHANGE_CURRENT_PICTURE:String = "onChangePicture" ;
	
		/**
		 * The name of the PictureEvent when the model is cleared
		 */
		static public const CLEAR_PICTURE:String = "onClearPicture" ;

		/**
		 * The name of the PictureEvent when a new Picture is removed in the model.
		 */
		static public const REMOVE_PICTURE:String = "onRemovePicture" ;

	}

}