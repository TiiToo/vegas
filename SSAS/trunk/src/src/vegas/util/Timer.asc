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

/**
 * The {@code Timer} class is the interface to Flash Player timers. 
 * <p>You can create new Timer objects to run code on a specified time sequence. Use the start() method to start a timer.</p> 
 * <p>Add an EventListener for the timer event to set up code to be run on the timer interval.</p>
 * <p><b>Example :</b></p>
 * {@code
 * Delegate      = vegas.events.Delegate ;
 * EventListener = vegas.events.EventListener ;
 * TimerEvent    = vegas.events.TimerEvent ;
 * Timer         = vegas.util.Timer  ;
 * 
 * function onTimer( event ) 
 * {
 *     trace("onTimer: " + event.type) ;
 * }
 * 
 * var timeListener = new Delegate(this, onTimer) ;
 * 
 * var myTimer = new Timer(1500, 3) ;
 * myTimer.addEventListener(TimerEvent.START , timeListener);
 * myTimer.addEventListener(TimerEvent.STOP  , timeListener);
 * myTimer.addEventListener(TimerEvent.TIMER , timeListener);
 * myTimer.start();
 * }
 * @author eKameleon
 * @see TimerEvent
 */
if (vegas.util.Timer == undefined) 
{

	/**
	 * @requires vegas.util.factory.PropertyFactory
	 */
	require("vegas.util.factory.PropertyFactory") ;

	/**
	 * Creates a new Timer object with the specified delay and repeat state. 
	 * The timer does not start automatically; you much call the start() method to start it.
	 * @param delay the delay between two intervals in this timer.
	 * @param repeatCount the number of repetitions of this timer.
	 */
	vegas.util.Timer = function ( d /*Number*/ , count /*Number*/ ) 
	{
		
		vegas.events.EventDispatcher.call(this) ; // super() ;
		
		var TimerEvent /*Function*/ = vegas.events.TimerEvent ;
		var TimerEventType /*Function*/ = vegas.events.TimerEventType ;
		
		this._eRestart = new TimerEvent( TimerEventType.RESTART, this ) ;
		this._eStart = new TimerEvent( TimerEventType.START, this ) ;
		this._eStop = new TimerEvent(TimerEventType.STOP, this) ;
		this._eTimer = new TimerEvent( TimerEventType.TIMER , this ) ;
		
		this.setDelay( d ) ;
		
		this.setRepeatCount( count ) ;
		
	}

	/**
	 * @extends vegas.events.EventDispatcher
	 */
	proto = vegas.util.Timer.extend(vegas.events.EventDispatcher) ;

	/**
	 * Clear the timer interval.
	 */
	proto.clear = function () /*Void*/ 
	{
		clearInterval(this._itv) ;
	}

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function() /*Timer*/
	{
		return new vegas.util.Timer(this.getDelay(), this.setRepeatCount()) ;
	}
	
	/**
	 * Returns a deep copy of this object.
	 * @return a deep copy of this object.
	 */
	proto.copy = function() /*Timer*/
	{
		return new vegas.util.Timer(this.getDelay(), this.setRepeatCount()) ;
	}
	
	/**
	 * Returns the delay between timer events, in milliseconds.
	 * @return the delay between timer events, in milliseconds.
	 */
	proto.getDelay = function () 
	{
		return this._delay ;
	}

	/**
	 * Returns the interval id of this timer.
	 * This method is an internal method use with this class and this Unit test only.
	 * @return the interval id of this timer.
	 */
	proto.getIntervalID = function() /*Number*/
	{
		return _itv ;	
	}

	/**
	 * Returns the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops.
	 * @return the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops.
	 */
	proto.getRepeatCount = function () 
	{
		return this._repeatCount ;
	}

	/**
	 * Returns {@code true} if the timer is in progress.
	 * @return {@code true} if the timer is in progress.
	 */
	proto.getRunning = function() /*Boolean*/ 
	{
		return this._running ;	
	}

	/**
	 * Restarts the timer. The timer is stopped, and then started.
	 */
	proto.restart = function (noEvent /*Boolean*/) /*Void*/ 
	{
		if (this.getRunning()) this.stop() ;
		this._setRunning(true) ;
		this.run() ;
		if (noEvent != true) 
		{
			this.dispatchEvent( this._eRestart ) ;
		}
	}

	/**
	 * Run the timer.
	 * @see IRunnable
	 */
	proto.run = function () 
	{
		this._itv = setInterval(this, "_next", this._delay) ;
	}

	/**
	 * Sets the delay between timer events, in milliseconds.
	 */
	proto.setDelay = function ( n /*Number*/ ) /*Void*/ 
	{
		this._delay = (n > 0) ? n : 0 ;
		if (this.getRunning()) {
			this.restart() ;
		}
	}

	/**
	 * Sets the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops.
	 */
	proto.setRepeatCount = function( n /*Number*/ )/*Void*/ 
	{
		this._repeatCount = (n > 0) ? n : 0 ;
	}

	/**
	 * Starts the timer, if it is not already running.
	 */
	proto.start = function() /*Void*/ 
	{
		if (this.getRunning()) return ;
		this._count = 0 ;
		this.dispatchEvent( this._eStart ) ;
		this.restart(true) ;
	}

	/**
	 * Stops the timer.
	 */
	proto.stop = function() /*Void*/ 
	{
		this._setRunning(false) ;
		this.clear() ;
		this.dispatchEvent( this._eStop ) ;
	}
	
	/**
	 * Returns the String representation of this object.
	 * @return the String representation of this object.
	 */
	proto.toString = function () 
	{
		return "[Timer]" ;
	}

	/**
	 * (read-write) The delay between timer events, in milliseconds.
	 */
	vegas.util.factory.PropertyFactory.create(proto, "delay") ;

	/**
	 * (read-write) The number of repetitions. 
	 * If zero, the timer repeats infinitely. 
	 * If nonzero, the timer runs the specified number of times and then stops.
	 */
	vegas.util.factory.PropertyFactory.create(proto, "repeatCount") ;

	/**
	 * (read-only) Returns {@code true} if the timer is in progress.
	 */
	vegas.util.factory.PropertyFactory.create(proto, "running", true) ;

	/**
	 * @private
	 */	
	proto._count /*Number*/ = null ;

	/**
	 * @private
	 */	
	proto._delay /*Number*/ = null ;

	/**
	 * @private
	 */	
	proto._itv /*Number*/ = null ;

	/**
	 * @private
	 */	
	proto._repeatCount /*Number*/ = null ;

	/**
	 * @private
	 */	
	proto._running /*Boolean*/ = null ;

	/**
	 * @private
	 */	
	proto._next = function() /*Void*/ 
	{
		this.dispatchEvent( this._eTimer ) ;
		this._count ++ ;
		if (this._repeatCount != 0 && this._repeatCount == this._count) 
		{
			this.stop() ;
		}
	}
	
	/*protected*/ proto._setRunning = function (b /*Boolean*/) /*Void*/ 
	{
		this._running = b ;
	}

	delete proto ;
	
}