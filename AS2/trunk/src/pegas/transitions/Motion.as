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

import pegas.process.AbstractAction;

import vegas.core.ITimer;
import vegas.events.Delegate;
import vegas.events.EventListener;
import vegas.events.TimerEventType;
import vegas.util.FrameTimer;
import vegas.util.Timer;

/**
 * @author eKameleon
 */
class pegas.transitions.Motion extends AbstractAction 
{

	/**
	 * Creates a new Motion instance.
	 */
	private function Motion() 
	{
		_oNext = new Delegate(this, nextFrame) ;
	}

	public function get duration():Number 
	{
		return getDuration() ;
	}
	
	public function set duration( n:Number ):Void 
	{
		setDuration(n) ;
	}

	public function get fps():Number 
	{
		return getFPS() ;
	}
	
	public function set fps( n:Number ):Void 
	{
		setFPS(n) ;
	}

	public var prevTime:Number ;

	public function get target() 
	{
		return getTarget() ;	
	}
	
	public function set target( oT ) 
	{
		setTarget( oT ) ;	
	}

	public var useSeconds:Boolean ;

	public function clone() 
	{
		//
	}
	
	public function fforward():Void 
	{ 
		setTime (_duration) ;
		_fixTime() ;
	}
	
	public function getDuration():Number 
	{ 
		return _duration ;
	}

	public function getFPS ():Number 
	{ 
		return _fps;
	}

	public function getTarget() 
	{
		return _target ;
	}

	public function getTime():Number 
	{ 
		return _time ;
	}

	public function nextFrame():Void 
	{ 
		var t:Number = (useSeconds) ? ((getTimer() - _startTime) / 1000) : (_time + 1) ;
		setTime(t) ;
	}
	
	public function prevFrame():Void 
	{
		if (!useSeconds) setTime (_time - 1)  ;
	}
	
	public function resume():Boolean 
	{
		if (_stopping && _time != duration) 
		{
			_fixTime() ;
			startInterval() ;
			return true ;
			notifyResumed() ;
		}
		else 
		{
			return false ;
		}
	}
	
	public function rewind(t:Number):Void 
	{
		_time = t || 0 ;
		_fixTime() ;
		update() ;
	}
	
	public function run():Void 
	{
		notifyStarted() ;
		rewind() ;
		startInterval() ;
	}

	public function setDuration(n:Number):Void 
	{ 
		_duration = (isNaN(n) || n <= 0 ) ? _global.Infinity : n ;
	}
	
	public function setFPS (n:Number):Void 
	{
		var tmp:Boolean = running ;
		_timer.stop() ;
		_fps = n ;
		if (tmp) _timer.start() ;
	}
	
	public function setTarget(o):Void 
	{
		_target = o ;
	}
	
	public function setTime(t:Number):Void 
	{
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

	public function setTimer(timer:ITimer):Void 
	{
		if (_timer) 
		{
			_timer.stop();
			_timer.removeEventListener(TimerEventType.TIMER, _oNext) ;
			_timer = null ;
		}
		_timer = timer ;
		_timer.addEventListener(TimerEventType.TIMER, _oNext ) ;
	}
	
	public function start():Void 
	{
		_stopping = false ; 
		run() ;
	}
	
	public function startInterval():Void 
	{
		if (_fps) 
		{
			setTimer(new Timer(1000 / _fps)) ;
		}
		else 
		{
			setTimer(new FrameTimer()) ;
		}
		_timer.start() ; 
		_setRunning(true) ;
	}
	
	public function stop():Void 
	{
		stopInterval() ;
		_stopping = true ;
		notifyStopped() ;
	}
	
	public function stopInterval():Void 
	{
		_timer.stop() ;
		_setRunning(false) ;
	}
	
	public function update():Void 
	{
		//
	}
	


	// ----o Private Properties
	
	private var _duration:Number ;
	private var _fps:Number ;
	private var _oNext:EventListener ;
	private var _startTime:Number ;
	private var _stopping:Boolean ;
	private var _target ;
	private var _time:Number ;
	private var _timer:ITimer ;
	
	// ----o Private Methods
	
	private function _fixTime():Void {
		if ( useSeconds) _startTime = getTimer() - _time * 1000 ;
	}
	
}