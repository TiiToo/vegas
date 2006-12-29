/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** AutoScrollContainer

	AUTHOR

		Name : AutoScrollContainer
		Package : eka.container
		Version : 1.0.0.1
		Date :  2006-02-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
		
		* autoScroll[boolean] (R/W)
		
			the auto scroll is active if this property is true.
		
		* scrollAutoRatio[Number] 
		
			% value between 0 and 50%.
		
		* scrollInterval[Number]
		 
			delay in ms to refresh the scroll value.
	
	METHOD SUMMARY
	
		* getScrollInterval()
		
		* setScrollInterval(n)
	
	EVENT SUMMARY
	
		- MouseEvent
		
		- UIEvent
	
	EVENT TYPE SUMMARY
	
		- ROLLOUT:MouseEventType
		
		- ROLLOVER:MouseEventType
		
		- SCROLL:UIEventType
	
	INHERIT
	
		AbstractComponent → AbstractContainer → SimpleContainer → ListContainer → ScrollContainer → AutoScrollContainer
	
	SEE ALSO
	
		Delegate, ITimer, Timer

	TODO scrollAutoRation -> Virtual Property with Range between 0 & 50%

**/

import asgard.display.Direction;

import lunas.display.components.container.ScrollContainer;

import pegas.events.MouseEvent;
import pegas.events.MouseEventType;

import vegas.events.Delegate;
import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.Timer;

class lunas.display.components.container.AutoScrollContainer extends ScrollContainer {
	
	// ----o Constructor

	private function AutoScrollContainer () {
		super() ;
		_timer = new Timer(200);
		_timer.addEventListener(TimerEventType.TIMER, new Delegate(this, _mouseEvent));
		updateMouseEvent() ;
	}
	
	// ----o Constant	
	
	static public var ROLLOUT:String = MouseEventType.ROLLOUT ;
	static public var ROLLOVER:String = MouseEventType.ROLLOVER ;

	// ----o Public Properties
	
	public var scrollAutoRatio:Number = 10 ;
	public var useHandCursor = false ;

	// ----o Public Methods

	public function getAutoScroll():Boolean { 
		return _auto ;
	}

	public function getIsOut():Boolean {
		return (__mouse.x < __min.x) || (__mouse.x > __max.x) || (__mouse.y < __min.y) || (__mouse.y > __max.y) ;
	}

	public function getLimit():Object { 
		return { min : __min , max : __max } ;
	}

	public function getMousePos():Object { return __mouse; }


	public function getPosRatio():Number {
		var prop:String = (_nDirection == Direction.VERTICAL) ? "y" : "x" ;
		var ratio:Number = Math.round (__mouse[prop] * 100 / __max[prop])  ;
		return ratio ;
	}
	
	public function getScrollInterval():Number { 
		return _timer.getDelay() ;
	} 

	public function setAutoScroll(bool:Boolean):Void { 
		_auto = bool ; 
		stopMouseEvent() ;
	}

	public function setLocalizer () : Void {
		var c:MovieClip = _mcMask ;
		__min = { x: c._x, y: c._y } ;
		__max = { 
			x: c._x + c.w , 
			y: c._y + c.h 
		};
	}
	
	public function setScrollInterval(n:Number):Void { 
		_timer.setDelay(n) ;
	} 
	
	public function startMouseEvent() : Void {
		delete onRollOver ;
		dispatchEvent(new MouseEvent(ROLLOVER, this)) ;
		if (_auto) {
			setLocalizer () ;
			_timer.start() ;
		}
	}
	
	public function stopMouseEvent(noEvent:Boolean):Void {
		if (noEvent != true) dispatchEvent(new MouseEvent(ROLLOUT, this)) ;
		_timer.stop() ;
		 updateMouseEvent() ;
	}

	public function updateMouseEvent():Void {
		if (_auto && enabled) {
			onRollOver = Delegate.create(this, startMouseEvent) ;
		}
	}
	
	/*override*/ public function viewChanged():Void {
		super.viewChanged() ;
		stopMouseEvent(true) ;
	}
	
	/*override*/ public function viewDestroyed():Void {
		super.viewDestroyed() ;
		_timer.stop() ;
	}
	
	/*override*/ public function viewEnabled():Void {
		super.viewEnabled() ; 
		if (enabled) 
		{
			startMouseEvent();
		}else
		{
			stopMouseEvent() ;
		}
	}

	// ----o Virtual Properties

	public function get autoScroll():Boolean {
		return getAutoScroll() ;	
	}

	public function set autoScroll(b:Boolean):Void {
		setAutoScroll(b) ;	
	}

	public function get scrollInterval():Number {
		return getScrollInterval() ;	
	}

	public function set scrollInterval(n:Number):Void {
		setScrollInterval(n) ;	
	}

	// ----o Private Properties

	private var _auto:Boolean = true;
	private var __min:Object ;
	private var __max:Object ;
	private var __mouse:Object ;
	private var _timer:Timer ;
	
	// ----o Private Methods
		
	private function _mouseEvent( e:TimerEvent ):Void {
		__mouse = { x:_xmouse , y:_ymouse } ;
		var nR:Number = getPosRatio() ;
		var nMax:Number = scrollAutoRatio || 0 ;
		var nS:Number = getScroll() ;
		if (getIsOut()) {
			stopMouseEvent () ;
		} else if (nR < nMax) {
			setScroll(nS-1) ;
		} else if ( nR> (100-nMax)) {
			setScroll(nS+1) ;
		}
		
	}
	
}