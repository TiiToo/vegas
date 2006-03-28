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

/* ---------------- Motion

	AUTHOR
	
		Name : Motion
		Package : asgard.transitions
		Version : 1.0.0.0
		Date :  2005-09-06
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		Private Constructor

	PROPERTY SUMMARY
		
		- duration:Number [R/W]
		
		- fps:Number [R/W]
		
		- looping:Boolean
		
		- prevTime:Number
		
		- running:Boolean
		
		- target:Object [R/W]
		
		- useSeconds:Boolean
	
	
	METHOD SUMMARY
	
		- addEventListener( eventName:String, listener, autoRemove:Boolean, priority:Number ):Void
		
		- clone() 
		
			override this method
	
		- fforward():Void

		- getDuration():Number

		- getEventDispatcher():EventDispatcher
		
		- getFPS():Number
		
		- getTarget()
		
		- getTime():Number
		
		- nextFrame():Void

		- notifyChanged():Void
		
		- notifyCleared():Void
		
		- notifyFinished():Void 
		
		- notifyLooped():Void
		
		- notifyResumed():Void
		
		- notifyStarted():Void
		
		- notifyStopped():Void
		
		- prevFrame(Void):Void
		
		- resume():Boolean
		
		- rewind(t:Number):Void
		
		- removeEventListener(eventName:String, listener):EventListener
		
		- run():Void
		
		- setDuration(n:Number):Void
		
		- setFPS (n:Number):Void
		
		- setTarget(o):Void
		
		- setTime(t:Number):Void
		
		- setTimer(timer:ITimer):Void
		
		- start():Void
		
		- startInterval():Void
		
		- stop():Void
		
		- stopInterval():Void
		
		- toString():String
		
		- update():Void
		
		- toString():String
	
	EVENT SUMMARY
	
		- ActionEventType.FINISH  : "finished"
		
		- ActionEventType.LOOP : "looped"
		
		- ActionEventType.RESUME : "resumed"
		
		- ActionEventType.START : "started"
		
		- ActionEventType.STOP : "stopped"

	INHERIT
	
		CoreObject > AbstractCoreEventDispatcher > AbstractAction > Motion

	IMPLEMENTS
	
		Action, ICloneable, IRunnable, IFormattable

---------------*/

import asgard.process.AbstractAction ;

import vegas.events.Delegate ;
import vegas.events.EventListener ;
import vegas.events.TimerEventType ;
import vegas.util.factory.PropertyFactory ;
import vegas.util.FrameTimer ;
import vegas.core.ITimer ;
import vegas.util.Timer ;

class asgard.transitions.Motion extends AbstractAction {

	// ----o Constructor

	private function Motion() {
		_oNext = new Delegate(this, nextFrame) ;
	}
	
	// ----o Public Properties

	public var duration:Number ; // [RW]
	public var fps:Number ; // [RW]
	public var useSeconds:Boolean ;
	public var prevTime:Number ;
	public var target ; // [RW]
	
	// ----o Public Methods
	
	public function clone() {
		//
	}
	
	public function fforward():Void { 
		setTime (_duration) ;
		_fixTime() ;
	}
	
	public function getDuration():Number { 
		return _duration ;
	}

	public function getFPS ():Number { 
		return _fps;
	}

	public function getTarget() {
		return _target ;
	}

	public function getTime():Number { 
		return _time ;
	}

	public function nextFrame():Void { 
		var t:Number = (useSeconds) ? ((getTimer() - _startTime) / 1000) : (_time + 1) ;
		setTime(t) ;
	}
	
	public function prevFrame():Void {
		if (!useSeconds) setTime (_time - 1)  ;
	}
	
	public function resume():Boolean {
		if (_stopping && _time != duration) {
			_fixTime() ;
			startInterval() ;
			return true ;
			notifyResumed() ;
		} else {
			return false ;
		}
	}
	
	public function rewind(t:Number):Void {
		_time = t || 0 ;
		_fixTime() ;
		update() ;
	}
	
	public function run():Void {
		notifyStarted() ;
		rewind() ;
		startInterval() ;
	}

	public function setDuration(n:Number):Void { 
		_duration = (isNaN(n) || n <= 0 ) ? _global.Infinity : n ;
	}
	
	public function setFPS (n:Number):Void {
		var tmp:Boolean = running ;
		_timer.stop() ;
		_fps = n ;
		if (tmp) _timer.start() ;
	}
	
	public function setTarget(o):Void {
		_target = o ;
	}
	
	public function setTime(t:Number):Void {
		prevTime = _time ;
		if (t > _duration) {
			if (looping) {
				rewind (t - _duration);
				this.update();
				notifyLooped() ;
			} else {
				if (useSeconds) {
					_time = _duration ;
					update() ;
				}
				this.stop() ;
				notifyFinished() ;
			}
		} else if (t<0) {
			rewind() ;
			update() ;
		} else {
			_time = t ;
			update() ;
		}
	}

	public function setTimer(timer:ITimer):Void {
		if (_timer) {
			_timer.stop();
			_timer.removeEventListener(TimerEventType.TIMER, _oNext) ;
			_timer = null ;
		}
		_timer = timer ;
		_timer.addEventListener(TimerEventType.TIMER, _oNext ) ;
	}
	
	public function start():Void {
		_stopping = false ; 
		run() ;
	}
	
	public function startInterval():Void {
		if (_fps) {
			setTimer(new Timer(1000 / _fps)) ;
		} else {
			setTimer(new FrameTimer()) ;
		}
		_timer.start() ; 
		_setRunning(true) ;
	}
	
	public function stop():Void {
		stopInterval() ;
		_stopping = true ;
		notifyStopped() ;
	}
	
	public function stopInterval():Void {
		_timer.stop() ;
		_setRunning(false) ;
	}
	
	public function update():Void {
		//
	}
	
	// ----o Virtual Properties

	static private var __DURATION__:Boolean = PropertyFactory.create(Motion, "duration", true) ;
	static private var __FPS__:Boolean = PropertyFactory.create(Motion, "fps", true) ;
	static private var __TARGET__:Boolean = PropertyFactory.create(Motion, "target", true) ;

	// ----o Private Properties
	
	private var _duration:Number ;
	private var _fps:Number ;
	private var _oNext:EventListener ;
	private var _startTime:Number ;
	private var _stopping:Boolean ;
	private var _target:Object ;
	private var _time:Number ;
	private var _timer:ITimer ;
	
	// ----o Private Methods
	
	private function _fixTime():Void {
		if ( useSeconds) _startTime = getTimer() - _time * 1000 ;
	}
	
}