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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** Event
 
	AUTHOR
	
		Name : Event
		type : SSAS
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-05-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	PROPERTY SUMMARY
	
		- stop:Number

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
	
	INHERIT
	
		ICloneable
 
**/
 
if (vegas.events.Event == undefined) {
	
	// ----o Constructor
 
	vegas.events.Event = function() {
		//
	}
	
	// ---- INHERIT
 
	vegas.events.Event.extend(vegas.core.CoreObject) ;
 
	// ----o Public Methods
 
 	vegas.events.Event.prototype.cancel = function () /*Void*/ {
		//
	}

	vegas.events.Event.prototype.clone = function () {
		//
	}

 	vegas.events.Event.prototype.getBubbles = function () /*Boolean*/ {
		//
	}

 	vegas.events.Event.prototype.getContext = function () /*Object*/ {
		//
	}

 	vegas.events.Event.prototype.getCurrentTarget = function () /*Object*/ {
		//
	}

 	vegas.events.Event.prototype.getEventPhase = function () /*Number*/ {
		//
	}

 	vegas.events.Event.prototype.getTarget = function () /*Object*/ {
		//
	}

 	vegas.events.Event.prototype.getTimeStamp = function () /*Number*/ {
		//
	}
	
 	vegas.events.Event.prototype.getType = function () /*String*/ {
		//
	}
	
	vegas.events.Event.prototype.initEvent = function (type /*String*/ , bubbles /*Boolean*/, cancelable /*Boolean*/ ) /*Void*/ {
		//
	}

	vegas.events.Event.prototype.isCancelled = function() /*Boolean*/ {
		//		
	}
	
	vegas.events.Event.prototype.isQueued = function() /*Boolean*/ {
		//
	}

	vegas.events.Event.prototype.queueEvent = function() /*Void*/ {
		//
	}

 	vegas.events.Event.prototype.setBubbles = function ( b /*Boolean*/ ) /*Void*/ {
		//
	}

 	vegas.events.Event.prototype.setContext = function ( context /*Object*/ ) /*Void*/ {
		//
	}

 	vegas.events.Event.prototype.setCurrentTarget = function ( target /*Object*/ ) /*Void*/ {
		//
	}

 	vegas.events.Event.prototype.setEventPhase = function ( n /*Number*/ ) /*Void*/ {
		//
	}

 	vegas.events.Event.prototype.setTarget = function ( target /*Object*/ ) /*Void*/ {
		//
	}

 	vegas.events.Event.prototype.setType = function ( type /*String*/ ) /*Void*/ {
		//
	}

 	vegas.events.Event.prototype.stopPropagation = function () /*Void*/ {
		//
	}
	
	vegas.events.Event.prototype.stopImmediatePropagation = function () /*Void*/ {
		//
	}

	// ----o Encapsulate

	// trace ("***** running vegas.events.Event") ;

}