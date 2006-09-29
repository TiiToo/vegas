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

/** Keyboard

	AUTHOR

		Name : Keyboard
		Package : asgard.ui
		Version : 1.0.0.0
		Date :  2005-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION

		AS3 compatability
	
	CONSTANT SUMMARY
	
		- BACKSPACE:Number
			Constant associated with the key code value for the Backspace key (8).
		
		- CAPS_LOCK:Number
			Constant associated with the key code value for the Caps Lock key (20).
		
		- CONTROL:Number
			Constant associated with the key code value for the Control key (17).
		
		- DELETE:Number
			Constant associated with the key code value for the Delete key (46).
		
		- DOWN:Number
			Constant associated with the key code value for the Down Arrow key (40).
		
		- END:Number
			Constant associated with the key code value for the End key (35).
		
		- ENTER:Number
			Constant associated with the key code value for the Enter key (13).
		
		- ESCAPE:Number
			Constant associated with the key code value for the Escape key (27).
		
		- F1:Number
		
		- F10:Number
		
		- F11:Number
		
		- F12:Number
		
		- F13:Number
		
		- F14:Number
		
		- F15:Number
		
		- F2:Number
		
		- F3:Number
		
		- F4:Number
		
		- F5:Number
		
		- F6:Number
		
		- F7:Number
		
		- F8:Number
		
		- F9:Number
		
		- HOME:Number
			Constant associated with the key code value for the Home key (36).
		
		- INSERT:Number
			Constant associated with the key code value for the Insert key (45).
		
		- LEFT:Number
			Constant associated with the key code value for the Left Arrow key (37).
		
		- NUMPAD_0:Number
		
		- NUMPAD_1:Number
		
		- NUMPAD_2:Number
		
		- NUMPAD_3:Number
		
		- NUMPAD_4:Number
		
		- NUMPAD_5:Number
		
		- NUMPAD_6:Number
		
		- NUMPAD_7:Number
		
		- NUMPAD_8:Number
		
		- NUMPAD_9:Number
		
		- NUMPAD_ADD:Number
		
		- NUMPAD_DECIMAL:Number
		
		- NUMPAD_DIVIDE:Number
		
		- NUMPAD_ENTER:Number
		
		- NUMPAD_MULTIPLY:Number
		
		- NUMPAD_SUBTRACT:Number
		
		- PAGE_DOWN:Number
			Constant associated with the key code value for the Page Down key (34).
		
		- PAGE_UP:Number
			Constant associated with the key code value for the Page Up key (33).
		
		- RIGHT:Number
			Constant associated with the key code value for the Right Arrow key (39).
		
		- SHIFT:Number
			Constant associated with the key code value for the Shift key (16).
		
		- SPACE:Number
			Constant associated with the key code value for the Spacebar (32).
		
		- TAB:Number
			Constant associated with the key code value for the Tab key (9).
		
		- UP:Number
			Constant associated with the key code value for the Up Arrow key (38).
	
	METHOD SUMMARY
	
		- static getCharCode(s:String):Number
	
	
	TODO capsLock:Boolean [read-only] Indicates if the Caps Lock key is activated (true) or not (false).
	
	TODO numLock:Boolean [read-only] Indicates if the Num Lock key is activated (true) or not (false).
	
----------  */

import vegas.core.types.Char;

class asgard.ui.Keyboard {

	// ----o Constructor
	
	private function Keysboard() {
		//
	}

	// ----o Constants

	static public var BACKSPACE:Number = Key.BACKSPACE ;
	static public var CAPS_LOCK:Number = Key.CAPSLOCK ;
	static public var CONTROL:Number = Key.CONTROL ;
	static public var DELETE:Number = Key.DELETEKEY ;
	static public var DOWN:Number = Key.DOWN ;
	static public var END:Number = Key.END ;
	static public var ENTER:Number = Key.ENTER ;
	static public var ESCAPE:Number = Key.ESCAPE ;
	static public var F1:Number = 112 ;
	static public var F2:Number = 113 ;
	static public var F3:Number = 114 ;
	static public var F4:Number = 115 ;
	static public var F5:Number = 116 ;
	static public var F6:Number = 117 ;
	static public var F7:Number = 118 ;
	static public var F8:Number = 119 ;
	static public var F9:Number = 120 ;
	static public var F10:Number = 121 ;
	static public var F11:Number = 122 ;
	static public var F12:Number = 123 ;
	static public var HOME:Number = Key.HOME ;
	static public var INSERT:Number = Key.INSERT ;
	static public var LEFT:Number = Key.LEFT ;
	static public var NUMPAD_0:Number = 96 ;
	static public var NUMPAD_1:Number = 97 ;
	static public var NUMPAD_2:Number = 98 ;
	static public var NUMPAD_3:Number = 99 ;
	static public var NUMPAD_4:Number = 100 ;
	static public var NUMPAD_5:Number = 101 ;
	static public var NUMPAD_6:Number = 102 ;
	static public var NUMPAD_7:Number = 103 ;
	static public var NUMPAD_8:Number = 104 ;
	static public var NUMPAD_9:Number = 105 ;
	static public var NUMPAD_ADD:Number = 107 ;
	static public var NUMPAD_DECIMAL:Number = 110 ; 
	static public var NUMPAD_DIVIDE:Number = 111 ;
	static public var NUMPAD_ENTER:Number = 13 ;
	static public var NUMPAD_MULTIPLY:Number = 106 ;
	static public var NUMPAD_SUBTRACT:Number = 109 ; 
	static public var PAGE_DOWN:Number = Key.PGDN ;
	static public var PAGE_UP:Number = Key.PGUP ;
	static public var RIGHT:Number = Key.RIGHT ;
	static public var SHIFT:Number = Key.SHIFT ;
	static public var SPACE:Number = Key.SPACE ;
	static public var TAB:Number = Key.TAB ;
	static public var UP:Number = Key.UP ;

	static private var __ASPF__ = _global.ASSetPropFlags(Keyboard, null , 7, 7) ;

	// ----o Static Methods

	static public function getCharCode(char:String):Number 
	{
		return (new Char(char)).getCode() ;
	}

	
}