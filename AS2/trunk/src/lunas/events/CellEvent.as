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

/*

	AUTHOR

		Name : CellEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-04-03
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	CONSTRUCTOR
	
		new CellEvent(e:EventType, target) ;

	PROPERTY SUMMARY

		- altKey:Boolean (default = false)
		
			Reserved for future use (not currently functional).
		
		- buttonDown:Boolean (default = false)
		
			Indicates whether the left mouse button is depressed.
		
		- ctrlKey:Boolean (default = false)
		
			Indicates whether the control(Ctrl) key modifier is activated.
		
		- delta:Number (default = 0)
		
			A number indicating how many lines should be scrolled for each notch the user rolls the mouse wheel.
			A positive delta value indicates an upward scroll.
			A negative value indicates a downward scroll. 
			Typical values are 1 to 3, but faster scrolling may produce larger values.
			This parameter is used only for the MouseEventType.mouseWheel event.
		
		- localX:Number (default = 0) 
		
			The horizontal coordinate at which the event occurred relative to the containing sprite.
		
		- localY:Number (default = 0) 
		
			The vertical coordinate at which the event occurred relative to the containing sprite.
		
		- relatedObject:InteractiveObject (default = null) 
		
			Indicates the complementary InteractiveObject instance that is affected by the event.
			For example, when a mouseOut event occurs, the relatedObject represents the display list object to which the pointing device now points.
		
		- shiftKey:Boolean (default = false)
		
			Indicates whether the Shift(Shift) key modifier is activated.

	METHOD SUMMARY
	
		- getIndex():Number
	
		- getCellIndex():CellIndex
	
		- getTarget():Object
		
		- getType():String
		
		- setTarget(target:Object):Void
		
		- setType(type:String):Void
		
		- toString():String

	INHERIT
	
		CoreObject
			|
			BasicEvent
				|
		 		DynamicEvent
			 		|
		 			MouseEvent
						|
						ButtonEvent
		
	IMPLEMENTS
	
		IEvent

*/

import asgard.events.ButtonEvent;

import lunas.display.components.cell.CellIndex;
import lunas.display.components.ICell;

class lunas.events.CellEvent extends ButtonEvent 
{

	// ----o Constructor
	
	public function CellEvent(type:String, target:ICell) 
	{
		super(type, target) ;
		_cell = target ;
	}

	// ----o Public Methods

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
	
	public function getCell():ICell 
	{
		return _cell ;	
	}
	
	public function getCellIndex():CellIndex 
	{
		return _cell.getCellIndex() ;	
	}
	
	// ----o Private Properties
	
	private var _cell:ICell ;
}
