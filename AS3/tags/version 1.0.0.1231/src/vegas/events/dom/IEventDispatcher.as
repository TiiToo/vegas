﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events.dom
{
	import vegas.data.Set;
	import vegas.events.EventListener;
	
	[ExcludeClass]
	
	/**
     * This interface implement class who stores the listeners object an notifies them.
     * @author eKameleon
     */
	public interface IEventDispatcher extends EventTarget
	{
	
		/**
	     * Allows the registration of global event listeners on the event target.
	     * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <b>EventListener</b> interface.
	     * @param priority Determines the priority level of the event listener.
	     * @param autoRemove Apply a removeEventListener after the first trigger
	     */
		function addGlobalEventListener(listener:EventListener, priority:uint, autoRemove:Boolean):void ;
	
		/**
	     * Returns the <code class="prettyprint">EventListenerCollection</code> of the specified event name.
	     * @return the <code class="prettyprint">EventListenerCollection</code> of the specified event name.
	     */
		function getEventListeners(eventName:String):EventListenerCollection ;
	    
	    /**
	     * Returns the <code class="prettyprint">EventListenerCollection</code> of this EventDispatcher.
	     * @return the <code class="prettyprint">EventListenerCollection</code> of this EventDispatcher.
	     */
		function getGlobalEventListeners():EventListenerCollection ;
		
		/**
	     * Returns a <code class="prettyprint">Set</code> of all register event's name in this EventListener.
	     * @return a <code class="prettyprint">Set</code> of all register event's name in this EventListener.
	     */
		function getRegisteredEventNames():Set ;
	
		/**
	     * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	     * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
	     */ 
		function hasEventListener(eventName:String):Boolean ;
	
		/** 
	     * Removes a global listener from the EventDispatcher object.
    	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
    	 * @param the string representation of the class name of the EventListener or a EventListener object.
    	 */
		function removeGlobalEventListener( listener:* ):EventListener ;
	
	}
}