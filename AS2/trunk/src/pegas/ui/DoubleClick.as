﻿/*

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

import pegas.events.MouseEvent;
import pegas.events.MouseEventType;

import vegas.events.Event;
import vegas.events.FastDispatcher;

class pegas.ui.DoubleClick 
{

	static public function get delay():Number
	{
		return _delay ;
	}
   
	static public function set delay(n:Number):Void 
	{
		_delay = n > 0 ? n : 0 ;
	}

	static public function get ISDOUBLE():Boolean 
	{
		if (!_dispatcher) initialize() ;
		return __ISDOUBLE__ ;
	}

	static public function addListener(listener):Boolean 
	{
		if (!_dispatcher) initialize() ;
		return _dispatcher.addListener(listener) ;
	}
	
	static public function initialize():Void 
	{
		_dispatcher = new FastDispatcher() ;
		Mouse.addListener(DoubleClick) ;
		reset() ;
	}

	static public function release():Void 
	{
		reset() ;
		Mouse.removeListener(DoubleClick) ;
	}

	static public function removeListener(listener):Boolean 
	{
		return _dispatcher.removeListener(listener) ;
	}
	
	static public function removeAllListeners():Void 
	{
		_dispatcher.removeAllListeners() ;
	}

	static public function toString():String 
	{
		return "[DoubleClick]" ;
	}

	static private var _delay:Number = 250 ;
	static private var _itv:Number ;
	static private var _cpt:Number ;
	static private var _dispatcher:FastDispatcher ;
	static private var __ISDOUBLE__:Boolean = false ;
	
	static private function onMouseDown():Void
	{
		_cpt ++ ;
		__ISDOUBLE__ = _cpt == 2 ;
		clearInterval(_itv) ;
		var type:String = (_cpt == 2)  ? MouseEventType.DOUBLE_CLICK : MouseEventType.CLICK ;
		var ev:Event = new MouseEvent(type, DoubleClick) ;
		_dispatcher.dispatch( ev ) ;
		_itv = setInterval( reset , _delay) ;
	}
	
	static private function reset():Void
	{
		clearInterval(_itv);
		__ISDOUBLE__ = false ;
		_cpt = 0 ;
	}
	
}