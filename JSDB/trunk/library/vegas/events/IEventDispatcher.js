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

/**
 * The interface of the EventDispatcher class.
 * @author eKameleon
 */
if (vegas.events.IEventDispatcher == undefined) 
{
	
	/**
	 * @requires vegas.events.EventTarget
	 */
	require("vegas.events.EventTarget") ;
	
	/**
	 * Creates a new IEventDispatcher instance.
	 */
	vegas.events.IEventDispatcher = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.events.EventTarget 
	 */
	vegas.events.IEventDispatcher.extend(vegas.events.EventTarget) ;

	/**
	 * Allows the registration of global event listeners on the event target.
	 * 
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <b>EventListener</b> interface.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	vegas.events.IEventDispatcher.prototype.addGlobalEventListener = function(listener/*EventListener*/, priority/*Number*/, autoRemove/*Boolean*/)/*Void*/ 
	{
		// override this method.
	}

	/**
	 * Returns the {@code EventListenerCollection} of the specified event name.
	 * @return the {@code EventListenerCollection} of the specified event name.
	 */
	vegas.events.IEventDispatcher.prototype.getEventListeners = function(eventName/*String*/)/*EventListenerCollection*/ 
	{
		// override this method.
	}
	
	/**
	 * Returns the {@code EventListenerCollection} of this EventDispatcher.
	 * @return the {@code EventListenerCollection} of this EventDispatcher.
	 */
	vegas.events.IEventDispatcher.prototype.getGlobalEventListeners = function()/*EventListenerCollection*/ 
	{
		// override this method.
	}

	/**
	 * Returns a {@code Set} of all register event's name in this EventListener.
	 * @return a {@code Set} of all register event's name in this EventListener.
	 */
	vegas.events.IEventDispatcher.prototype.getRegisteredEventNames = function()/*Set*/ 
	{
		// override this method.
	}

	/**
	 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
	 */ 
	vegas.events.IEventDispatcher.prototype.hasEventListener = function(eventName/*String*/)/*Boolean*/ 
	{
		// override this method.
	}

	/** 
	 * Removes a global listener from the EventDispatcher object.
	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
	 * @param the string representation of the class name of the EventListener or a EventListener object.
	 */
	vegas.events.IEventDispatcher.prototype.removeGlobalEventListener = function( listener )/*EventListener*/ 
	{
		// override this method.
	}
	
}