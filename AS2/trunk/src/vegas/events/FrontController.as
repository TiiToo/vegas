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
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.data.map.HashMap;
import vegas.events.Event;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;

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
	public function fireEvent(e:Event):Void 
	{
		_dispatcher.dispatchEvent(e) ;
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
	 */
	public function insert( eventName:String, listener:EventListener ):Void 
	{
		_map.put( eventName, listener ) ;
		_dispatcher.addEventListener(eventName, listener) ;
	}
	
	/**
	 * Remove an entry into the FrontController.
	 * @param eventName the name of the global event name to remove.
	 */
	public function remove(eventName:String):Void 
	{
		var listener:EventListener = _map.remove.apply(this, arguments ) ;
		if (listener) 
		{
			_dispatcher.removeEventListener(eventName, listener);
		}
	}
	
	/**
	 * Sets the EventDispatcher reference of this FrontController.
	 * @param target The EventDispatcher reference of this FrontController.
	 */
	public function setEventDispatcher( target:EventDispatcher )
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

}