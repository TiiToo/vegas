package test.control.model
{
	import vegas.events.EventListener;
	import flash.events.Event;
	import vegas.core.CoreObject;

	public class RemovePicture extends CoreObject implements EventListener
	{
		
		public function RemovePicture()
		{
			super();
		}
		
		public function handleEvent(e:Event):*
		{
			trace(e) ;
		}
		
	}
}