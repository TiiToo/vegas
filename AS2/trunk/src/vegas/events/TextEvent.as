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

/**	TextEvent

	AUTHOR
		
		Name : TextEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var ev:Event = new TextEvent(type:String, txt:String, target, context) ;

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
		
		- toSource(indent : Number, indentor : String) : String
		
		- toString():String

	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → TextEvent

	IMPLEMENTS 
		
		Event, ICloneable, IFormattable, IHashable, ISerializable
	
**/

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

class vegas.events.TextEvent extends DynamicEvent {

	// ----o Constructor
	
	public function TextEvent(type:String, txt:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number){
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		text = txt ;
	}

	// ----o Public Properties
	
	public var text:String ;

	// ----o Public Methods

	public function clone() {
		return new TextEvent(getType(), text, getTarget(), getContext()) ;
	}

	// ----o Protected Methods
	
	/*protected*/ private function _getParams():Array {
		var ar:Array = super._getParams() ;
		ar.splice(1, null, Serializer.toSource(text)) ;
		return ar ;
	}


}
