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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.process
{
    
    import pegas.events.ActionEvent;
    
    import vegas.data.iterator.Iterator;
    
    /**
     * This {@code IAction} object register {@code IAction} objects in a batch process.
     * @author eKameleon
     */
    public class BatchProcess extends SimpleAction
    {
        
    	/**
    	 * Creates a new BatchTransition instance.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
    	 */
    	function BatchProcess( bGlobal:Boolean = false , sChannel:String = null ) 
    	{
		    super(bGlobal, sChannel);
		   
		    _batch = new Batch() ;
		    initialize() ;
	    }

    	/**
    	 * Inserts an IAction object in the batch process collection.
    	 */
	    public function addAction( action:IAction , useWeakReference:Boolean=true ):void
	    {
    		action.addEventListener( ActionEvent.FINISH, _onFinished , false, 0 , useWeakReference ) ;
		    _batch.insert( action ) ;	
	    }
        
	    /**
	     * Clear the layout manager.
	     */
	    public function clear():void
	    {
		    if ( running && !_batch.isEmpty() )
		    {
    			var it:Iterator = _batch.iterator() ;
			    while(it.hasNext())
			    {
			        var action:IAction = it.next() ;
			        action.removeEventListener( ActionEvent.FINISH, _onFinished ) ;
    				clearProcess( action ) ;
			    }
		    }
		    _batch.clear() ;
		    _cpt = 0 ;
	    }
        
	    /**
	     * Clear the specified process. This method map all IAction objects in the batch when the batch is cleared.
	     * Overrides this method in a custom BatchProcess implementation. 
	     */
    	public function clearProcess( action:IAction ):void
    	{
		    // overrides
	    }

        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
	    public override function clone():*
	    {
    		var b:BatchProcess = new BatchProcess() ;
		    var it:Iterator = _batch.iterator() ;
		    while (it.hasNext()) 
		    {
		        b.addAction( it.next() ) ;
		    }
		    return b ;
	    }
	    
	    /**
         * Invoqued before the notifyFinished method is invoqued.
         * Overrides this method.
         */
	    public function finish():void
	    {
    		// overrides
    	}
        	    
	    /**
         * Returns the internal Batch reference of this layout manager.
         * @return the internal Batch reference of this layout manager.
         */
	    public function getBatch():Batch
	    {
    		return _batch ;	
    	}
        
        /**
		 * Returns the event name use in the notifyProgress method.
		 * @return the event name use in the notifyProgress method.
		 */
		public function getEventTypePROGRESS():String
		{
			return _eProgress.type ;
		}
		
	    /**
         * Initialize the internal events of this process.
         */
	    public override function initEvent():void
	    {
	        super.initEvent() ;
	        _eProgress = new ActionEvent( ActionEvent.PROGRESS, this ) ; 
	    }
        	    
        /**
         * Initialize the layout. Overrides this method.
         */
	    public function initialize():void
	    {
    		// overrides this method.
    	}
	    
	    /**
	     * Notify an ActionEvent when the process is in progress.
	     */
	    public function notifyProgress( action:IAction ):void 
	    {
    		_eProgress.context = action ;
		    dispatchEvent(_eProgress) ;
	    }

	    /**
	     * Removes an {@code Action} object in the internal batch collection.
	     */
	    public function removeAction( action:Action ):void
	    {
	        if ( _batch.contains( action ) )
	        {
	            action.removeEventListener( ActionEvent.FINISH, _onFinished ) ;
	            _batch.remove( action ) ;
	        }
    	}

    	/**
    	 * Runs the process.
    	 */
        public override function run( ...arguments:Array ):void
        {
		    start() ;
		    notifyStarted() ;
		    _cpt = 0 ;
		    _batch.run() ;
        }
        
        /**
		 * Sets the event name use in the notifyProgress method.
		 */
		public function setEventTypePROGRESS( type:String ):void
		{
			_eProgress.type = type || ActionEvent.PROGRESS ;
		}
        
        /**
         * Returns the number of IAction object in this batch process.
         * @return the number of IAction object in this batch process.
         */
        public function size():uint
        {
            return _batch.size() ;
        }
        
       	/**
	     * Invoqued before the notifyStarted method is invoqued. Overrides this method.
	     */
	    public function start():void
	    {
    		// overrides
    	}
        
        /**
         * The internal batch process of this manager.
         */
        private var _batch:Batch ;

        /**
         * Internal count use in the _onFinished method.
         */
        private var _cpt:Number ;

        /**
         * Invoqued during the progress of the process.
         */
	    private var _eProgress:ActionEvent ;
        
	    /**
    	 * Invoqued when a tween finish this movement.
    	 * If all tweens are finished the notifyFinished method is invoqued.
	    */
    	private function _onFinished( e:ActionEvent ):void
    	{
		    _cpt ++ ;
		    notifyProgress( e.target as IAction ) ;		
		    if (_cpt == _batch.size())
		    {
    			finish() ;		
			    notifyFinished() ;
		    }
	    }

    }
}