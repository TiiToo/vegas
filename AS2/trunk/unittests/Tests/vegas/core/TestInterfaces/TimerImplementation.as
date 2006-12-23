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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.ITimer;
import vegas.events.Event;
import vegas.events.EventListener;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestInterfaces.TimerImplementation implements ITimer 
{
	
	private var _delay:Number ;
	private var _repeatCount:Number ;
	
	public var isAddEventListener:Boolean = false ;
	public var isClear:Boolean = false ;
	public var isRestart:Boolean = false ;
	public var isRunning:Boolean = false ;
	public var isStarted:Boolean = false ;
	public var isStopped:Boolean = false ;

	public function addEventListener(eventName : String, listener : EventListener, useCapture : Boolean, priority : Number, autoRemove : Boolean) : Void 
	{
		isAddEventListener = true ;
	}

	public function clear():Void 
	{
		isClear = true ;
	}

	public function dispatchEvent(event, isQueue : Boolean, target, context) : Event 
	{
		return new Event() ;
	}

	public function getDelay():Number 
	{
		return _delay ;
	}

	public function getRepeatCount():Number 
	{
		return _repeatCount ;
	}

	public function restart(noEvent:Boolean) : Void 
	{
		isRestart = true ;
	}

	public function run() : Void 
	{
		isRunning = true ;
	}

	public function start():Void
	{
		isStarted = true ;
	}

	public function setDelay(n:Number) : Void 
	{
		_delay = n ;
	}

	public function setRepeatCount(n : Number) : Void 
	{
		_repeatCount = n ;
	}

	public function stop() : Void 
	{
		isStopped = true ;
	}

	public function removeEventListener(eventName : String, listener, useCapture : Boolean) : EventListener 
	{
		return new EventListener() ;
	}

}