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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
	
/**	ButtonEventType

	AUTHOR

		Name : ButtonEventType
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-02-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		- static CLICK:String
		
		- static DISABLED:String
		
		- static DOUBLE_CLICK:String
		
		- static DOWN:String
		
		- static DRAG:String
		
		- static ICON_CHANGE:String
		
		- static LABEL_CHANGE:String
		
		- static MOUSE_UP:String
		
		- static MOUSE_DOWN:String
		
		- static OUT:String
		
		- static OUT_SELECTED:String
		
		- static OVER:String
		
		- static OVER_SELECTED:String
		
		- static ROLLOUT:String
		
		- static ROLLOVER:String
		
		- static SELECT:String
		
		- static UNSELECT:String
		
		- static UP:String
	
**/

import asgard.events.MouseEventType;

class asgard.events.ButtonEventType {

	// ----o Constructor
	
	private function ButtonEventType() {
		//
	}

	// ----o Static Properties

	static public var CLICK:String = MouseEventType.CLICK ;
	
	static public var DISABLED:String = "disabled" ;
	
	static public var DOUBLE_CLICK:String = MouseEventType.DOUBLE_CLICK ;
	
	static public var DOWN:String = "down" ;

	static public var DRAG:String = "drag" ;
	
	static public var ICON_CHANGE:String = "onIconChanged" ;
	
	static public var LABEL_CHANGE:String = "onLabelChanged" ;
	
	static public var MOUSE_UP:String = MouseEventType.MOUSE_UP ;
	
	static public var MOUSE_DOWN:String = MouseEventType.MOUSE_DOWN ;
	
	static public var OUT:String = "out" ;
	
	static public var OUT_SELECTED:String = "outSelected" ;
	
	static public var OVER:String = "over" ;
	
	static public var OVER_SELECTED:String = "overSelected" ;
	
	static public var ROLLOUT:String = MouseEventType.ROLLOUT ;
	
	static public var ROLLOVER:String = MouseEventType.ROLLOVER ;
		
	static public var SELECT:String = "select" ;
	
	static public var UNSELECT:String = "unselect" ;
	
	static public var UP:String = "up" ;

	static private var __ASPF__ = _global.ASSetPropFlags(ButtonEventType, null , 7, 7) ;

}
