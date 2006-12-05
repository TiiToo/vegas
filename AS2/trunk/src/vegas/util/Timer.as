﻿/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** Timer


	EXAMPLE
	
		import vegas.events.Delegate ;
		import vegas.events.EventListener ;
		import vegas.events.TimerEvent ;
		import vegas.events.TimerEventType ;
		import vegas.util.Timer  ;
		
		function onTimer(event:TimerEvent):Void {
			trace("onTimer: " + event.type) ;
		}
		
		var timeListener:EventListener = new Delegate(this, onTimer) ;
		
		var myTimer:Timer = new Timer(1500, 3) ;
		myTimer.addEventListener(TimerEventType.START, timeListener);
		myTimer.addEventListener(TimerEventType.STOP, timeListener);
		myTimer.addEventListener(TimerEventType.TIMER, timeListener);
		myTimer.start();
		

	PROPERTIES
	
		- delay:Number [R/W] 
		
			
		
		- repeatCount:Number [R/W]
			
			Specifies the number of repetitions. 
			If zero, the timer repeats infinitely. 
			If nonzero, the timer runs the specified number of times and then stops.
		
		- running:Boolean

	METHODS
	
		- clear():Void
		
		- getDelay():Number
		
		- getRepeatCount():Number
		
		- run()
		
		- restart()
		
			Restarts the timer. The timer is stopped, and then started.
		
		- setDelay(n:Number)
		
		- setRepeatCount(n:Number)
		
		- start()
		
			Starts the timer, if it is not already running.
		
		- stop()
		
			Stops the timer.

	EVENT SUMMARY
	
		TimerEvent
	
			- TimerEventType.RESTART
			
			- TimerEventType.START
			
			- TimerEventType.STOP
			
			- TimerEventType.TIMER
				A Timer object generates the timer event whenever a timer tick occurs.

	INHERIT
	
		CoreObject → EventDispatcher → AbstractTimer → Timer

	IMPLEMENTS 
	
		EventTarget, ICloneable, IEventDispatcher, IFormattable, ITimer, IRunnable

	SEE ALSO
	
		- EventDispatcher
		- RangeError
		- TimerEvent
		- TimerEventType

**/

import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.AbstractTimer;

/**
 * @author eKameleon
 */
class vegas.util.Timer extends AbstractTimer 
{

	/**
	 * Creates a new Timer object with the specified delay and repeat state. 
	 * The timer does not start automatically; you much call the start() method to start it.
	 */
	public function Timer(delay:Number, repeatCount:Number) {
		super(delay, repeatCount) ;
	}

	/**
	 * Clear the timer interval.
	 */
	/*override*/ public function clear():Void 
	{
		clearInterval(_itv) ;
	}
	
	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	/*override*/ public function clone() 
	{
		return new Timer(_delay, _repeatCount) ;
	}

	/*override*/ public function run():Void {
		_itv = setInterval(this, "_next", _delay) ;
	}
	
	/**
	 * The internal timer interval.
	 */
	private var _itv:Number ;
	
	/**
	 * Launch the next interval.
	 */
	private function _next():Void 
	{
		dispatchEvent( new TimerEvent(TimerEventType.TIMER, this) ) ;
		_count ++ ;
		if (_repeatCount != 0 && _repeatCount == _count) 
		{
			this.stop() ;
		}
	}
	
}