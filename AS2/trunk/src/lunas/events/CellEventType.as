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
	
/**	CellEventType

	AUTHOR

		Name : CellEventType
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-02-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		- CLICK:String
		
		- DISABLED:String
		
		- DOUBLE_CLICK:String
		
		- DOWN:String
		
		- DRAG:String
		
		- ICON_CHANGE:String
		
		- LABEL_CHANGE:String
		
		- MOUSE_UP:String
		
		- MOUSE_DOWN:String
		
		- OUT:String
		
		- OUT_SELECTED:String
		
		- OVER:String
		
		- OVER_SELECTED:String
		
		- ROLLOUT:String
		
		- ROLLOVER:String
		
		- SELECT:String
		
		- UNSELECT:String
		
		- UP:String
	
	
----------  */

import asgard.events.ButtonEventType;

class lunas.events.CellEventType {

	// ----o Constructor
	
	private function CellEventType() {
		//
	}

	// ----o Static Properties

	static public var CLICK:String = ButtonEventType.CLICK ;
	
	static public var DISABLED:String = ButtonEventType.DISABLED ;
	
	static public var DOUBLE_CLICK:String = ButtonEventType.DOUBLE_CLICK ;
	
	static public var DOWN:String = ButtonEventType.DOWN ;

	static public var DRAG:String = ButtonEventType.DRAG ;
	
	static public var ICON_CHANGE:String = ButtonEventType.ICON_CHANGE ;
	
	static public var LABEL_CHANGE:String = ButtonEventType.LABEL_CHANGE ;
	
	static public var MOUSE_UP:String = ButtonEventType.MOUSE_UP ;
	
	static public var MOUSE_DOWN:String = ButtonEventType.MOUSE_DOWN ;
	
	static public var OUT:String = ButtonEventType.OUT ; ;
	
	static public var OUT_SELECTED:String = ButtonEventType.OUT_SELECTED ; ;
	
	static public var OVER:String = ButtonEventType.OVER ; ;
	
	static public var OVER_SELECTED:String = ButtonEventType.OVER_SELECTED ; ;
	
	static public var ROLLOUT:String = ButtonEventType.ROLLOUT ;
	
	static public var ROLLOVER:String = ButtonEventType.ROLLOVER ;
		
	static public var SELECT:String = ButtonEventType.SELECT ;
	
	static public var UNSELECT:String = ButtonEventType.UNSELECT ;
	
	static public var UP:String = "up" ;

	static private var __ASPF__ = _global.ASSetPropFlags(CellEventType, null , 7, 7) ;

}
