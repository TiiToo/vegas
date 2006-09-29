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

/** AbstractButton

	AUTHOR

		Name : AbstractButton
		Package : lunas.display.components.button
		Version : 1.0.0.0
		Date :  2006-02-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY

		- index:Number
		
		- data:Object
		
		- label:String [R/W]
		
		- selected:Boolean [R/W]
		
		- toggle:Boolean [R/W]
			
	METHOD SUMMARY
		
		- getLabel():String
		
		- getSelected():Boolean
		
		- getToggle():Boolean
		
		- setLabel(str:String):Void
		
		- setSelected(b:Boolean, noEvent:Boolean):Void
		
		- setToggle(b:Boolean):Void
		
		- final viewEnabled():Void
		
		- viewLabelChanged():Void
		
			override this method !

	EVENT SUMMARY
	
		ButtonEvent
		
		- CLICK:String
		
		- UP:String
		
		- DISABLED:String
		
		- DOUBLE_CLICK:String
		
		- DOWN:String
		
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

	IMPLEMENTS 
	
		IButton, IEventTarget

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractButton

	SEE ALSO
	
		IBuilder, IButton, IStyle
	
**/

import asgard.events.ButtonEvent;
import asgard.events.ButtonEventType;

import lunas.display.components.AbstractComponent;
import lunas.display.components.IButton;
import lunas.display.group.RadioButtonGroup;

import vegas.events.EventListener;

class lunas.display.components.button.AbstractButton extends AbstractComponent implements IButton {

	// ----o Constructor

	private function AbstractButton () 
	{
		initButtonEvent() ; 
		_rg = RadioButtonGroup.getInstance()  ;
	}

	// ----o Public Properties
	
	//public var label:String ; // [R/W]
	public var data ;
	public var index:Number ;
	//public var selected:Boolean ; // [R/W]
	//public var toggle:Boolean ; // [R/W]
	
	// ----o Public Methods
	
	public function getLabel():String 
	{
		return _label || "" ;
	}
		
	public function getSelected():Boolean 
	{
		return _selected ;
	}
	
	public function getToggle():Boolean 
	{
		return _toggle ;
	}
	
	public function groupPolicyChanged():Void 
	{
		_rg.setGroupName( _groupName, this ) ;
		if (group) 
		{
			_rg.addButton( this ) ;
			addEventListener(ButtonEventType.DOWN, _rg) ;
		}
		else 
		{
			_rg.removeButton( this ) ;
			removeEventListener(ButtonEventType.DOWN, _rg) ;
		}
	}

	public function initButtonEvent():Void 
	{
		_eButton = new ButtonEvent() ;	
	}

	public function setLabel(str:String):Void 
	{
		_label = str ; 
		viewLabelChanged() ;
		_fireButtonEvent(ButtonEventType.LABEL_CHANGE) ;
	}

	public function setSelected (b:Boolean, noEvent:Boolean):Void 
	{
		_selected =  (_toggle)  ? b : null ;
		_fireButtonEvent (_selected ? ButtonEventType.DOWN : ButtonEventType.UP ) ;
		if (!noEvent) 
		{
			_fireButtonEvent (_selected ? ButtonEventType.SELECT : ButtonEventType.UNSELECT) ;
		}
	}
	
	public function setToggle(b:Boolean):Void 
	{
		_toggle = b ;	
		setSelected (false, true) ;
	}

	/*final*/ public function viewEnabled():Void 
	{
		var type:String ;
		if (enabled) 
		{
			type = (toggle && selected) ? ButtonEventType.DOWN : ButtonEventType.UP ;
		}
		else 
		{
			type = ButtonEventType.DISABLED ;
		}
		_fireButtonEvent( type ) ;
	}

	public function viewLabelChanged():Void {
		// override this method when label property change
	}

	// ----o Virtual Properties
	
	public function get label():String 
	{
		return getLabel() ;
	}
	
	public function set label(s:String):Void 
	{
		setLabel(s) ;	
	}
		
	public function get selected():Boolean 
	{
		return getSelected() ;	
	}
	
	public function set selected(b:Boolean):Void 
	{
		setSelected(b);	
	}	
	
	public function get toggle():Boolean 
	{
		return getToggle() ;	
	}
	
	public function set toggle(b:Boolean):Void 
	{
		setToggle(b);	
	}	
	
	// ----o Private Properties
	
	private var _eButton:ButtonEvent ;
	private var _label:String ;
	private var _rgListener:EventListener ;
	private var _toggle:Boolean ;
	private var _rg:RadioButtonGroup ;
	private var _selected:Boolean ;
	
	// ----o Private Methods

	private function _fireButtonEvent( eventType:String ):Void 
	{
		_eButton.setType(eventType) ;
		_eButton.setTarget(this) ;
		dispatchEvent( _eButton ) ;
	}

	private function onPress():Void 
	{
		if (_toggle) 
		{
			setSelected (!_selected);
		}
		else 
		{
			_fireButtonEvent(ButtonEventType.DOWN) ;
		}
		_fireButtonEvent(ButtonEventType.CLICK) ;
		_fireButtonEvent(ButtonEventType.MOUSE_DOWN) ;
	}

	private function onRelease():Void 
	{ 
		if ( !_toggle ) _fireButtonEvent(ButtonEventType.UP) ;
		_fireButtonEvent(ButtonEventType.MOUSE_UP) ;
	}
	
	private var onReleaseOutside:Function = AbstractButton.prototype.onRelease ;
	
	private function onRollOut():Void 
	{
		if ( !_toggle || !_selected ) 
		{
			_fireButtonEvent(ButtonEventType.UP) ;
			_fireButtonEvent(ButtonEventType.OUT) ;
		}
		else if (_selected)
		{
			_fireButtonEvent(ButtonEventType.OUT_SELECTED) ;
		}
		_fireButtonEvent(ButtonEventType.ROLLOUT) ;
	}

	private function onRollOver():Void 
	{
		if ( !_toggle || !_selected ) 
		{
			_fireButtonEvent(ButtonEventType.OVER) ;
		}
		else if (_selected) 
		{
			_fireButtonEvent(ButtonEventType.OVER_SELECTED) ;
		}
		_fireButtonEvent(ButtonEventType.ROLLOVER) ;
	}	
	
}
