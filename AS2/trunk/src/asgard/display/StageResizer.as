/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Luna Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* ----- StageResizer
	
	AUTHOR

		Name : StageResizer
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2005-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		StageResizer(autoResize:Boolean, delay:Number)

	USE
	
		import asgard.display.StageResizer ;
		import vegas.events.* ;
		
		var onDebug = function (ev:Event) {
			trace (">> " + ev.getType() ) ;
		}
		
		var debug:EventListener = new EventListenerProxy(this, onDebug) ;
		
		var resizer:StageResizer = new StageResizer(true) ;
		resizer.addEventListener(EventType.RESIZE, debug) ;


	DESCRIPTION
		
		Permet de controler des évéments de type Stage.onResize plus lentement via l'évément EventType.RESIZE.

	STATIC PROPERTY SUMMARY
	
		DEFAULT_DELAY:Number [R/W] default delay value (default : 300 ms)

	PROPERTY SUMMARY
	
		delay:Number [R/W] permet de définir un interval en ms pour ralentir l'événement onResize
	
	
	METHOD SUMMARY
	
		- getDelay():Number
		
		- handleEvent(ev:Event)
		
		- setDelay(delay:Number):Void
		
		- toString():String
	
	EVENTS
	
		- DynamicEvent
		
			- EventType.RESIZE
	
	INHERIT
	
		EventDispatcher > StageResizer
	
	IMPLEMENTS
	
		EventListener, IFormattable
	
----------------*/

import vegas.events.Event ;
import vegas.events.EventType ;
import vegas.events.DynamicEvent ;
import vegas.events.EventDispatcher ;
import vegas.events.EventListener ;
import vegas.events.TimerEventType ;

import vegas.util.Timer ;
import vegas.core.IFormattable ;

class asgard.display.StageResizer extends EventDispatcher implements EventListener, IFormattable {

	// ----o Constructor

	public function StageResizer(autoResize:Boolean, delay:Number) {
		_timer = new Timer(isNaN(delay) ? DEFAULT_DELAY : delay, 1) ;
		_timer.addEventListener(TimerEventType.TIMER, this) ;
		Stage.addListener(this) ;
		if (autoResize) onResize() ;
	}

	// ----o Static Properties
	
	static public function get DEFAULT_DELAY():Number {
		return __defaultDelay ;
	}

	static public function set DEFAULT_DELAY(delay:Number):Void {
		__defaultDelay = (isNaN(delay) || delay < 0) ? 0 : delay ;
	}

	static private var __defaultDelay = 300 ;

	// ----o Public Methods
	
	public function getDelay():Number { 
		return _timer.getDelay() ;
	}
	
	public function handleEvent(e:Event) {
		dispatchEvent( new DynamicEvent(EventType.RESIZE, this) ) ;
	}
	
	public function setDelay(time:Number):Void { 
		_timer.setDelay(time) ;
	}
	
	public function toString():String {
		return "[StageResizer]" ;
	}

	// ----o Virtual Properties	
	
	public function get delay():Number { 
		return getDelay () ;
	}
	
	public function set delay(time:Number):Void {
		setDelay(time) ;
	}	

	// ----o Private Properties

	private var _timer:Timer ;
	
	// ----o Private Methods
	
	private function onResize(Void):Void {
		_timer.stop() ;
		_timer.start() ;
	}
	
}