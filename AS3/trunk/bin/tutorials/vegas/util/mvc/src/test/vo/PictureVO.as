package test.vo
{
	import vegas.core.CoreObject;

	/**
	 * The value object a of picture element in the GalleryModel.
	 */
	public class PictureVO extends CoreObject
	{
		
		/**
		 * Creates a new PictureVO instance.
		 */
		public function PictureVO( name:String , url:String )
		{
			this.name = name ;
			this.url = url ;
		}
		
		/**
		 * The name of the picture.
		 */
		public var name:String ;

		/**
		 * The url of the picture.
		 */
		public var url:String ;

		
	}
}