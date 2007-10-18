/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
	
import pegas.events.ButtonEventType;

/**
 * The static enumeration list of all cell event's name.
 */
class lunas.events.CellEventType 
{

	public static var CLICK:String = ButtonEventType.CLICK ;
	
	public static var DISABLED:String = ButtonEventType.DISABLED ;
	
	public static var DOUBLE_CLICK:String = ButtonEventType.DOUBLE_CLICK ;
	
	public static var DOWN:String = ButtonEventType.DOWN ;

	public static var DRAG:String = ButtonEventType.DRAG ;
	
	public static var ICON_CHANGE:String = ButtonEventType.ICON_CHANGE ;
	
	public static var LABEL_CHANGE:String = ButtonEventType.LABEL_CHANGE ;
	
	public static var MOUSE_UP:String = ButtonEventType.MOUSE_UP ;
	
	public static var MOUSE_DOWN:String = ButtonEventType.MOUSE_DOWN ;
	
	public static var OUT:String = ButtonEventType.OUT ;
	
	public static var OUT_SELECTED:String = ButtonEventType.OUT_SELECTED ;
	
	public static var OVER:String = ButtonEventType.OVER ;
	
	public static var OVER_SELECTED:String = ButtonEventType.OVER_SELECTED ;
	
	public static var ROLLOUT:String = ButtonEventType.ROLLOUT ;
	
	public static var ROLLOVER:String = ButtonEventType.ROLLOVER ;
		
	public static var SELECT:String = ButtonEventType.SELECT ;
	
	public static var UNSELECT:String = ButtonEventType.UNSELECT ;
	
	public static var UP:String = "up" ;

}
