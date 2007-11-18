
package mvc.events
{

	/**
	 * The global event type list of this application.
	 * @author eKameleon
	 */
	public class EventList
	{
		
		/**
		 * The name of the event when a new PictureVO is inserted in the model.
		 */
		public static const ADD_PICTURE:String = "onAddPicture" ;

		/**
		 * The name of the event when the gallery model is changed.
		 */
		public static const CHANGE_PICTURE:String = "onChangePicture" ;
	
		/**
		 * The name of the event when the model is cleared
		 */
		public static const CLEAR_PICTURE:String = "onClearPicture" ;

		/**
		 * The name of the event when a PictureVO is removed in the model.
		 */
		public static const REMOVE_PICTURE:String = "onRemovePicture" ;

	}

}