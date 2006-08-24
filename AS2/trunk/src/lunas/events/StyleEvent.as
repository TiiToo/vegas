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

/** StyleEvent

	AUTHOR
	
		Name : StyleEvent
		Package : lunas.events
		Version : 1.0.0.0
		Date :  2006-02-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext()
		
		- getCurrentTarget()
		
		- getEventPhase():Number
		
		+ getStyle():IStyle
		
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		- initEvent(type:String, bubbles:Boolean, cancelable:Boolean)
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setTarget(target):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation():Void
		
		- toString():String

	TODO : finir la documentation 

----------------*/

import lunas.display.components.IStyle;

import vegas.events.BasicEvent;

class lunas.events.StyleEvent extends BasicEvent {

	// ----o Constructor 
	
	public function StyleEvent(type:String, style:IStyle) {
		super(type) ;
		_style = style ;
	}
	
	// ----o Public Methods
	
	public function clone() {
		return new StyleEvent(getType(), getStyle()) ;
	}
	
	public function getStyle():IStyle {
		return _style ;
	}
	
	public function toString():String {
		return '[StyleEvent : ' + getType() + ', ' + getStyle() + ']';

	}
	
	// ----o Private Properties
	
	private var _style:IStyle ;
	
}