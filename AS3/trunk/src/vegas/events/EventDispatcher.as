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

package vegas.events
{
	
	import flash.events.EventDispatcher;
	
	import vegas.core.HashCode;
	import vegas.data.map.ArrayMap;
	import vegas.logging.ILogable;
	import vegas.logging.ILogger;
	import vegas.util.ClassUtil;
	import vegas.util.Serializer;
	
	public class EventDispatcher extends flash.events.EventDispatcher implements IEventDispatcher, ILogable
    {
		
        /**
		 * Aggregates an instance of the EventDispatcher class.
		 */
        public function EventDispatcher(target:IEventDispatcher=null)
        {
            super(target);
            HashCode.initialize(this) ;
            target = (target == null) ? this : target ;
        }
 
 		/**
	 	 * Determinates the default singleton name.
		 */
        static public const DEFAULT_SINGLETON_NAME:String = "__default__" ;
        
        /**
         * Returns the target reference.
         */
        public var target:IEventDispatcher ;
        
        /**
         * Registers an {@code EventListener} object with an EventDispatcher object so that the listener receives notification of an event.
         */
        VEGAS function addEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {    
        	registerEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }
        
        /**
          * Clear all globals EventBroadcaster instances.
          */
    	static public function flush():void 
  	    {
		    instances.clear() ;
        }

        /**
          * Create and return a globalEventBroadcaster instance.
          */
	    static public function getInstance(name:String=null):vegas.events.EventDispatcher
	    {
		    
		    if (name == null) 
		    {
		    	name = DEFAULT_SINGLETON_NAME ;
		    }
		    
    		if (! instances.containsKey(name)) 
    		{
    			instances.put(name, new vegas.events.EventDispatcher()) ;
    		}

    		return vegas.events.EventDispatcher(instances.get(name)) ;
    		
	    }
 
 		/**
		 * Returns the internal {@code ILogger} reference of this {@code ILogable} object.
		 * @return the internal {@code ILogger} reference of this {@code ILogable} object.
		 */
		public function getLogger():ILogger
		{
			return _logger ; 	
		}
 
	 	/**
	 	 * Returns the name of the display.
		 * @return the name of the display.
		 */
		public function getName():String
		{
			return _sName || null ;
		}
 
        /**
         * Returns the hashCode of the EventDispatcher object.
         * @return the hashCode of the EventDispatcher object.
         */
		public function hashCode():uint 
		{
			return null ;
   		}
		
        /**
         * Registers an {@code EventListener} object with an EventDispatcher object so that the listener receives notification of an event.
         */
        public function registerEventListener( type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
        {    

            var func:Function ;
            
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = EventListener(listener).handleEvent ;
            }

            super.addEventListener(type, func, useCapture, priority, useWeakReference) ;
            
        }
 
        /**
         * Removes a global EventDispatcher instance.
         */
        static public function removeInstance(name:String=null):Boolean 
 	    {
 	        if (name == null) name = vegas.events.EventDispatcher.DEFAULT_SINGLETON_NAME ;
      		if (!instances.containsKey(name)) 
    		{
    			return instances.remove(name) != null ;
	     	}
	        else 
	        {
    			return false ;
        	}
	    }
	    
		/**
		 * Sets the internal {@code ILogger} reference of this {@code ILogable} object.
		 */
		public function setLogger( log:ILogger ):void 
		{
			_logger = log ;
		}
		
        /**
         * Returns a string representing the source code of the EventDispatcher object.
         */
		public function toSource(...arguments:Array):String 
		{
			return "new vegas.events.EventDispatcher(" + Serializer.toSource(target) + ")" ;
		}

        /**
         * Returns a string representing the specified EventDispatcher object (ECMA-262).
         * @return a string representing the specified EventDispatcher object (ECMA-262).
         */
		override public function toString():String 
		{
			return "[" + ClassUtil.getName(this) + "]" ;
		}

        /**
         * Removes an {@code EventListener} from the EventDispatcher object.
         */
        public function unregisterEventListener(type:String, listener:*, useCapture:Boolean = false):void 
        {
            
            var func:Function ;
            
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = EventListener(listener).handleEvent ;
            }
            
            super.removeEventListener(type, func, useCapture) ;
            
        }
        
		/**
		 * The static internal hashmap to register all global instances in your applications.
		 */	
        static private var instances:ArrayMap = new ArrayMap() ;

		/**
		 * The internal ILogger reference of this object.
		 */
		private var _logger:ILogger ;

		/**
		 * The internal name's property of the instance.
		 */
		private var _sName:String = null ;

    }
    
}