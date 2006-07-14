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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* EventBroadcaster

	AUTHOR
	
		Name : EventBroadcaster
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new EventBroadcaster(target:IEventDispatcher) ;

	PROPERTY SUMMARY
	
		- target:IEventDispatcher

	METHOD SUMMARY
	
        - addEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void

        - dispatchEvent(event:Event):Boolean
        
        - static flush():void 
        
        - static getInstance(name:String):EventDispatcher
        
        - hasEventListener(type:String):Boolean 
        
        - hashCode():uint
        
        - removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        
        - static removeInstance(name:String):Boolean
        
        - toSource(...arguments):String
        
        - toString():String
        
        - willTrigger(type:String):Boolean 
        
	INHERIT
	
		flash.events.EventDispatcher → vegas.events.EventDispatcher

	IMPLEMENTS 
	
		IEventDispatcher, IFormattable, IHashable, ISerializable

**/

package vegas.events
{

    import flash.events.Event ;
    import flash.events.EventDispatcher ;
    import flash.events.IEventDispatcher ;    
    
    import vegas.core.HashCode ;

    import vegas.data.map.ArrayMap ;

    import vegas.events.EventListener ;
    import vegas.events.IEventBroadcaster ;
    
    import vegas.util.ClassUtil ;
    import vegas.util.Serializer ;
 
    public class EventBroadcaster extends EventDispatcher implements IEventBroadcaster
    {

        // ----o Constructor
        
        /**
          * Aggregates an instance of the EventBroadcaster class.
          */
        public function EventBroadcaster(target:IEventDispatcher=null)
        {
            
            super(target);
            target = (target == null) ? this : target ;
           
        }
 
     	// ----o Init HashCode
	
		HashCode.initialize(EventBroadcaster.prototype) ;
		 
        // ----o Public Properties
        
        static public var DEFAULT_DISPATCHER_NAME:String = "__default__" ;
        
        /**
          * Returns the target reference.
          */
        public var target:IEventBroadcaster ;
        
        // ----o Public Methods
        
        /**
          * Registers an event listener object with an EventBroadcaster object so that the listener receives notification of an event.
          */
        public function addListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {    

            var func:Function ;
            
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = listener.handleEvent ;
            }

            super.addEventListener(type, func, useCapture, priority, useWeakReference) ;
            
        }
        
        /**
          * Clear all globals EventBroadcaster instances.
          */
    	static public function flush():void 
  	    {
		    EventBroadcaster.instances.clear() ;
        }

        /**
          * Create and return a globalEventBroadcaster instance.
          */
	    static public function getInstance(name:String=null):EventBroadcaster
	    {
		    
		    if (name == null) name = EventBroadcaster.DEFAULT_DISPATCHER_NAME ;
		    
    		if (!EventBroadcaster.instances.containsKey(name)) 
    		    {
    			EventBroadcaster.instances.put(name, new EventBroadcaster()) ;
    		    }

    		return EventBroadcaster.instances.get(name) ;
    		
	    }
 
        /**
          * Returns the hashCode of the EventDispatcher object.
          */
		public function hashCode():uint 
		{
			return null ;
   		}
 

        /**
          * Removes a event listener from the EventDispatcher object.
          */
        public function removeListener(type:String, listener:*, useCapture:Boolean = false):void 
        {
            
            var func:Function ;
            
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = listener.handleEvent ;
            }
            
            super.removeEventListener(type, func, useCapture) ;
            
        }
        
        /**
          * Remove a global EventDispatcher instance.
          */
        static public function removeInstance(name:String=null):Boolean 
 	    {
 	        
 	        if (name == null) name = EventBroadcaster.DEFAULT_DISPATCHER_NAME ;
 	           
      		if (!EventBroadcaster.instances.containsKey(name)) 
    		    {
    			return EventBroadcaster.instances.remove(name) != null ;
	        	}
	        else 
	            {
    			return false ;
        		}
	    }

        /**
          * Returns a string representing the source code of the EventDispatcher object.
          */
		public function toSource(...arguments:Array):String 
		{
			return "new EventBroadcaster(" + Serializer.toSource(target) + ")" ;
		}

        /**
          * Returns a string representing the specified EventDispatcher object (ECMA-262).
          */
		override public function toString():String 
		{
			return "[" + ClassUtil.getName(this) + "]" ;
		}
        
        // ----o Private Properties
	
        static private var instances:ArrayMap = new ArrayMap() ;

    }
    
}