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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import lunas.display.components.cell.CellIndex;
import lunas.display.components.ICell;

import pegas.events.ButtonEvent;

class lunas.events.CellEvent extends ButtonEvent 
{

	/**
	 * Creates a new CellEvent instance.
	 */
	public function CellEvent(type:String, target:ICell) 
	{
		super(type, target) ;
		_cell = target ;
	}

	public static var CLICK:String = ButtonEvent.CLICK ;
	
	public static var DISABLED:String = ButtonEvent.DISABLED ;
	
	public static var DOUBLE_CLICK:String = ButtonEvent.DOUBLE_CLICK ;
	
	public static var DOWN:String = ButtonEvent.DOWN ;

	public static var DRAG:String = ButtonEvent.DRAG ;
	
	public static var ICON_CHANGE:String = ButtonEvent.ICON_CHANGE ;
	
	public static var LABEL_CHANGE:String = ButtonEvent.LABEL_CHANGE ;
	
	public static var MOUSE_UP:String = ButtonEvent.MOUSE_UP ;
	
	public static var MOUSE_DOWN:String = ButtonEvent.MOUSE_DOWN ;
	
	public static var OUT:String = ButtonEvent.OUT ;
	
	public static var OUT_SELECTED:String = ButtonEvent.OUT_SELECTED ;
	
	public static var OVER:String = ButtonEvent.OVER ;
	
	public static var OVER_SELECTED:String = ButtonEvent.OVER_SELECTED ;
	
	public static var ROLLOUT:String = ButtonEvent.ROLLOUT ;
	
	public static var ROLLOVER:String = ButtonEvent.ROLLOVER ;
		
	public static var SELECT:String = ButtonEvent.SELECT ;
	
	public static var UNSELECT:String = ButtonEvent.UNSELECT ;
	
	public static var UP:String = "up" ;

	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	public function clone() 
	{
		var prop:String ;
		var props:Array = ["localX", "localY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "buttonDown", "delta"] ;
		var be:CellEvent = new CellEvent(getType(), getCell()) ;
		var l:Number = props.length ;
		while(--l > -1) {
			prop = props[l] ;
			be[prop] = this[prop] ;
		}
		return be ;
	}
	
	/**
	 * Returns the {@code ICell} reference of this event.
	 * @return the {@code ICell} reference of this event.
	 */
	public function getCell():ICell 
	{
		return _cell ;	
	}
	
	/**
	 * Returns the {@code CellIndex} value of this event.
	 * @return the {@code CellIndex} value of this event.
	 */	
	public function getCellIndex():CellIndex 
	{
		return _cell.getCellIndex() ;	
	}

	private var _cell:ICell ;
}
