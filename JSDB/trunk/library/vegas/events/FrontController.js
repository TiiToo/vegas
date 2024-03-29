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
 * The Front Controller pattern defines a single EventDispatcher that is responsible for processing application requests.
 * <p>A front controller centralizes functions such as view selection, security, and templating, and applies them consistently across all pages or views. Consequently, when the behavior of these functions need to change, only a small part of the application needs to be changed: the controller and its helper classes.</p>
 * <p><b>Example :</b></p>
 * {@code
 * var action1 = function ( e ) 
 * {
 *     trace("action1 : " + e.getType()) ;
 * }
 * 
 * var action2 = function ( e ) 
 * {
 *     trace("action2 : " + e.getType()) ;
 * }
 * 
 * var ACTION1 = "onAction1" ;
 * var ACTION2 = "onAction2" ;
 * 
 * var listener1 = new vegas.events.Delegate(this, action1) ;
 * var listener2 = new vegas.events.Delegate(this, action2) ;
 * 
 * var controller = new vegas.events.FrontController() ;
 * controller.insert( ACTION1, listener1 ) ;
 * controller.insert( ACTION2, listener2 ) ;
 * 
 * var e1 = new vegas.events.BasicEvent( ACTION1, this ) ;
 * var e2 = new vegas.events.BasicEvent( ACTION2, this ) ;
 * 
 * controller.fireEvent( e1 ) ;
 * controller.fireEvent( e2 ) ;
 * }
 * @see vegas.events.EventDispatcher
 */
if (vegas.events.FrontController == undefined) 
{

	/**
	 * Creates a new FrontController instance.
	 * @param channel the channel of this FrontController.
	 * @param target the EventDispatcher reference to switch with the default EventDispatcher singleton in the controller.
	 * <p><b>Example :</b> {@code var oC = new FrontController() ;}</p>
	 */
	vegas.events.FrontController = function( channel /*String*/, oEDispatcher /*EventDispatcher*/  ) 
	{
		this._map = new vegas.data.map.HashMap() ;
		this._dispatcher = oEDispatcher || vegas.events.EventDispatcher.getInstance( channel ) ; 
	}
	
	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.FrontController.extend(vegas.core.CoreObject) ;
 
 	/**
	 * The static internal hashmap to register all global instances in your applications.
	 */	
	vegas.events.FrontController.instances /*HashMap*/ = new vegas.data.map.HashMap() ;
 
	/**
	 * Removes all entries in the FrontController. 
	 */
	vegas.events.FrontController.prototype.clear = function () /*void*/ 
	{
		if ( this.size() > 0 )
		{
			var it /*Iterator*/ = this._map.keyIterator() ;
			while(it.hasNext())
			{
				this.remove( it.next() ) ;	
			}
			this._map.clear() ;
		}	
	}
 
 	/**
	 * Returns {@code true} if the eventName is registered in the FrontController.
	 * @param eventName the name of the event type to be search.
	 * @return {@code true} if the eventName is registered in the FrontController.
	 */
	vegas.events.FrontController.prototype.contains = function ( eventName ) /*Boolean*/ 
	{
		return this._map.containsKey(eventName) ;
	}
 
 	/**
	 * Dispatch an event into the FrontController
	 * @param e the event to dispatch with the front controller.
	 */
	vegas.events.FrontController.prototype.fireEvent = function(e /*Event*/) /*void*/ 
	{
		this._dispatcher.dispatchEvent(e) ;
	}

	/**
	 * Dispatch an event into the FrontController with a simple event type.
	 * @param type an event type to dispatch a {@code BasicEvent}.
	 */
	vegas.events.FrontController.prototype.fireEventType = function( type /*String*/ ) /*void*/ 
	{
		this.fireEvent( new vegas.events.BasicEvent( type ) ) ;
	}

	/**
	 * Flush all global FrontController singletons.
	 */
	vegas.events.FrontController.flush = function() /*void*/ 
	{
		vegas.events.FrontController.instances.clear() ;
	}
	
	/**
	 * Returns the internal EventDispatcher singleton reference of this FrontController.
	 * @return the internal EventDispatcher singleton reference of this FrontController.
	 */
	vegas.events.FrontController.prototype.getEventDispatcher = function() /*EventDispatcher*/
	{
		return this._dispatcher ;		
	}	

	/**
	 * Returns a global {@code FrontController} singleton.
	 * @param channel The channel of the FrontController (default the EventDispatcher.DEFAULT_SINGLETON_NAME value).
	 * @return a global {@code FrontController} singleton.
	 */
	vegas.events.FrontController.getInstance = function(channel /*String*/ ) /*FrontController*/ 
	{
		if (!channel) 
		{
			channel = vegas.events.EventDispatcher.DEFAULT_SINGLETON_NAME ;
		}
		if (!vegas.events.FrontController.instances.containsKey( channel )) 
		{
			vegas.events.FrontController.instances.put( channel , new vegas.events.FrontController(channel) ) ;
		}
		return vegas.events.FrontController.instances.get(channel) ;
	}

	/**
	 * Returns an EventListener register in the front controller with the specified event name.
	 * @usage  myController.get( myEvent:String ) ;	
	 * @param  eventName the name of the event type.
	 * @return an EventListener register in the front controller with the specified event name.
	 */
	vegas.events.FrontController.prototype.getListener = function(eventName /*String*/ ) /*EventListener*/ 
	{
		return this._map.get(eventName) ;
	}
	
	/**
	 * Add a new entry into the FrontController.
	 * @param eventName the name of the event type.
	 * @param listener the EventListener to be insert in the FrontController map.
	 */
	vegas.events.FrontController.prototype.insert = function(eventName /*String*/ , listener /*EventListener*/ ) /*void*/ 
	{
		try 
		{
			if ( !vegas.util.TypeUtil.typesMatch(eventName, String) ) 
			{
				throw new vegas.errors.IllegalArgumentError( this + " insert method failed, eventName argument must be a 'String'.") ;
			}
			
			if (listener instanceof vegas.events.EventListener) 
			{
				this._map.put.apply( this._map, arguments ) ;
				this._dispatcher.addEventListener(eventName, listener) ;
			}
			else 
			{
				throw new vegas.errors.IllegalArgumentError( this + " insert method failed, listener argument must be an 'vegas.events.EventListener' object.") ;
			}
		} 
		catch (e /*Error*/) 
		{
			this.getLogger( e.toString() ) ;
		}
	}
	
	/**
	 * Remove an entry into the FrontController.
	 * @param eventName the name of the event type.
	 */
	vegas.events.FrontController.prototype.remove = function(eventName /*String*/ ) /*void*/ 
	{
		var listener /*EventListener*/ = this._map.remove.apply(this._map, arguments ) ;
		if (listener != null) 
		{
			this._dispatcher.removeEventListener(eventName, listener);
		}
	}
	
	/**
	 * Removes a global FrontController singleton.
	 */
	vegas.events.FrontController.removeInstance = function( channel /*String*/ ) /*Boolean*/ 
	{
		if (!vegas.events.FrontController.instances.containsKey(channel)) 
		{
			return vegas.events.FrontController.instances.remove(channel) != null ;
		}
		else 
		{
			return false ;
		}
	}
	
	/**
	 * Sets the EventDispatcher reference of this FrontController.
	 * @param target The EventDispatcher reference of this FrontController.
	 */
	vegas.events.FrontController.prototype.setEventDispatcher = function ( target /*EventDispatcher*/ )
	{
		this._dispatcher = target ;
	}
	
	/**
	 * Returns the number of entries in the FrontController.
	 * @return the number of entries in the FrontController.
	 */
	vegas.events.FrontController.prototype.size = function() /*Number*/ 
	{
		return this._map.size() ;	
	}

	vegas.events.FrontController.prototype._map /*Map*/ = null ;

	vegas.events.FrontController.prototype._oE /*EventDispatcher*/ = null ;
 
}
