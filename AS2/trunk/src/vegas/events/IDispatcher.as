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

/** IDispatcher [interface]

	AUTHOR
	
		Name : IDispatcher
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-12-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	METHOD SUMMARY

		- addEventListener(eventName:String, obj, func):Void 
		
		- dispatchEvent(ev):Void
		
		- eventListenerExists(eventName:String, obj , func):Boolean
		
		- removeAllEventListeners(eventName:String):Void
		
		- removeEventListener(eventName:String, obj, func):Void
		
		- updateEvent(eventName:String, oInit):Void

**/

interface vegas.events.IDispatcher {
	
	function addEventListener(eventName:String, obj, func):Void ;

	function dispatchEvent(ev):Void ;

	function eventListenerExists(eventName:String, obj , func):Boolean ;

	function removeAllEventListeners(eventName:String):Void ;
	
	function removeEventListener(eventName:String, obj, func):Void ;
	
	function updateEvent(eventName:String, oInit):Void ;
	
}