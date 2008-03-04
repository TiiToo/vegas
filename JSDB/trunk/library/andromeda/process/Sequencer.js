/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * A Sequencer of Action process.
 * <p><b>Example :</b></p>
 * {@code
 * var debug = function( e )
 * {
 *    trace( e.getType() ) ;
 * }
 * 
 * var seq = new pegas.process.Sequencer() ;
 * seq.addGlobalEventListener( new vegas.events.Delegate(this, debug ) ) ;
 * seq.addAction( new pegas.process.Pause(5, true) ) ;
 * seq.addAction( new pegas.process.Pause(3, true) ) ;
 * seq.addAction( new pegas.process.Pause(10, true) ) ;
 * seq.run() ;
 * }
 * @author eKameleon
 */
if (andromeda.process.Sequencer == undefined) 
{

	/**
	 * @requires andromeda.process.AbstractAction
	 */
	require("andromeda.process.AbstractAction") ;

	/**
	 * Creates a new Sequencer instance.
	 * @param ar An Array of {@code IAction} process objects.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	andromeda.process.Sequencer = function( ar /*Array*/ , bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 

		andromeda.process.AbstractAction.call(this,  bGlobal, sChannel ) ;
		
		this._queue  = new vegas.data.queue.LinearQueue() ;
		this._runner = new vegas.events.Delegate(this, this.run) ;
		
		if (ar != null && ar instanceof Array)
		{
			var l /*Number*/ = ar.length ;
			
			if (l>0) 
			{
				for (var i /*Number*/ = 0 ; i < l ; i++) 
				{
					this.addAction(ar[i]) ;		
				}
			}
		}
		
	}

	/**
	 * @extends andromeda.process.AbstractAction
	 */
	proto = andromeda.process.Sequencer.extend( andromeda.process.AbstractAction ) ;

	/**
	 * Adds a process(Action) in the Sequencer.
	 * @return {@code true} if the method success.
	 */
	proto.addAction = function ( action /*IAction*/ , isClone /*Boolean*/ ) /*Boolean*/
	{
		
		if ( action == null ) return false ;
		
		var a /*IAction*/ = null ;
		
		var b1 = action instanceof andromeda.process.IAction  ;
		var b2 = action.hasOwnProperty("notifyStarted") && action.hasOwnProperty("notifyFinished") ;
		
		if ( b1 || b2 ) 
		{
			a = action ;
		}
		
		if (a == null) return false ;
		
		if ( a.hasOwnProperty("clone") && (isClone == true) )
		{
			a = a.clone() ;	
		} 
		
		var isEnqueue /*Boolean*/ = this._queue.enqueue(a) ;
		
		if (isEnqueue)
		{

			if ( a instanceof andromeda.process.AbstractAction ||  a.addEventListener instanceof Function ) 
			{
				a.addEventListener( andromeda.events.ActionEvent.FINISH , this._runner ) ;
			}
			else
			{
				throw new vegas.errors.Warning( this + ".addAction(" + action + ") : the action object isn't IAction object." ) ;
			}
		}
		return isEnqueue ;
		
	}

	/**
	 * Removes all process in the Sequencer.
	 * @param noEvent A boolean flag to disabled the events dispatched by this method if is {@code true}.
	 * @param callback Function to map and check the current process in progress in the sequencer before reset it.
	 */
	proto.clear = function ( noEvent /*Boolean*/ , callback /*Function*/ ) /*void*/
	{
		if ( this.getRunning() )
		{
			this._cur.removeEventListener( andromeda.events.ActionEvent.FINISH, this._runner ) ;
			if (callback != null)
			{
				callback.call( this, this._cur ) ;
			}
			this.setRunning(false) ;
			
		}
		this._cur = null ;
		this._queue.clear() ;
		if ( noEvent )
		{
			return ;
		}
		this.notifyCleared() ;
	}

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () /*Sequencer*/ 
	{
		return new andromeda.process.Sequencer( this.toArray() ) ;
	}

	/**
	 * Returns the current process in progress.
	 * @return the current process in progress.
	 */
	proto.getCurrent = function() /*IAction*/
	{
		return this._cur ;	
	}

	/**
	 * Launchs the Sequencer with the first element in the internal Queue of this Sequencer.
	 */
	proto.run = function () /*void*/ 
	{
		if ( this._queue.size() > 0) 
		{
			
			if ( !this.getRunning() ) 
			{
				this.notifyStarted() ;
				this.setRunning(true) ;
			}
			else
			{
				this.notifyProgress() ;
			}
			
			this._cur = this._queue.poll() ;
			this._cur.run() ;
				
		}
		else 
		{
			if ( this._cur != null)
			{
				this._cur.removeEventListener(andromeda.events.ActionEvent.FINISH, this._runner) ;
				this._cur = null ;
			}
			if ( this.getRunning() ) 
			{
				this.setRunning(false) ;
				this.notifyFinished() ;
			}
		}
	}

	/**
	 * Returns the numbers of process in this Sequencer.
	 * @return the numbers of process in this Sequencer.
	 */
	proto.size = function () /*Number*/
	{
		return this._queue.size() ;	
	}

	/**
	 * Starts the Sequencer if is not in progress.
	 */
	proto.start = function () /*void*/
	{
		if ( ! this.getRunning() ) 
		{
			this.run() ;
		}
	}
	
	/**
	 * Stops the Sequencer. Stop only the last process if is running.
	 * @param noEvent A boolean flag to disabled the events dispatched by this method if is {@code true}.
	 * @param callback Function to map and check the current process in progress in the sequencer before reset it.
	 */
	proto.stop = function ( noEvent /*Boolean*/ , callback /*Function*/ ) /*void*/
	{
		if ( this.getRunning() ) 
		{
			this._cur.removeEventListener( andromeda.events.ActionEvent.FINISH, this._runner ) ;
			if (callback != null)
			{
				callback.call( this, this._cur ) ;
			}
			this._cur = null ;
			this.setRunning(false) ;
			if ( noEvent == true ) 
			{
				return ;
			}
			this.notifyStopped() ;
			this.notifyFinished() ;
		}	
	}

	/**
	 * Returns the array representation of all process in this Sequencer.
	 * @return the array representation of all process in this Sequencer.
	 */
	proto.toArray = function() /*Array*/ 
	{
		return this._queue.toArray() ;	
	}

	/**
	 * @private
	 */
	proto._cur /*Object*/ = null ;

	/**
	 * @private
	 */
	proto._queue /*LinearQueue*/ = null ; 
	
	/**
	 * @private
	 */
	proto._runner /*EventListener*/ = null ;

	delete proto ;

}