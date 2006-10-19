package asgard.util.mvc
{

	import asgard.events.ModelChangedEvent;
	
	import vegas.events.AbstractCoreEventBroadcaster;

	public class AbstractModel extends AbstractCoreEventBroadcaster implements IModel
	{
		
		// ----o Constructor
		
		public function AbstractModel()
		{
			super();
		}
		
		// ----o Public Methods

		public function addView(view:IView):void
		{
		
			addListener(ModelChangedEvent.MODEL_CHANGED, view) ;
			
		}

		public function clone():*
		{
			return null ; // override this method.
		}

		public function notifyChanged(event:ModelChangedEvent):void
		{
			
			dispatchEvent( event ) ;
			
		}

		public function removeView(view:IView):void
		{
			
			removeListener(ModelChangedEvent.MODEL_CHANGED, view) ;
			
		}
		
	}
}