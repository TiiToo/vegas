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

package vegas.events
{
    import vegas.core.CoreObject;
    import vegas.data.iterator.Iterator;
    import vegas.data.map.ArrayMap;
    import vegas.data.map.HashMap;
    
	/**
	 * The Front Controller pattern defines a single EventDispatcher that is responsible for processing application requests.
  	 * <p>A front controller centralizes functions such as view selection, security, and templating, and applies them consistently across all pages or views. Consequently, when the behavior of these functions need to change, only a small part of the application needs to be changed: the controller and its helper classes.</p>
 	 * @author eKameleon
 	 */
    public class FrontController extends CoreObject
    {
        
		/**
		 * Creates a new FrontController instance.
		 * @param channel the channel of this FrontController.
		 * @param target the EventDispatcher reference to switch with the default EventDispatcher singleton in the controller.
		 * <p><b>Example :</b> {@code var oC = new FrontController() ;}</p>
		 */
        public function FrontController( channel:String=null, target:EventDispatcher=null )
        {
		    _map = new ArrayMap() ;
    		_dispatcher = target || EventDispatcher.getInstance(channel) ; 
        }

		/**
 	 	 * Removes all entries in the FrontController. 
		 */
		public function clear():void
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
    	 * @param eventName:String
    	 */
    	public function contains( eventName:String ):Boolean 
    	{
    		return _map.containsKey(eventName) ;	
    	}
    	
    	/**
    	 * Dispatch an event into the FrontController
    	 * @param e:Event 
    	 */
    	public function fireEvent( e:* ):void 
    	{
    		if (e is String)
    		{
    			_dispatcher.dispatchEvent( new BasicEvent(e) ) ;	
    		}
    		else
    		{
    			_dispatcher.dispatchEvent( e ) ;		
    		}
  	        
    	}

		/**
		 * Flush all global FrontController singletons.
	 	*/
		static public function flush():void 
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
		static public function getInstance( channel:String = null ):FrontController 
		{
			if ( channel == null ) 
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
    	 * Returns a EventListener
    	 * @usage  myController.get( myEvent:String ) ;	
    	 * @param  eventName:String
    	 * @return an EventListener or a event callback Function.
    	 */
    	public function getListener(eventName:String):* 
    	{
    		return _map.get(eventName) ;
    	}
    
    	/**
    	 * Add a new entry into the FrontController.
    	 * @param eventName:String
    	 * @param listener:EventListener or listener:Function
    	 */
    	public function insert(eventName:String, listener:* ):void 
    	{
    		_map.put.apply( this, arguments ) ;
    		_dispatcher.registerEventListener( eventName, listener ) ;
    	}
    	
    	/**
    	 * Remove an entry into the FrontController.
    	 * @param eventName:String
    	 * @return nothing
    	 */
    	public function remove(eventName:String):void
    	{
    		var listener:* = _map.remove( eventName ) ;
    		if (listener) 
    		{
    		    _dispatcher.unregisterEventListener(eventName, listener);
    		}
    	}
    	
    	/**
		 * Removes a global FrontController singleton.
		 */
		static public function removeInstance( channel:String ):Boolean 
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
		public function setEventDispatcher( target:EventDispatcher ):void
		{
			_dispatcher = target ;
		}  	
   
    	/**
    	 * Returns the number of elements in the controller.
    	 * @return the number of elements in the controller.
    	 */
	   	public function size():int
    	{
    		return _map.size() ;
    	}
 
		/**
	     * Internal EventDispatcher instance.
		 */
       	private var _dispatcher:EventDispatcher ;
 		
 		/**
	 	 * The static internal hashmap to register all global instances in your applications.
	 	 */	
		static private var instances:HashMap = new HashMap() ;

		/**
		 * Internal HashMap reference.
		 */
        private var _map:ArrayMap ;
        
    }
    
}