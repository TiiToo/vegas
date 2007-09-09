/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-20087
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.process
{
    import pegas.events.ActionEvent;
    
    import vegas.data.iterator.Iterator;
    import vegas.data.queue.LinearQueue;
    import vegas.data.queue.TypedQueue;
    import vegas.util.Serializer;
    
	/**
	 * A Sequencer of IAction process.
	 * <p><b>Example :</b></p>
	 * {@code
	 * var seq:Sequencer = new Sequencer() ;
	 * seq.addEventListener( ActionEvent.START  , handleEvent ) ;
	 * seq.addEventListener( ActionEvent.PROGRESS , handleEvent ) ;
	 * seq.addEventListener( ActionEvent.FINISH , handleEvent ) ;
	 * 
	 * seq.addAction( new Pause(10, true) );
	 * seq.addAction( new Pause( 2, true) ) ;
	 * seq.addAction( new Pause( 5, true) ) ;
	 * seq.addAction( new Pause( 10, true) ) ;
	 * seq.run() ;
	 * }
	 * @author eKameleon
	 */
	public class Sequencer extends Action
	{
		
    	/**
	     * Creates a new Sequencer instance.
    	 * @param ar An Array of {@code Action} objects.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
    	 */
		public function Sequencer( ar:Array = null , bGlobal:Boolean = false , sChannel:String = null )
		{
			super(bGlobal, sChannel);
			_queue = new TypedQueue( IAction, new LinearQueue() ) ; 
			if (ar != null)
			{
				var l:Number = ar.length ;
				if (l>0) 
				{
					for (var i:Number = 0 ; i < l ; i++) 
					{
						if (ar[i] is IAction)
						{
							addAction(ar[i]) ;		
						} 
					}
				}
			}
		}
		
    	/**
    	 * Adds a process(Action) in the Sequencer.
    	 * @return {@code true} if the method success.
    	 */
		public function addAction(action:IAction, isClone:Boolean=false):Boolean 
		{
			var a:IAction = isClone ? action.clone() : action ;
			var isEnqueue:Boolean = _queue.enqueue(a) ;
			if (isEnqueue)
			{
				a.addEventListener( ActionEvent.FINISH, run ) ;
			}
			return isEnqueue ;
		}

    	/**
	     * Removes all process in the Sequencer.
    	 * @param noEvent A boolean flag to disabled the events dispatched by this method if is {@code true}.
    	 * @param callback Function to map and check the current process in progress in the sequencer before reset it.
    	 */
		public function clear( noEvent:Boolean = false , callback:Function = null ):void 
		{
		    if (running) 
		    {
			    _cur.removeEventListener( ActionEvent.FINISH, run) ;
			    if (callback != null)
			    {
    				callback.call( this, _cur ) ;
			    }
			    setRunning(false) ;
		    }
		    _cur = null ;
		    _queue.clear() ;
		    if (noEvent) 
		    {
		        return ;
		    }
		    notifyCleared() ;
		}

    	/**
    	 * Returns a shallow copy of this object.
    	 * @return a shallow copy of this object.
    	 */
		public override function clone():*
		{
			var s:Sequencer = new Sequencer() ;
			var it:Iterator = _queue.iterator() ;
			while (it.hasNext()) 
			{
				s.addAction(it.next().clone()) ;
			}
			return s ;
		}
        
    	/**
    	 * Returns the current process in progress.
    	 * @return the current process in progress.
    	 */
	    public function getCurrent():IAction
	    {
            return _cur ;	
    	}
        
    	/**
    	 * Launchs the Sequencer with the first element in the internal Queue of this Sequencer.
    	 */
		public override function run(...arguments:Array):void 
		{
			if (_queue.size() > 0) 
			{
				if (!running) 
				{
					notifyStarted() ;
					setRunning(true) ;
				}
				else
				{
				    notifyProgress() ;
				}
				_cur = _queue.poll() ;
				_cur.run() ;
			}
			else 
			{
			    _cur.removeEventListener( ActionEvent.FINISH, run ) ;
			    _cur = null ;
				if ( running == true ) 
				{
					setRunning(false) ;
					notifyFinished() ;
				}
			}
		}	

    	/**
    	 * Returns the numbers of process in this Sequencer.
    	 * @return the numbers of process in this Sequencer.
    	 */
		public function size():uint
		{
			return _queue.size() ;
		}

    	/**
    	 * Starts the Sequencer if is not in progress.
    	 */
		public function start():void 
		{
			if ( !running ) 
			{
				run() ;
			}
		}
		
    	/**
    	 * Stops the Sequencer. Stop only the last process if is running.
    	 * @param noEvent A boolean flag to disabled the events dispatched by this method if is {@code true}.
    	 * @param callback Function to map and check the current process in progress in the sequencer before reset it.
    	 */
		public function stop( noEvent:Boolean = false , callback:Function = null ):void 
		{
			if ( running ) 
			{
				_cur.addEventListener(ActionEvent.FINISH, run) ;
				if (callback != null)
			    {
    				callback.call( this, _cur ) ;
			    }
			    _cur = null ;
				setRunning(false) ;
				if ( noEvent == true ) 
				{
				    return ;
				}
				notifyStopped() ;
				notifyFinished() ;
			}
		}

    	/**
    	 * Returns the array representation of all process in this Sequencer.
    	 * @return the array representation of all process in this Sequencer.
    	 */
		public function toArray():Array 
		{
			return _queue.toArray() ;	
		}

    	/**
    	 * Returns the source of the specified object passed in argument.
	     * @return the source of the specified object passed in argument.
    	 */
		public override function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, [toArray()]) ;
		}
		
		private var _cur:IAction ;
		
		private var _queue:TypedQueue  ;
		
	}
}