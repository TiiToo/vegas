package test.control.model
{
	import vegas.events.EventListener;
	import flash.events.Event;
	import vegas.core.CoreObject;
	import test.vo.PictureVO;

	public class AddPicture extends CoreObject implements EventListener
	{
		
		public function AddPicture()
		{
			super();
		}
		
		public function handleEvent(e:Event):*
		{
			trace( e ) ;
		}
		
	}
}