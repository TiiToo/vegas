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

/** EventTarget [interface]

	AUTHOR
	
		Name : EventTarget
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-01-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addEventListener(eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void
		
		- dispatchEvent( event , [isQueue, [target, [context]]]):Event
		
		- removeEventListener(eventName:String, listener, useCapture:Boolean ):EventListener

	SEE ALSO :
	
		Document Object Model (DOM) Level 2 Events Specification
			- http://www.w3.org/TR/2000/REC-DOM-Level-2-Events-20001113/
	
**/

import vegas.events.Event;
import vegas.events.EventListener;

interface vegas.events.EventTarget {
	
	function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void ;

	function dispatchEvent(event, isQueue:Boolean, target, context):Event ;

	function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener ;
	
}