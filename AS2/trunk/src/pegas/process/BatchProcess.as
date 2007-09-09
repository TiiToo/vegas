/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.events.ActionEvent;
import pegas.process.Action;
import pegas.process.Batch;
import pegas.process.SimpleAction;

import vegas.data.iterator.Iterator;
import vegas.events.Delegate;
import vegas.events.EventListener;
import vegas.events.EventTarget;

/**
 * This {@code Action} object register {@code Action} objects in a batch process.
 * @author eKameleon
 */
class pegas.process.BatchProcess extends SimpleAction
{
	
	/**
	 * Creates a new BatchProcess instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	function BatchProcess( bGlobal:Boolean, sChannel:String ) 
	{
		super(bGlobal, sChannel);
		_eProgress = new ActionEvent(ActionEvent.PROGRESS, this) ;
		_batch = new Batch() ;
		_finishListener = new Delegate(this, _onFinished) ;
		initialize() ;
	}

   	/**
     * Inserts an IAction object in the batch process collection.
     */
	public function addAction( action:Action ):Void
	{
		EventTarget(action).addEventListener( ActionEvent.FINISH, _finishListener) ;
		_batch.insert( action ) ;	
	}

	/**
	 * Clear the layout manager.
	 */
	public function clear():Void
	{

		if ( running && !_batch.isEmpty() )
		{
			var it:Iterator = _batch.iterator() ;
			while(it.hasNext())
			{
				clearProcess( it.next()) ;
			}
		}
		_batch.clear() ;
		_cpt = 0 ;
	}
	
	/**
	 * Clear the specified process. Overrides this method in a custom BatchProcess implementation. 
	 */
	public function clearProcess( action:Action ):Void
	{
		// overrides
	}

	/**
	 * Invoqued before the notifyFinished method is invoqued.
	 * Overrides this method.
	 */
	public function finish():Void
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
	 * Initialize the layout. Overrides this method.
	 */
	public function initialize():Void
	{
		//	
	}

	/**
	 * Notify an ActionEvent when the process is in progress.
	 */
	public function notifyProgress( a:ActionEvent ):Void 
	{
		_eProgress.context = a ;
		dispatchEvent(_eProgress) ;
	}

	/**
	 * Removes an {@code Action} object in the internal batch collection.
	 */
	public function removeAction( action:Action ):Void
	{
		if (_batch.contains(action))
		{
			EventTarget(action).removeEventListener( ActionEvent.FINISH, _finishListener) ;
			_batch.remove( action ) ;
		}	
	}

	/**
	 * Run the process.
	 */
	public function run():Void 
	{
		start() ;
		notifyStarted() ;
		_cpt = 0 ;
		_batch.run() ;
	}

	/**
	 * Invoqued before the notifyStarted method is invoqued.
	 * Overrides this method.
	 */
	public function start():Void
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
	 * The EventListener invoqued when the process is finished. 
	 */
	private var _finishListener:EventListener ;

	/**
	 * Invoqued when a tween finish this movement.
	 * If all tweens are finished the notifyFinished method is invoqued.
	 */
	private function _onFinished( e:ActionEvent ):Void
	{
		_cpt ++ ;
		notifyProgress( e.getTarget() ) ;		
		if (_cpt == _batch.size())
		{
			finish() ;		
			notifyFinished() ;
		}
	}

}