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

/** AbstractTextInput

	AUTHOR

		Name : AbstractTextInput
		Package : lunas.display.components.text
		Version : 1.0.0.0
		Date :  2006-02-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	PROPERTY SUMMARY

		- autoSize:Boolean

		- editable:Boolean [R/W]

		- field:TextField

		- hPosition:Number

		- label:String [R/W]

		- length:Number [Read Only]

		- maxChars:Number [R/W]

		- maxHPosition:Number [Read Only]

		- maxVPosition:Number [Read Only]

		- multiline:Boolean [R/W]

		- password:Boolean [R/W]

		- priority:Boolean [R/W]

		- restrict:String [R/W]

		- vPosition:Number

	METHOD SUMMARY
		
		- getAutoSize():Boolean

		- getEditable():Boolean

		- getHTML():Boolean

		- getHPosition():Number

		- getHScrollPolicy():Number

		- getInputField():TextField

		- getLabel():String

		- getLength():Number

		- getMaxHPosition():Number

		- getMaxVPosition():Number 

		- getMultiline():Boolean

		- getText():String

		- getVPosition():Number

		- getVScrollPolicy():Number

		- setHTML(b:Boolean):Void

		- setAutoSize(b:Boolean):Void

		- setEditable(b:Boolean):Void

		- setHPosition(n:Number)

		- setHScrollPolicy(n:Number)

		- setLabel(str:String):Void

		- setMultiline(b:Boolean):Void

		- setText(str:String):Void

		- setVPosition(n:Number)

		- setVScrollPolicy(n:Number)

		- viewLabelChanged():Void (override this method)

	IMPLEMENTS 
	
		ILabel, IEventTarget

	EVENT SUMMARY

		UIEvent

	EVENT TYPE SUMMARY

		- UIEventType.CHANGE

		- UIEventType.LABEL_CHANGE

		- UIEventType.SCROLL

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractLabel -> AbstractTextInput

	IMPLEMENTS
	
		ILabel

	SEE ALSO
	
		IBuilder, IStyle

**/

import asgard.events.FocusEvent;

import lunas.display.components.text.AbstractTextArea;
import lunas.display.group.TextInputGroup;

import vegas.events.Delegate;

class lunas.display.components.text.AbstractTextInput extends AbstractTextArea {

	// ----o Constructor

	private function AbstractTextInput() { 
		super() ;
		
		_eFocusIn = new FocusEvent(FocusEvent.FOCUS_IN, this) ;
		_eFocusOut = new FocusEvent(FocusEvent.FOCUS_OUT, this) ;
		
		field.onKillFocus = Delegate.create(this, notifyFocusOut) ;
		field.onSetFocus = Delegate.create(this, notifyFocusIn) ;
	}

	// ----o Public Methods
	
	public function getInputField():TextField {
		return field ;
	}	
	
	public function getMaxChars():Number { 
		return field.maxChars ; 
	}
	
	public function getPassword():Boolean { 
		return field.password ; 
	}
	
	public function getPriority(Void):Boolean { 
		return _priority ; 
	}

	public function getRestrict(Void):String { 
		return field.restrict ;
	}
	
	/*override*/ public function groupPolicyChanged():Void {
		TextInputGroup.getInstance().setGroupName( getGroupName(), this) ;
	}

	public function notifyFocusIn( oldFocus ):Void {
		_eFocusIn.relatedObject = oldFocus ;
		dispatchEvent(_eFocusIn) ;
	}

	public function notifyFocusOut( newFocus ):Void {
		_eFocusIn.relatedObject = newFocus ;
		dispatchEvent(_eFocusOut) ;
	}

	public function setMaxChars(n:Number):Void { 
		field.maxChars = n ; 
	}
	
	public function setPassword(b:Boolean):Void { 
		field.password = b ; 
	}
	
	public function setPriority(bool:Boolean):Void { 
		_priority = bool ;
		update() ;
	}

	public function setRestrict(s:String):Void { 
		field.restrict = s ;
	}
	
	// ----o Virtual Properties

	public function get maxChars():Number { 
		return getMaxChars() ; 
	}
	
	public function set maxChars(n:Number):Void { 
		setMaxChars(n); 
	}

	public function get password():Boolean { 
		return getPassword(); 
	}
	
	public function set password(b:Boolean):Void { 
		setPassword(b); 
	}

	public function get priority():Boolean { 
		return getPriority(); 
	}
	
	public function set priority(bool:Boolean):Void { 
		setPriority(bool); 
	}
	
	public function get restrict():String { 
		return getRestrict(); 
	}
	
	public function set restrict(s:String):Void { 
		setRestrict(s); 
	}

	// ----o Private Properties
	
	private var _eFocusIn:FocusEvent ;
	private var _eFocusOut:FocusEvent ;
	private var _priority:Boolean = false ;
	
}

