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

import vegas.core.CoreObject;
import vegas.data.Set;
import vegas.events.Event;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;
import vegas.events.IEventDispatcher;

/**
 * This abstract class is used to create concrete {@code IEventDispatcher} implementations. This class used an internal {@code EventDispatcher} object by composition.
 * <p>You can overrides the internal {@code EventDispatcher} instance with the {@code initEventDispatcher} method. Used a global singleton reference in this method to register all events in a {@code FrontController} for example.</p>
 * @author eKameleon
 */
class vegas.events.AbstractCoreEventDispatcher extends CoreObject implements IEventDispatcher 
{

	/**
	 * Creates a new AbstractCoreEventDispatcher.
	 */
	private function AbstractCoreEventDispatcher() 
	{
		super() ;
		_oED = initEventDispatcher() ;
	}		

	/**
	 * Allows the registration of event listeners on the event target.
	 * @param eventName A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 * @param useCapture Determinates if the event flow use capture or not.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	public function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void 
	{
		_oED.addEventListener.apply(_oED, arguments) ;
	}

	/**
	 * Allows the registration of global event listeners on the event target.
	 * 
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <b>EventListener</b> interface.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	public function addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void 
	{
		_oED.addGlobalEventListener.apply(_oED, arguments) ;
	}		

	/**
	 * Dispatches an event into the event flow.
	 * @param event The Event object that is dispatched into the event flow.
	 * @param isQueue if the EventDispatcher isn't register to the event type the event is bufferized.
	 * @param target the target of the event.
	 * @param contect the context of the event.
	 * @return the reference of the event dispatched in the event flow.
	 */
	public function dispatchEvent(event, isQueue:Boolean, target, context):Event 
	{
		return _oED.dispatchEvent.apply(_oED, arguments) ;	
	}

	/**
	 * Returns the internal {@code EventDispatcher} reference.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	public function getEventDispatcher():EventDispatcher 
	{
		return _oED ;
	}

	/**
	 * Returns the {@code EventListenerCollection} of the specified event name.
	 * @return the {@code EventListenerCollection} of the specified event name.
	 */
	public function getEventListeners(eventName:String):EventListenerCollection 
	{
		return _oED.getEventListeners.apply(_oED, arguments) ;
	}

	/**
	 * Returns the {@code EventListenerCollection} of this EventDispatcher.
	 * @return the {@code EventListenerCollection} of this EventDispatcher.
	 */
	public function getGlobalEventListeners():EventListenerCollection 
	{
		return _oED.getGlobalEventListeners.apply(_oED, arguments) ;
	}

	/**
	 * Returns the EventDispatcher reference of the parent of this instance.
	 */
	public function getParent():EventDispatcher 
	{
		return _oED.parent ;
	}

	/**
	 * Returns a {@code Set} of all register event's name in this EventListener.
	 * @return a {@code Set} of all register event's name in this EventListener.
	 */
	public function getRegisteredEventNames():Set 
	{
		return _oED.getRegisteredEventNames.apply(_oED, arguments) ;
	}

	/**
	 * Returns the target of this instance.
	 */
	public function getTarget() 
	{
		return _oED.getTarget() ;	
	}

	/**
	 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
	 */ 
	public function hasEventListener(eventName:String):Boolean 
	{
		return _oED.hasEventListener.apply(_oED, arguments) ;
	}

	/**
	 * Creates and returns the internal {@code EventDispatcher} reference (this method is invoqued in the constructor).
	 * You can overrides this method if you wan use a global {@code EventDispatcher} singleton.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	public function initEventDispatcher():EventDispatcher 
	{
		return new EventDispatcher( this ) ;
	}

	/** 
	 * Removes a listener from the EventDispatcher object.
	 * If there is no matching listener registered with the {@code EventDispatcher} object, then calling this method has no effect.
	 * @param Specifies the type of event.
	 * @param the class name(string) or a {@code EventListener} object.
	 */
	public function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener 
	{
		return _oED.removeEventListener.apply(_oED, arguments) ;
	}

	/** 
	 * Removes a global listener from the EventDispatcher object.
	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
	 * @param the string representation of the class name of the EventListener or a EventListener object.
	 */
	public function removeGlobalEventListener( listener ):EventListener 
	{
		return _oED.removeGlobalEventListener.apply(_oED, arguments) ;
	}

	/**
	 * Sets the parent EventDispatcher reference of this instance.
	 */
	public function setParent(parent:EventDispatcher):Void 
	{
		_oED.parent = parent ;
	}

	/**
	 * The internal EventDispatcher reference.
	 */
	private var _oED:EventDispatcher ;

}