package asgard.process
{
	
	import asgard.events.ActionEvent ;
	import asgard.process.IAction ;
	
	import vegas.data.iterator.Iterator ;
	import vegas.data.queue.LinearQueue ;
	import vegas.data.queue.TypedQueue ;
	import vegas.util.Serializer ;
		
	public class Sequencer extends AbstractAction
	{
		
		// ----o Constructor
		
		public function Sequencer( ar:Array=null )
		{
		
			super();
			
			_queue = new TypedQueue(IAction, new LinearQueue()) ; 
			
			if (ar != null)
			{
				var l:uint = ar.length ;
				if (l>0) 
				{
					for (var i:Number = 0 ; i < l ; i++) 
					{
						var a:IAction = ar[i] ;
						if (a is IAction)
						{
							addAction(a) ;		
						} 
					}
				}
			}
					
		}
	
		// ----o Public Methods
	
		public function addAction(action:IAction, isClone:Boolean=false):Boolean 
		{
			var a:IAction = isClone ? action.clone() : action ;
			var isEnqueue:Boolean = _queue.enqueue(a) ;
			if (isEnqueue)
			{
				AbstractAction(a).addEventListener(ActionEvent.FINISH, run) ;
			}
			return isEnqueue ;
		}
	
		public function clear():void 
		{
			_queue.clear() ;
		}

		override public function clone():*
		{
			var s:Sequencer = new Sequencer() ;
			var it:Iterator = _queue.iterator() ;
			while (it.hasNext()) 
			{
				s.addAction(it.next().clone()) ;
			}
			return s ;
		}
		
		override public function run(...arguments:Array):void 
		{

			if (_queue.size() > 0) 
			{
				
				if (!running) 
				{
					notifyStarted() ;
					setRunning(true) ;
				}

				notifyProgress() ;

				_cur = _queue.poll() ;
				_cur.run() ;
				
			}
			else 
			{
				if ( getRunning() ) 
				{
					setRunning(false) ;
					notifyFinished() ;
				}
			}
			
		}	
	
		public function size():uint
		{
			return _queue.size() ;
		}

		public function start():void 
		{
			if ( !getRunning() ) 
			{
				run() ;
			}
		}
	
		public function stop(noEvent:Boolean):void 
		{
			if ( getRunning() ) 
			{
				_cur.removeEventListener(ActionEvent.FINISH, run) ;
				setRunning(false) ;
				if (noEvent) return ;
				notifyStopped() ;
				notifyFinished() ;
			}
		}
	
		public function toArray():Array 
		{
			return _queue.toArray() ;	
		}

		override public function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, [toArray()]) ;
		}

		// ----o Private Properties	
	
		private var _cur:* ;
		private var _queue:TypedQueue  ;
		
	}
}