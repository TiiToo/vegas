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
 * This abstract class is used to create concrete {@code IEventDispatcher} implementations. This class used an internal {@code EventDispatcher} object by composition.
 * <p>You can overrides the internal {@code EventDispatcher} instance with the {@code initEventDispatcher} method. Used a global singleton reference in this method to register all events in a {@code FrontController} for example.</p>
 * @author eKameleon
 */
if (vegas.events.AbstractCoreEventDispatcher == undefined) 
{

	/**
	 * @requires vegas.events.IEventDispatcher
	 */
	require("vegas.events.IEventDispatcher") ;

	/**
	 * Creates a new AbstractCoreEventDispatcher.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	vegas.events.AbstractCoreEventDispatcher = function (  bGlobal /*Boolean*/ , sChannel /*String*/  ) 
	{ 
		this.setGlobal( bGlobal, sChannel ) ;
	}

	/**
	 * @extends vegasevents.IEventDispatcher
	 */
	proto = vegas.events.AbstractCoreEventDispatcher.extend( vegas.events.IEventDispatcher ) ;

	/**
	 * Allows the registration of event listeners on the event target.
	 * @param eventName A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 * @param useCapture Determinates if the event flow use capture or not.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	proto.addEventListener = function ( eventName/*String*/, listener/*EventListener*/, useCapture/*Boolean*/, priority/*Number*/, autoRemove/*Boolean*/) /*Void*/ 
	{
		this._oDispatcher.addEventListener.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/**
	 * Allows the registration of global event listeners on the event target.
	 * 
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <b>EventListener</b> interface.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	proto.addGlobalEventListener = function(listener/*EventListener*/, priority/*Number*/, autoRemove/*Boolean*/) /*Void*/ 
	{
		this._oDispatcher.addGlobalEventListener.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/**
	 * Dispatches an event into the event flow.
	 * @param event The Event object that is dispatched into the event flow.
	 * @param isQueue if the EventDispatcher isn't register to the event type the event is bufferized.
	 * @param target the target of the event.
	 * @param contect the context of the event.
	 * @return the reference of the event dispatched in the event flow.
	 */
	proto.dispatchEvent = function (event, isQueue/*Boolean*/, target, context) /*Event*/ 
	{
		return this._oDispatcher.dispatchEvent.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}


	/**
	 * Returns the internal {@code EventDispatcher} reference.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	proto.getEventDispatcher = function() /*EventDispatcher*/ 
	{
		return this._oDispatcher ;	
	}	

	/**
	 * Returns the {@code EventListenerCollection} of the specified event name.
	 * @return the {@code EventListenerCollection} of the specified event name.
	 */
	proto.getEventListeners = function(eventName/*String*/)/*EventListenerCollection*/ 
	{
		return this._oDispatcher.getEventListeners.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/**
	 * Returns the {@code EventListenerCollection} of this EventDispatcher.
	 * @return the {@code EventListenerCollection} of this EventDispatcher.
	 */
	proto.getGlobalEventListeners = function()/*EventListenerCollection*/ 
	{
		return this._oDispatcher.getGlobalEventListeners.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/**
	 * Returns the value of the isGlobal flag of this model.
	 * @return {@code true} if the model use a global EventDispatcher to dispatch this events.
	 */
	proto.getIsGlobal = function() /*Boolean*/
	{
		return this._isGlobal ;	
	}

	/**
	 * Returns the EventDispatcher reference of the parent of this instance.
	 * @return the EventDispatcher reference of the parent of this instance.
	 */
	proto.getParent = function () /*EventDispatcher*/ 
	{
		return this._oDispatcher.parent ;
	}

	/**
	 * Returns a {@code Set} of all register event's name in this EventListener.
	 * @return a {@code Set} of all register event's name in this EventListener.
	 */
	proto.getRegisteredEventNames = function()/*Set*/ 
	{
		return this._oDispatcher.getRegisteredEventNames.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/**
	 * Returns the target of this instance.
	 * @return the target of this instance.
	 */
	proto.getTarget = function () 
	{
		return this._oDispatcher.getTarget() ;
	}

	/**
	 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
	 */ 
	proto.hasEventListener = function(eventName/*String*/)/*Boolean*/ 
	{
		return this._oDispatcher.hasEventListener.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/**
	 * Creates and returns the internal {@code EventDispatcher} reference (this method is invoqued in the constructor).
	 * You can overrides this method if you wan use a global {@code EventDispatcher} singleton.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	proto.initEventDispatcher = function () /*EventDispatcher*/ 
	{
		return new vegas.events.EventDispatcher(this) ;
	}

    /**
     * Returns {@code true} if the object is locked.
     * @return {@code true} if the object is locked.
     */
	proto.isLocked = function() /*Boolean*/ 
    {
        return this.___isLock___ ;
    }

    /**
     * Locks the object.
     */
	proto.lock = function() /*void*/ 
    {
        this.___isLock___ = true ;
    }

	/** 
	 * Removes a listener from the EventDispatcher object.
	 * If there is no matching listener registered with the {@code EventDispatcher} object, then calling this method has no effect.
	 * @param Specifies the type of event.
	 * @param the class name(string) or a {@code EventListener} object.
	 */
	proto.removeEventListener = function (eventName/*String*/, listener, useCapture/*Boolean*/)/*EventListener*/ 
	{
		return this._oDispatcher.removeEventListener.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/** 
	 * Removes a global listener from the EventDispatcher object.
	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
	 * @param the string representation of the class name of the EventListener or a EventListener object.
	 */
	proto.removeGlobalEventListener = function( listener )/*EventListener*/ 
	{
		return this._oDispatcher.removeGlobalEventListener.apply(this._oDispatcher, Array.fromArguments(arguments)) ;
	}

	/**
	 * Sets the internal {@code EventDispatcher} reference.
	 */
	proto.setEventDispatcher = function( e /*EventDispatcher*/ ) /*void*/ 
	{
		this._oDispatcher = e || this.initEventDispatcher() ;
	}
	
	/**
	 * Sets if the model use a global {@code EventDispatcher} to dispatch this events, if the {@code flag} value is {@code false} the model use a local EventDispatcher.
	 * @param flag the flag to use a global event flow or a local event flow.
	 * @param channel the name of the global event flow if the {@code flag} argument is {@code true}.  
	 */
	proto.setGlobal = function ( flag /*Boolean*/ , channel /*String*/ ) /*void*/ 
	{
		this._isGlobal = flag ;
		this.setEventDispatcher( flag ? vegas.events.EventDispatcher.getInstance( channel ) : null ) ;
	}

	/**
	 * Sets the parent EventDispatcher reference of this instance.
	 */
	proto.setParent = function( parent /*EventDispatcher*/ )/*Void*/ 
	{
		return this._oDispatcher.parent = parent ;
	}

    /**
     * Unlocks the display.
     */
    proto.unLock = function() /*void*/ 
    {
        this.___isLock___ = false ;
    }

	/**
	 * (read-only) Returns the value of the isGlobal flag of this model. Use the {@code setGlobal} method to modify this value.
	 * @return {@code true} if the model use a global EventDispatcher to dispatch this events.
	 */
	proto.__defineGetter__( "isGlobal", proto.getIsGlobal ) ;	

    /**
     * The internal flag to indicates if the display is locked or not.
     */ 
    proto.___isLock___ /*Boolean*/ = false ;

	/**
	 * The protected internal EventDispatcher reference.
	 * @private
	 */
	proto._oDispatcher = null ;
	
	// encapsulate
	
	delete proto ;
	

}