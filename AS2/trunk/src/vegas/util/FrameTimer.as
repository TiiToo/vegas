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

/** Timer

	AUTHOR

		Name : FrameTimer
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-11-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	 
		Constructs a new FrameTimer object with the specified delay and repeat state.
		The timer does not start automatically, you much call the start() method to start it.

	EXAMPLE
	
		import vegas.events.EventListener ;
		import vegas.events.EventListenerProxy ;
		import vegas.events.TimerEvent ;
		import vegas.events.TimerEventType ;
		import vegas.util.FrameTimer  ;
		
		function onTimer(event:TimerEvent):Void {
			trace("onTimer: " + event.type) ;
		}
		
		var timeListener:EventListener = new EventListenerProxy(this, onTimer) ;
		
		var myTimer:FrameTimer = new FrameTimer(24, 10) ;
		myTimer.addEventListener(TimerEventType.START, timeListener);
		myTimer.addEventListener(TimerEventType.STOP, timeListener);
		myTimer.addEventListener(TimerEventType.TIMER, timeListener);
		myTimer.start();
		
		Key.addListener(this) ;
		onKeyDown = function () {
			myTimer.running ? myTimer.stop() : myTimer.restart() ;
		}

	PROPERTIES
	
		- delay:Number [R/W] 
		
			The delay between timer events, in frame/seconds
		
		- repeatCount:Number [R/W]
			
			Specifies the number of repetitions. 
			If zero, the timer repeats infinitely. 
			If nonzero, the timer runs the specified number of times and then stops.
		
		- running:Boolean

	METHODS
	
		- clear():Void
		
		- getDelay():Number
		
		- getRepeatCount():Number
		
		- restart()
		
			Restarts the timer. The timer is stopped, and then started.
		
		- run()
		
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
	
		EventDispatcher > AbstractTimer > Timer

	IMPLEMENTS 
	
		ICloneable, EventTarget, IEventDispatcher, ITimer, IRunnable, IFormattable

	SEE ALSO
	
		- EventDispatcher
		- RangeError
		- TimerEvent
		- TimerEventType

**/

import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.AbstractTimer;
import vegas.util.FrameBeacon;

class vegas.util.FrameTimer extends AbstractTimer {

	// ----o Construtor
	
	public function FrameTimer(delay:Number, repeatCount:Number) {
		super(delay, repeatCount) ;
	}

	// ----o Public Methods	

	/*override*/ public function clear():Void {
		FrameBeacon.removeFrameListener(this) ;
	}

	/*override*/ public function clone() {
		return new FrameTimer(_delay, _repeatCount) ;
	}

	/*override*/ public function run():Void {
		FrameBeacon.addFrameListener(this) ;
	}

	// ----o Private Properties
	
	private var _next:Number = 0 ;
	
	// ----o Private Methods
	
	private function onEnterFrame():Void {
		if (++_next >= _delay) {
			dispatchEvent( new TimerEvent(TimerEventType.TIMER, this) ) ;
			_next = 0 ;
			_count ++ ;
		}
		if (_repeatCount && _count >= _repeatCount) this.stop() ;
	}
	
}