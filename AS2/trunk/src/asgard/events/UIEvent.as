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

/** UIEvent

	AUTHOR

		Name : UIEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-02-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new UIEvent(type:String, target, context) ;

	PROPERTY SUMMARY

		- bubbles:Boolean [R/W]
		
		- child
				
		- context [R/W]
		
		- currentTarget [R/W]
		
		- eventPhase:Number [R/W]

		- index:Number
				
		- target [R/W]
		
		- type:String [R/W]
	
	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext()
		
		- getCurrentTarget()
		
		- getEventPhase():Number
		
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		- hashCode():Number
		
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
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String
		
	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → UIEvent
		
	IMPLEMENTS
	
		Event, ICloneable, IFormattable, IHashable
	
	SEE ALSO 
	
		UIEventType
	
**/

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

class asgard.events.UIEvent extends DynamicEvent {

	// ----o Constructor
	
	public function UIEvent( type:String, target, p_child, p_index:Number, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) {
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		child = p_child || null ;
		index = isNaN(p_index) ? null : p_index ;
	}

	// ----o Public Properties
	
	public var child ;
	public var index:Number ;

	// ----o Public Methods
	
	public function clone() {
		return new UIEvent(getType(), getTarget()) ;
	}
	
	// ----o Protected Methods
	
	/*protected*/ private function _getParams():Array {
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(child)) ;
		ar.splice(3, null, Serializer.toSource(index)) ;
		return ar ;
	}
	
}
