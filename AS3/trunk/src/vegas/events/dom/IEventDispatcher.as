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

/* IEventDispatcher [Interface]

	AUTHOR
	
		Name : IEventDispatcher
		Package : vegas.events.dom
		Version : 1.0.0.0
		Date :  2006-07-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addEventListener(eventName:String, listener:EventListener, useCapture:Boolean, priority:uint, autoRemove:Boolean):void
		
		- addGlobalEventListener(listener:EventListener, priority:uint, autoRemove:Boolean):void
		
		- dispatchEvent( event:* , [isQueue:Boolean, [target:*, [context:*]]]):IEvent
		
		- getEventListeners(eventName:String) : EventListenerCollection
		
		- getGlobalEventListeners():EventListenerCollection
		
		- getRegisteredEventNames():Set
			
		- hasEventListener(eventName:String):Boolean
		
		- removeEventListener(eventName:String, listener, useCapture:Boolean ):EventListener
		
		- removeGlobalEventListener(listener:*):EventListener

	INHERIT
	
		EventTarget → IEventDispatcher

*/

package vegas.events.dom
{
	
	import vegas.data.Set;
	
	public interface IEventDispatcher extends EventTarget
	{
	
		function addGlobalEventListener(listener:EventListener, priority:uint, autoRemove:Boolean):void ;
	
		function getEventListeners(eventName:String):EventListenerCollection ;

		function getGlobalEventListeners():EventListenerCollection ;
	
		function getRegisteredEventNames():Set ;
	
		function hasEventListener(eventName:String):Boolean ;
	
		function removeGlobalEventListener( listener:* ):EventListener ;
	
	}
}