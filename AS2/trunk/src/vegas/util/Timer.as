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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* ------- Timer

	AUTHOR

		Name : Timer
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-11-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	 
		Constructs a new Timer object with the specified delay  and repeat state.
		The timer does not start automatically; you much call the start() method to start it.

	EXAMPLE
	
		import vegas.events.EventListener ;
		import vegas.events.EventListenerProxy ;
		import vegas.events.TimerEvent ;
		import vegas.events.TimerEventType ;
		import vegas.util.Timer  ;
		
		function onTimer(event:TimerEvent):Void {
			trace("onTimer: " + event.type) ;
		}
		
		var timeListener:EventListener = new EventListenerProxy(this, onTimer) ;
		
		var myTimer:Timer = new Timer(1500, 3) ;
		myTimer.addEventListener(TimerEventType.START, timeListener);
		myTimer.addEventListener(TimerEventType.STOP, timeListener);
		myTimer.addEventListener(TimerEventType.TIMER, timeListener);
		myTimer.start();
		

	PROPERTIES
	
		- delay:Number [R/W] 
		
			The delay between timer events, in milliseconds.
		
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
			

	EVENTS
	
		- restartEvent
		
		- start Event
		
		- stop Event
		
		- timer Event
		
			A Timer object generates the timer event whenever a timer tick occurs.

	INHERIT
	
		Object > EventDispatcher > AbstractTimer > Timer

	IMPLEMENTS 
	
		ICloneable, EventTarget, IEventDispatcher, ITimer, IRunnable, IFormattable

	SEE ALSO
	
		- EventDispatcher
		- RangeError
		- TimerEvent
		- TimerEventType

----------  */

import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.AbstractTimer;

class vegas.util.Timer extends AbstractTimer {

	// ----o Construtor
	
	public function Timer(delay:Number, repeatCount:Number) {
		super(delay, repeatCount) ;
	}

	// ----o Public Methods	

	/*override*/ public function clear():Void {
		clearInterval(_itv) ;
	}

	/*override*/ public function clone() {
		return new Timer(_delay, _repeatCount) ;
	}

	/*override*/ public function run():Void {
		_itv = setInterval(this, "_next", _delay) ;
	}
	
	// -----o Private Properties
	
	private var _itv:Number ;
	
	// ----o Private Methods
	
	private function _next():Void {
		dispatchEvent( new TimerEvent(TimerEventType.TIMER, this) ) ;
		_count ++ ;
		if (_repeatCount != 0 && _repeatCount == _count) this.stop() ;
	}
	
}