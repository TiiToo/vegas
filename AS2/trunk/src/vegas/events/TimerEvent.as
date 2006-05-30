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

/**	TimerEvent

	AUTHOR

		Name : TimerEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	CONSTRUCTOR
	
		new TimerEvent(type:String, target) ;

	PROPERTY SUMMARY
	
		- bubbles:Boolean [R/W]
		
		- context [R/W]
		
		- currentTarget [R/W]
		
		- eventPhase:Number [R/W]
		
		- target[R/W]
		
		- text:String
		
		- type:String [R/W]

	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext():Object
		
		- getCurrentTarget():Object
		
		- getEventPhase():Number
		
		- getTarget():Object
		
		- getTimeStamp():Number
		
		- getType():String
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context:Object):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setTarget(target:Object):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation()
		
		- toString():String

	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → TimerEvent
		
	IMPLEMENTS
	
		Event, ICloneable, IFormattable, IHashable

**/

import vegas.events.DynamicEvent;

class vegas.events.TimerEvent extends DynamicEvent {

	// ----o Constructor
	
	public function TimerEvent(type:String, target) {
		super(type, target) ;
	}

	// ----o Public Methods

	public function clone() {
		return new TimerEvent(_type, _target) ;
	}
	
}
