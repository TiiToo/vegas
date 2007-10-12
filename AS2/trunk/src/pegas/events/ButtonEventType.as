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

import pegas.events.MouseEventType;

class pegas.events.ButtonEventType 
{

	public static var CLICK:String = MouseEventType.CLICK ;
	
	public static var DISABLED:String = "disabled" ;
	
	public static var DOUBLE_CLICK:String = MouseEventType.DOUBLE_CLICK ;
	
	public static var DOWN:String = "down" ;

	public static var DRAG:String = "drag" ;
	
	public static var ICON_CHANGE:String = "onIconChanged" ;
	
	public static var LABEL_CHANGE:String = "onLabelChanged" ;
	
	public static var MOUSE_UP:String = MouseEventType.MOUSE_UP ;
	
	public static var MOUSE_DOWN:String = MouseEventType.MOUSE_DOWN ;
	
	public static var OUT:String = "out" ;
	
	public static var OUT_SELECTED:String = "outSelected" ;
	
	public static var OVER:String = "over" ;
	
	public static var OVER_SELECTED:String = "overSelected" ;
	
	public static var ROLLOUT:String = MouseEventType.ROLLOUT ;
	
	public static var ROLLOVER:String = MouseEventType.ROLLOVER ;
		
	public static var SELECT:String = "select" ;
	
	public static var START_DRAG:String = "startDrag" ;
	
	public static var STOP_DRAG:String = "stopDrag" ;
	
	public static var UNSELECT:String = "unselect" ;
	
	public static var UP:String = "up" ;

	private static var __ASPF__ = _global.ASSetPropFlags(ButtonEventType, null , 7, 7) ;

}
