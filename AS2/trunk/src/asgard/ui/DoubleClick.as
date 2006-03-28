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

/** DoubleClick

	AUTHOR
	
		Name : DoubleClick
		Package : asgard.ui
		Version : 1.0.0.0
		Date :  2005-08-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	STATIC PROPERTY SUMMARY
	
		- DoubleClick.ISDOUBLE:Boolean [Read Only]
		
		- DoubleClick.delay:Number : default 250

	STATIC METHOD SUMMARY
	
		- DoubleClick.addListener(listener):Boolean
		
		- DoubleClick.initialize()
		
		- DoubleClick.release()
		
		- DoubleClick.removeListener(listener):Boolean
		
		- DoubleClick.removeAllListeners()
		
		- DoubleClick.toString():String

	EVENT SUMMARY
	
		MouseEventType.DOUBLE_CLICK (doubleClick)
			émis lorsque l'utilisateur doubleclick sur le bouton de la souris
		
		MouseEventType.CLICK (click)
			émis lorsque l'utilisateur clique sur le bouton gauche de la souris


	TODO : version flash 8 use setTimeout !
	
----------  */

import vegas.events.Event ;
import vegas.events.FastDispatcher ;

import asgard.events.MouseEvent ;
import asgard.events.MouseEventType ;

class asgard.ui.DoubleClick {

	// ----o Constructor
	
	private function DoubleClick() {
		//
	} 

	// ----o Static Properties

	static public function get ISDOUBLE():Boolean {
		if (!_dispatcher) initialize() ;
		return __ISDOUBLE__ ;
	}

	// ----o Static Methods

	static public function addListener(listener):Boolean {
		if (!_dispatcher) initialize() ;
		return _dispatcher.addListener(listener) ;
	}
	
	static public function initialize():Void {
		_dispatcher = new FastDispatcher() ;
		Mouse.addListener(DoubleClick) ;
		reset() ;
	}

	static public function release():Void {
		reset() ;
		Mouse.removeListener(DoubleClick) ;
	}

	static public function removeListener(listener):Boolean {
		return _dispatcher.removeListener(listener) ;
	}
	
	static public function removeAllListeners():Void {
		_dispatcher.removeAllListeners() ;
	}

	static public function toString():String {
		return "[DoubleClick]" ;
	}

	// ----o Static Virtual Properties

	static public function get delay():Number{
		return _delay ;
	}
   
	static public function set delay(n:Number):Void {
		_delay = n > 0 ? n : 0 ;
	}
   
	// ----o Static Private Properties
     
	static private var _delay:Number = 250 ;
	static private var _itv:Number ;
	static private var _cpt:Number ;
	static private var _dispatcher:FastDispatcher ;
	static private var __ISDOUBLE__:Boolean = false ;
	
	// ----o Static Private Methods

	static private function onMouseDown():Void{
		_cpt ++ ;
		__ISDOUBLE__ = _cpt == 2 ;
		clearInterval(_itv) ;
		var type:String = (_cpt == 2)  ? MouseEventType.DOUBLE_CLICK : MouseEventType.CLICK ;
		var ev:Event = new MouseEvent(type, DoubleClick) ;
		_dispatcher.dispatch( ev ) ;
		_itv = setInterval( reset , _delay) ;
	}
	
	static private function reset():Void{
		clearInterval(_itv);
		__ISDOUBLE__ = false ;
		_cpt = 0 ;
	}
	
}