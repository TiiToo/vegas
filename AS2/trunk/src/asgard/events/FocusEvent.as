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

/**	FocusEvent

	AUTHOR

		Name : FocusEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-05-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	EVENT SUMMARY

		- FOCUS_IN:String = "focusIn"
			[static] Dispatched after a display object gains focus.
	
 	 	- FOCUS_OUT:String = "focusOut"
			[static] Dispatched after a display object loses focus.
		
		- KEY_FOCUS_CHANGE:String = "keyFocusChange"
			[static] Dispatched when the user attempts to change focus using keyboard navigation.
	
 	 	- MOUSE_FOCUS_CHANGE:String = "mouseFocusChange"
			[static] Dispatched when the user attempts to change focus by using a pointer device.

	PROPERTY SUMMARY
	
		- keyCode:Number
			The key code value of the key pressed to trigger a keyFocusChange event.
	
		- relatedObject
			A reference to the complementary InteractiveObject instance that is affected by the change in focus.
	
 	 	- shiftKey:Boolean
			Indicates whether the Shift key modifier is activated, in which case the value is true.

	METHOD SUMMARY
	
		- clone():FocusEvent

	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → FocusEvent

	IMPLEMENTS
	
		Event, ICloneable, IFormattable, IHashable, ISerializable

**/

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

class asgard.events.FocusEvent extends DynamicEvent {

	// ----o Constructor
	
	public function FocusEvent( type:String, target, p_keyCode:Number, p_relatedObject, p_shiftKey:Boolean, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number ){
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		keyCode = isNaN(p_keyCode) ? null : p_keyCode ;
		relatedObject = p_relatedObject || null  ;
		shiftKey = p_shiftKey || null  ;
	}

	// ----o Constants

	static public var FOCUS_IN:String = "focusIn" ;
	
	static public var FOCUS_OUT:String = "focusOut" ;

	static public var KEY_FOCUS_CHANGE:String = "keyFocusChange" ;
	
	static public var MOUSE_FOCUS_CHANGE:String = "MouseFocusChange" ;

	static private var __ASPF__ = _global.ASSetPropFlags(FocusEvent, null , 7, 7) ;

	// ----o Public Properties

	public var keyCode:Number = null ;
	
	public var relatedObject = null ;
	
	public var shiftKey:Boolean = null ;
		
	// ----o Public Methods
	
	public function clone() {
		return new FocusEvent(getType(), getTarget()) ;
	}

	// ----o Protected Methods

	/*protected*/ private function _getParams():Array {
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(keyCode)) ;
		ar.splice(3, null, Serializer.toSource(relatedObject)) ;
		ar.splice(4, null, Serializer.toSource(shiftKey)) ;
		return ar ;
	}

}
