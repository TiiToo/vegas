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
 * The EventTarget interface inspired by the <a href='http://www.w3.org/TR/2000/REC-DOM-Level-2-Events-20001113/'>Document Object Model (DOM) Level 2 Events Specification</a>.
 * @author eKameleon
 */
if (vegas.events.EventTarget == undefined) 
{

	/**
	 * Creates a new EventTarget instance.
	 */
	vegas.events.EventTarget = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.EventTarget.extend(vegas.core.CoreObject) ;
	
	/**
	 * Allows the registration of event listeners on the event target.
	 * 
	 * @param eventName A string representing the event type to listen for. If eventName value is {@code ALL} this method use {@code addGlobalListener}
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 * @param useCapture Determinates if the event flow use capture or not.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 * 
	 */
	vegas.events.EventTarget.prototype.addEventListener = function ( eventName/*String*/, listener/*EventListener*/, useCapture/*Boolean*/, priority/*Number*/, autoRemove/*Boolean*/)/*void*/ 
	{
		// override this method.
	}

	/**
	 * Dispatches an event into the event flow.
	 * 
	 * @param event The Event object that is dispatched into the event flow.
	 * @param isQueue if the EventDispatcher isn't register to the event type the event is bufferized.
	 * @param target the target of the event.
	 * @param contect the context of the event.
	 * 
	 * @return the reference of the event dispatched in the event flow.
	 * 
	 */
	vegas.events.EventTarget.prototype.dispatchEvent = function (event, isQueue/*Boolean*/, target, context) /*Event*/ 
	{
		// override this method.
	}

	/** 
	 * Removes a listener from the {@code EventDispatcher} object.
	 * <p>If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.</p>
	 * 
	 * @param Specifies the type of event.
	 * @param the class name(string) or a EventListener object.
	 */
	vegas.events.EventTarget.prototype.removeEventListener = function (eventName/*String*/, listener, useCapture/*Boolean*/)/*EventListener*/ 
	{
		// override this method.
	}

}