package asgard.util.mvc
{

	import asgard.events.ModelChangedEvent;
	
	import vegas.events.AbstractCoreEventBroadcaster;

	public class AbstractModel extends AbstractCoreEventBroadcaster implements IModel
	{
		
		/**
		 * Abstract contructor, creates an IModel instance.
		 */
		public function AbstractModel()
		{
			super();
		}

		/**
		 * Adds a view in the model.
		 */
		public function addView(view:IView):void
		{
			addListener(ModelChangedEvent.MODEL_CHANGED, view) ;
		}

		/**
		 * Returns a shallow copy of this object.
		 */	
		public function clone():*
		{
			return null ; // override this method.
		}

		/**
		 * Notify a ModelChangedEvent to the views.
		 */
		public function notifyChanged(event:ModelChangedEvent):void
		{
			dispatchEvent( event ) ;
		}

		/**
		 * Removes a view in the model.
		 */
		public function removeView(view:IView):void
		{
			removeListener(ModelChangedEvent.MODEL_CHANGED, view) ;
		}
		
	}
}