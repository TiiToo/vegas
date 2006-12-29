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

import vegas.core.types.Char;

class pegas.ui.Keyboard 
{

	/**
	 * Constant associated with the key code value for the Backspace key (8).
	 */
	static public var BACKSPACE:Number = Key.BACKSPACE ;
	
	/**
	 * Constant associated with the key code value for the Caps Lock key (20).
	 */
	static public var CAPS_LOCK:Number = Key.CAPSLOCK ;
	
	/**
	 * Constant associated with the key code value for the Control key (17).
	 */
	static public var CONTROL:Number = Key.CONTROL ;
	
	/**
	 * Constant associated with the key code value for the Delete key (46).
	 */
	static public var DELETE:Number = Key.DELETEKEY ;
	
	/**
	 * Constant associated with the key code value for the Down Arrow key (40).
	 */
	static public var DOWN:Number = Key.DOWN ;
	
	/**
	 * Constant associated with the key code value for the End key (35).
	 */
	static public var END:Number = Key.END ;
	
	/**
	 * Constant associated with the key code value for the Enter key (13).
	 */
	static public var ENTER:Number = Key.ENTER ;
	
	/**
	 * Constant associated with the key code value for the Escape key (27).
	 */
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
	
	/**
	 * Constant associated with the key code value for the Home key (36).
	 */
	static public var HOME:Number = Key.HOME ;
	
	/**
	 * Constant associated with the key code value for the Insert key (45).
	 */
	static public var INSERT:Number = Key.INSERT ;
	
	/**
	 * Constant associated with the key code value for the Left Arrow key (37).
	 */
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
	
	/**
	 * Constant associated with the key code value for the Page Down key (34).
	 */
	static public var PAGE_DOWN:Number = Key.PGDN ;
	
	/**
	 * Constant associated with the key code value for the Page Up key (33).
	 */
	static public var PAGE_UP:Number = Key.PGUP ;
	
	/**
	 * Constant associated with the key code value for the Right Arrow key (39).
	 */
	static public var RIGHT:Number = Key.RIGHT ;
	
	/**
	 * Constant associated with the key code value for the Shift key (16).
	 */
	static public var SHIFT:Number = Key.SHIFT ;
	
	/**
	 * Constant associated with the key code value for the Spacebar (32).
	 */
	static public var SPACE:Number = Key.SPACE ;
	
	/**
	 * Constant associated with the key code value for the Tab key (9).
	 */
	static public var TAB:Number = Key.TAB ;
	
	/**
	 * Constant associated with the key code value for the Up Arrow key (38).
	 */
	static public var UP:Number = Key.UP ;

	static private var __ASPF__ = _global.ASSetPropFlags(Keyboard, null , 7, 7) ;

	static public function getCharCode(char:String):Number 
	{
		return (new Char(char)).getCode() ;
	}

	
}