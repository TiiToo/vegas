package test.control.model
{

	import asgard.display.DisplayObjectCollector;
	
	import flash.events.Event;
	
	import test.display.PictureDisplay;
	import test.display.UIList;
	import test.visitors.ClearVisitor;
	
	import vegas.core.CoreObject;
	import vegas.events.EventListener;

	public class ClearPicture extends CoreObject implements EventListener
	{
		
		public function ClearPicture()
		{
			super();
		}
		
		public function handleEvent(e:Event):*
		{

			trace(e) ;
			
			PictureDisplay(DisplayObjectCollector.get(UIList.PICTURE)).accept( new ClearVisitor() ) ;
			
		}
		
	}
}