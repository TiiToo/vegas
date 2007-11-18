
package mvc.controller.model
{
	import flash.events.Event;
	
	import andromeda.controller.AbstractController;
	import andromeda.events.ModelObjectEvent;
	
	import mvc.vo.PictureVO;	

	public class RemovePicture extends AbstractController
	{
		
		/**
		 * Creates a new RemovePicture instance.
		 */
		public function RemovePicture()
		{
			super();
		}
		
		/**
		 * Handles the event.
		 */
		public override function handleEvent(e:Event):void
		{
			try
			{
				var picture:PictureVO = ModelObjectEvent(e).getVO() as PictureVO ;
				trace( this + " handleEvent : " + picture ) ;
			}
			catch( error:Error )
			{
				trace( this + " handleEvent : " + e ) ;	
			}		
		}
		
	}
	
}

