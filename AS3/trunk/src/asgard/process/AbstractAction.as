package asgard.process
{
		
	import asgard.events.ActionEvent ;
	import asgard.process.IAction ;
	
	import flash.events.EventDispatcher ;

	public class AbstractAction extends EventDispatcher implements IAction
	{
		
		// ----o Constructor
		
		public function AbstractAction()
		{
			
			_eChange = new ActionEvent(ActionEvent.CHANGE) ;
			
			_eClear = new ActionEvent(ActionEvent.CLEAR) ;
			
			_eFinish = new ActionEvent(ActionEvent.FINISH) ;
			
			_eInfo = new ActionEvent(ActionEvent.INFO) ;
			
			_eLoop = new ActionEvent(ActionEvent.LOOP) ;
			
			_eProgress = new ActionEvent(ActionEvent.PROGRESS) ;
			
			_eResume = new ActionEvent(ActionEvent.RESUME) ;
			
			_eStart = new ActionEvent(ActionEvent.START) ;
			
			_eStop = new ActionEvent(ActionEvent.STOP) ;
			
		}

		// ----o Public Properties
	
		public var looping:Boolean ;
		// public var running:Boolean ; // [Read Only]
	
		// ----o Public Methods
	
		public function clone():*
		{
			return new AbstractAction() ;
		}

		public function getRunning():Boolean 
		{
			return _isRunning ;	
		}
	
		public function notifyChanged():void 
		{
			dispatchEvent(_eChange) ;
		}

		public function notifyCleared():void 
		{
			dispatchEvent(_eClear) ;
		}	

		public function notifyFinished():void 
		{
			dispatchEvent(_eFinish) ;
		}
	
		public function notifyInfo( oInfo:* ):void
		{
			dispatchEvent(_eInfo) ;
		}
	
		public function notifyLooped():void 
		{
			dispatchEvent(_eLoop) ;
		}

		public function notifyProgress():void
		{
			dispatchEvent(_eProgress) ;
		}
	
		public function notifyResumed():void
		{
			dispatchEvent(_eResume) ;
		}
	
		public function notifyStarted():void
		{
			dispatchEvent( _eStart ) ;
		}
	
		public function notifyStopped():void
		{
			dispatchEvent(_eStop) ;
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
	
		// ----o Private Properties
	
		private var _eChange:ActionEvent ;
		private var _eClear:ActionEvent ;
		private var _eFinish:ActionEvent ;
		private var _eInfo:ActionEvent ;
		private var _eLoop:ActionEvent ;
		private var _eProgress:ActionEvent ;
		private var _eResume:ActionEvent ;
		private var _eStart:ActionEvent ;
		private var _eStop:ActionEvent ;
		
		private var _isRunning:Boolean ;

		// ----o Protected Methods
	
		protected function _setRunning(b:Boolean):void
		{
			_isRunning = b ;	
		}

	}
}