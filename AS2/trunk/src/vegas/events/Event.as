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

/**	Event [interface]

	AUTHOR
	
		Name : Event
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-13
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

import vegas.core.ICloneable;

interface vegas.events.Event extends ICloneable {

	function cancel():Void ;
		
	function getBubbles():Boolean ;
		
	function getContext() ;
		
	function getCurrentTarget() ;
		
	function getEventPhase():Number ;
		
	function getTarget() ;
	
	function getTimeStamp():Number ;
	
	function getType():String ;
	
	function initEvent(type:String, bubbles:Boolean, cancelable:Boolean):Void ;
	
	function isCancelled():Boolean ;

	function isQueued():Boolean ;
	
	function queueEvent():Void ;
	
	function setBubbles(b:Boolean):Void ;
	
	function setContext(context):Void ;
	
	function setCurrentTarget(target):Void ;
	
	function setEventPhase(n:Number):Void ;
	
	function setTarget(target):Void ;
	
	function setType(type:String):Void ;
	
	function stopPropagation():Void ;
	
	function stopImmediatePropagation():Void ;
	
	function toString():String ;
	
}