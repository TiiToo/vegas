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
 * Internal class in the {@code EventDispatcher} class to register in an {@code EventCollection} an {@code EventListener}.
 * @author eKameleon
 * @see EventListenerCollection
 * @see EventListenerComparator
 */
if (vegas.events.EventListenerContainer == undefined) 
{

	/**
	 * Creates a new EventListenerContainer instance.
	 * @param listener an {@code EventListener}
	 */	
	vegas.events.EventListenerContainer = function ( listener /*EventListener*/ ) 
	{
		this._listeners = listener ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.EventListenerContainer.extend(vegas.core.CoreObject) ;
	
	/**
	 * Determinates if the listener use capture flow event or not.
	 */	
	vegas.events.EventListenerContainer.prototype.useCaptude /*Boolean*/ = null ;
	
	/**
	 * Enables the auto remove option in the EventListener.
	 * @param enable a boolean to indicated if the EventListener is autoRemove at the end of the event flow.
	 */
	vegas.events.EventListenerContainer.prototype.enableAutoRemove = function ( enable /*Boolean*/ ) 
	{
		this._autoRemove = enable;
	}

	/**
	 * Returns the priority of the {@code EventListener}. This priority is used in the {@code EventListenerComparator}.
	 * @return the priority of the {@code EventListener}. This priority is used in the {@code EventListenerComparator}.
	 * @see EventListenerComparator
	 */
	vegas.events.EventListenerContainer.prototype.getPriority = function () /*Number*/ 
	{
		return (this._priority > 0) ? this._priority : 0 ;
	}

    /**
     * Returns {@code true} if the {@code EventListener} is auto remove at the end of the event flow.
     * @return {@code true} if the {@code EventListener} is auto remove at the end of the event flow.
     */
	vegas.events.EventListenerContainer.prototype.isAutoRemoveEnabled = function () /*Boolean*/ 
	{
        return this._autoRemove;
    }

	/**
	 * Returns the {@code EventListener} reference.
	 * @return the {@code EventListener} reference.
	 */
	vegas.events.EventListenerContainer.prototype.getListener = function ()/*EventListener*/ 
	{
        return this._listeners || null ;
    }
    
    /**
     * Sets the priority of the {@code EventListener}.
     */
	vegas.events.EventListenerContainer.prototype.setPriority = function (n/*Number*/)/*Void*/ 
	{
		this._priority = (n>0) ? n : 0 ;
	}
	
	vegas.events.EventListenerContainer.prototype._autoRemove /*Boolean*/ = false ;
	vegas.events.EventListenerContainer.prototype._listeners /*EventListener*/ = null ;
	vegas.events.EventListenerContainer.prototype._priority  /*Number*/ = 1 ;

}