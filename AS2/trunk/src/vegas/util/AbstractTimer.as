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

/** AbstractTimer

	AUTHOR

		Name : AbstractTimer
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-11-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- delay:Number [R/W] 
		
			The delay between timer events, in milliseconds.
		
		- repeatCount:Number [R/W]
			
			Specifies the number of repetitions. 
			If zero, the timer repeats infinitely. 
			If nonzero, the timer runs the specified number of times and then stops.
		
		- running:Boolean

	METHOD SUMMARY
	
		- clear() [override]
		
		- getDelay():Number
		
		- getRepeatCount():Number
		
		- restart()
		
			Restarts the timer. The timer is stopped, and then started.
		
		- run() [override]
		
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
	
		Object > EventDispatcher > AbstractTimer

	IMPLEMENTS 
	
		ICloneable, EventTarget, IEventDispatcher, ITimer, IRunnable, IFormattable

	SEE ALSO
	
		- EventDispatcher
		- TimerEvent
		- TimerEventType

**/

import vegas.core.ICloneable;
import vegas.core.IFormattable;
import vegas.core.IRunnable;
import vegas.core.ITimer;
import vegas.events.EventDispatcher;
import vegas.events.TimerEvent;
import vegas.events.TimerEventType;

class vegas.util.AbstractTimer extends EventDispatcher implements ICloneable, ITimer, IFormattable, IRunnable {

	// ----o Construtor
	
	private function AbstractTimer(d:Number, count:Number) {
		setDelay(d) ;
		setRepeatCount(count) ;
	}

	// ----o Public Methods	

	public function clear():Void {
		// override this method
	}
	
	public function clone() {
		return new AbstractTimer(_delay, _repeatCount) ; // override this method
	}

	public function getDelay():Number {
		return _delay ;
	}

	public function getRepeatCount():Number {
		return _repeatCount ;
	}

	public function getRunning():Boolean {
		return _running ;	
	}

	public function restart(noEvent:Boolean):Void {
		if (getRunning()) stop() ;
		_setRunning(true) ;
		run() ;
		if (!noEvent) dispatchEvent( new TimerEvent( TimerEventType.RESTART, this) ) ;
	}

	public function run():Void {
		// override this method
	}
	
	public function setDelay(n:Number):Void {
		_delay = (n > 0) ? n : 0 ;
		if (getRunning()) {
			restart() ;
		}
	}

	public function setRepeatCount(n:Number):Void {
		_repeatCount = (n > 0) ? n : 0 ;
	}

	public function start():Void {
		if (getRunning()) return ;
		_count = 0 ;
		dispatchEvent( new TimerEvent(TimerEventType.START, this) ) ;
		restart(true) ;
	}
	
	public function stop():Void {
		_setRunning(false) ;
		clear() ;
		dispatchEvent( new TimerEvent(TimerEventType.STOP, this) ) ;
	}
	
	// ----o Virtual Properties
	
	public function  get delay():Number {
		return getDelay() ;
	}
	
	public function set delay( n:Number ):Void {
		setDelay(n) ;	
	}

	public function  get repeatCount():Number {
		return getRepeatCount() ;
	}
	
	public function set repeatCount ( n:Number ):Void {
		setRepeatCount(n) ;	
	}
	
	public function  get running():Boolean {
		return getRunning() ;
	}	

	// -----o Private Properties
	
	private var _count:Number ;
	private var _delay:Number ;
	private var _repeatCount:Number ;
	private var _running:Boolean ;
	
	// ----o Private Methods
	
	private function _setRunning(b:Boolean):Void {
		_running = b ;
	}

}