package test.events
{
	import flash.events.Event;
	import test.vo.PictureVO;

	/**
	 * The PictureEvent used in the GalleryModel to notify a change in the model.
	 * @author eKameleon
	 */
	public class PictureEvent extends Event
	{
		
		/**
		 * Creates a new PictureEvent instance.
		 */	
		public function PictureEvent(name:String , picture:PictureVO=null )
		{
			super(name);
			_picture = picture ;
		}

		/**
		 * Returns the PictureVo reference.
		 * @return the PictureVo reference.
		 */
		public function getPicture():PictureVO
		{
			return _picture  ;
		}
	
		/**
		 * Sets the PictureVO reference.
		 */
		public function setPicture(p:PictureVO):void
		{
			_picture  = p ;
		}
	
		private var _picture:PictureVO ;

	}
}