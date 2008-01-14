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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
import vegas.core.CoreObject;
import vegas.data.Map;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.errors.IllegalArgumentError;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;
import vegas.events.EventListenerBatch;

/**
 * The Front Controller pattern defines a single EventDispatcher that is responsible for processing application requests.
 * <p>A front controller centralizes functions such as view selection, security, and templating, and applies them consistently across all pages or views. Consequently, when the behavior of these functions need to change, only a small part of the application needs to be changed: the controller and its helper classes.</p>
 * @author eKameleon
 */
class vegas.events.FrontController extends CoreObject  
{
	
	/**
	 * Creates a new FrontController instance.
	 * @param channel the channel of this FrontController.
	 * @param target the EventDispatcher reference to switch with the default EventDispatcher singleton in the controller.
	 * <p><b>Example :</b> {@code var oC = new FrontController() ;}</p>
	 */
	function FrontController( channel:String , target:EventDispatcher ) 
	{
		_map = new HashMap() ;
		_dispatcher = target || EventDispatcher.getInstance( channel ) ; 
	}
	
	/**
	 * Removes all entries in the FrontController. 
	 */
	public function clear():Void
	{
		if ( size() > 0 )
		{
			var it:Iterator = _map.keyIterator() ;
			while(it.hasNext())
			{
				remove(it.next()) ;	
			}
			_map.clear() ;
		}	
	}
	
	/**
	 * Returns 'true' if the eventName is registered in the FrontController.
	 * @param eventName the name of an event type.
	 */
	public function contains( eventName:String ):Boolean 
	{
		return _map.containsKey(eventName) ;	
	}

	/**
	 * Dispatch an event into the FrontController
	 * @param e an event to dispatch.
	 */
	public function fireEvent( e ):Void 
	{
		_dispatcher.dispatchEvent(e) ;
	}

	/**
	 * Flush all global FrontController singletons.
	 */
	public static function flush():Void 
	{
		FrontController.instances.clear() ;
	}
	
	/**
	 * Returns the internal EventDispatcher singleton reference of this FrontController.
	 * @return the internal EventDispatcher singleton reference of this FrontController.
	 */
	public function getEventDispatcher():EventDispatcher
	{
		return _dispatcher ;		
	}

	/**
	 * Returns a global {@code FrontController} singleton.
	 * @param channel The channel of the FrontController (default the EventDispatcher.DEFAULT_SINGLETON_NAME value).
	 * @return a global {@code FrontController} singleton.
	 */
	public static function getInstance(channel:String):FrontController 
	{
		if (!channel) 
		{
			channel = EventDispatcher.DEFAULT_SINGLETON_NAME ;
		}
		if (!FrontController.instances.containsKey( channel )) 
		{
			FrontController.instances.put( channel , new FrontController(channel) ) ;
		}
		return FrontController(FrontController.instances.get(channel));
	}

	/**
	 * Returns an EventListener reference.
	 * @param  eventName the name of the event type mapped in the FrontController.
	 * @return an EventListener  
	 */
	public function getListener(eventName:String):EventListener 
	{
		return _map.get(eventName) ;
	}
	
	/**
	 * Adds a new entry into the FrontController.
	 * @param eventName the name of the event type.
	 * @param listener the {@code EventListener} mapped in the FrontController with the specified event type.
	 * @throws IllegalArgumentError If the 'eventName' value in argument is {@code null} or {@code undefined}.
	 * @throws IllegalArgumentError If the 'listener' object in argument is {@code null} or {@code undefined}.
	 */
	public function insert( eventName:String, listener:EventListener ):Void 
	{
		if ( eventName == null )
		{
			throw new IllegalArgumentError( this + " insert method failed, the 'eventName' value in argument not must be 'null' or 'undefined'.") ;	
		}
		if ( listener == null )
		{
			throw new IllegalArgumentError( this + " insert method failed, the 'listener' object in argument not must be 'null' or 'undefined'.") ;	
		}
		_map.put( eventName, listener ) ;
		_dispatcher.addEventListener(eventName, listener) ;
	}

	/**
	 * Adds a new EventListener into an EventListenerBatch in the FrontController.
	 * If this {@code listener} argument is 'null' or 'undefined' and if the {@code eventName} argument isn't register with an EventListenerBatch in the FrontController, 
	 * an empty EventListenerBatch is created and register in the FrontController with the specified 'eventName'.
	 * @param eventName The name of the event type.
	 * @param listener (optional) The {@code EventListener} mapped in the FrontController with the specified event type (This listener is added in an EventListenerBatch). 
	 * @throws IllegalArgumentError If the 'eventName' value in argument not must be 'null' or 'undefined'.
	 */
	public function insertBatch( eventName:String, listener:EventListener ):Void
	{
		if ( eventName == null )
		{
			throw new IllegalArgumentError( this + " insertBatch method failed, the 'eventName' value in argument not must be 'null' or 'undefined'.") ;	
		}
		if ( _map.containsKey(eventName) )
		{
			if ( _map.get( eventName ) instanceof EventListenerBatch && listener != null )
			{
				EventListenerBatch( _map.get( eventName ) ).insert( listener ) ;
				return ;				
			}
		}
		var batch:EventListenerBatch = new EventListenerBatch() ;
		if ( listener != null )
		{
			batch.insert( listener ) ;
		}
		insert( eventName , batch ) ;
	}
	
	/**
	 * Remove an entry into the FrontController.
	 * @param eventName the name of the global event name to remove.
	 */
	public function remove( eventName:String ):Void 
	{
		var listener:EventListener = _map.remove( eventName ) ;
		if ( listener != null ) 
		{
			_dispatcher.removeEventListener(eventName, listener);
		}
	}
	
	/**
	 * Removes a global FrontController singleton.
	 */
	public static function removeInstance( channel:String ):Boolean 
	{
		if (!FrontController.instances.containsKey(channel)) 
		{
			return FrontController.instances.remove(channel) != null ;
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
	public function setEventDispatcher( target:EventDispatcher ):Void
	{
		_dispatcher = target ;
	}
	
	/**
	 * Returns the number of entries in the FrontController.
	 * @return the number of entries in the FrontController.
	 */
	public function size():Number
	{
		return _map.size() ;
	}

	/**
	 * Internal HashMap reference.
	 */
	private var _map:Map ;
	
	/**
	 * Internal EventDispatcher instance.
	 */
	private var _dispatcher:EventDispatcher ;

	/**
	 * The static internal hashmap to register all global instances in your applications.
	 */	
	private static var instances:HashMap = new HashMap() ;

}