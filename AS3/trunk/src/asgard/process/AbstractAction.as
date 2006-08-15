package asgard.process
{
		
	import asgard.events.ActionEvent ;
	import asgard.process.IAction ;
	
	import vegas.events.AbstractCoreEventBroadcaster;

	public class AbstractAction extends AbstractCoreEventBroadcaster implements IAction
	{
		
		// ----o Constructor
		
		public function AbstractAction()
		{
			//
		}

		// ----o Public Properties
	
		public var looping:Boolean ;
	
		// ----o Public Methods
	
		public function clone():*
		{
			return new AbstractAction() ;
		}

		public function getRunning():Boolean 
		{
			return _isRunning ;	
		}

		public function notifyFinished():void 
		{
			var eFinish:ActionEvent = new ActionEvent(ActionEvent.FINISH) ;
			dispatchEvent(eFinish) ;
		}
	
		public function notifyStarted():void
		{
			var eStart:ActionEvent = new ActionEvent(ActionEvent.START) ;
			dispatchEvent( eStart ) ;
		}
		
		public function run(...arguments):void 
		{
		// 
		}

		// ----o Virtual Properties
	
		public function get running():Boolean 
		{
			return getRunning() ;	
		}
	
		// ----o Protected Methods
		
		protected function notifyChanged():void 
		{
			var eChange:ActionEvent = new ActionEvent(ActionEvent.CHANGE) ;
			dispatchEvent(eChange) ;
		}

		protected function notifyCleared():void 
		{
			var eClear:ActionEvent = new ActionEvent(ActionEvent.CLEAR) ;
			dispatchEvent(eClear) ;
		}	
	
		protected function notifyInfo( oInfo:* ):void
		{
			var eInfo:ActionEvent = new ActionEvent(ActionEvent.INFO) ;
			dispatchEvent(eInfo) ;
		}
	
		protected function notifyLooped():void 
		{
			var eLoop:ActionEvent = new ActionEvent(ActionEvent.LOOP) ;
			dispatchEvent(eLoop) ;
		}

		protected function notifyProgress():void
		{
			var eProgress:ActionEvent = new ActionEvent(ActionEvent.PROGRESS) ;
			dispatchEvent(eProgress) ;
		}
	
		protected function notifyResumed():void
		{
			var eResume:ActionEvent = new ActionEvent(ActionEvent.RESUME) ;
			dispatchEvent(eResume) ;
		}
	
		protected function notifyStopped():void
		{
			var eStop:ActionEvent = new ActionEvent(ActionEvent.STOP) ;
			dispatchEvent(eStop) ;
		}

		protected function setRunning(b:Boolean):void
		{
			_isRunning = b ;	
		}

		// ----o Private Properties
		
		private var _isRunning:Boolean ;

	}
}