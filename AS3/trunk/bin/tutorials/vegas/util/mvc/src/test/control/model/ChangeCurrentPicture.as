package test.control.model
{
	import asgard.display.DisplayObjectCollector;
	
	import flash.events.Event;
	
	import test.display.PictureDisplay;
	import test.display.UIList;
	import test.events.PictureEvent;
	import test.visitors.LoaderVisitor;
	import test.vo.PictureVO;
	
	import vegas.core.CoreObject;
	import vegas.events.EventListener;

	public class ChangeCurrentPicture extends CoreObject implements EventListener
	{
		
		
		public function ChangeCurrentPicture()
		{
			super();
		}
		
		public function handleEvent(e:Event):*
		{
			
			trace(e) ;
			
			var event:PictureEvent = (e as PictureEvent) ;
			var vo:PictureVO = event != null ? event.getPicture() : null ;
			if (vo != null)
			{
					
				PictureDisplay(DisplayObjectCollector.get(UIList.PICTURE)).accept( new LoaderVisitor( vo.url ) ) ;
			}
			
		}
		
	}
}