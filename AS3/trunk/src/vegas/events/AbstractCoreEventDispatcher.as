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
    import flash.events.Event;
    
    import vegas.core.CoreObject;
    import vegas.util.ClassUtil;
    
	/**
 	 * This abstract class is used to create concrete {@code IEventDispatcher} implementations. This class used an internal {@code EventDispatcher} object by composition.
 	 * <p>You can overrides the internal {@code EventDispatcher} instance with the {@code initEventDispatcher} or the {@code setEventDispatcher} methods. Used a global singleton reference in this method to register all events in a {@code FrontController} for example.</p>
	 * @author eKameleon
 	 */
	public class AbstractCoreEventDispatcher extends CoreObject implements IEventDispatcher
    {

		/**
		 * Creates a new AbstractCoreEventDispatcher.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
        public function AbstractCoreEventDispatcher( bGlobal:Boolean = false , sChannel:String = null ) 
        {
    		setGlobal( bGlobal , sChannel ) ;	
        }
       
		/**
		 * (read-only) Returns the value of the isGlobal flag of this model. Use the {@code setGlobal} method to modify this value.
		 * @return {@code true} if the instance use a global EventDispatcher to dispatch this events.
		 */
		public function get isGlobal():Boolean 
		{
			return getIsGlobal() ;
		}
        
		/**
		 * Allows the registration of event listeners on the event target.
		 * @param type A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
		 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 	 * @param useCapture Determinates if the event flow use capture or not.
		 * @param priority Determines the priority level of the event listener.
		 * @param useWeakReference Indicates if the listener is a weak reference.
		 */
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener( type, listener, useCapture, priority, useWeakReference ) ;
        }

		/**
		 * Dispatches an event into the event flow.
		 * @param event The Event object that is dispatched into the event flow.
		 * @return {@code'true} if the Event is dispatched.
		 */
        public function dispatchEvent( event:Event ):Boolean
        {
            return _dispatcher.dispatchEvent( event ) ;
        }
 
	 	/**
		 * Returns the internal {@code EventDispatcher} reference.
		 * @return the internal {@code EventDispatcher} reference.
		 */
     	public function getEventDispatcher():EventDispatcher 
     	{
	    	return _dispatcher ;
	    }
  	
		/**
		 * Returns the value of the isGlobal flag of this model.
		 * @return {@code true} if the instance use a global EventDispatcher to dispatch this events.
	 	 */
		public function getIsGlobal():Boolean 
		{
			return _isGlobal ;
		}
 
 		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
		 */ 
        public function hasEventListener(type:String):Boolean
        {
            return _dispatcher.hasEventListener(type) ;
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

        public function registerEventListener(type:String, listener:*, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }

		/** 
		 * Removes a listener from the EventDispatcher object.
		 * If there is no matching listener registered with the {@code EventDispatcher} object, then calling this method has no effect.
		 * @param type Specifies the type of event.
		 * @param the listener object.
		 */
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        } 

		/**
		 * Sets the internal {@code EventDispatcher} reference.
		 */
		public function setEventDispatcher( e:EventDispatcher ):void 
		{
			_dispatcher = e || initEventDispatcher() ;
		}

		/**
		 * Sets if the instance use a global {@code EventDispatcher} to dispatch this events, if the {@code flag} value is {@code false} the instance use a local EventDispatcher.
		 * @param flag the flag to use a global event flow or a local event flow.
		 * @param channel the name of the global event flow if the {@code flag} argument is {@code true}.  
		 */
		public function setGlobal( flag:Boolean , channel:String ):void 
		{
			_isGlobal = (flag == true) ;
			setEventDispatcher( _isGlobal ? EventDispatcher.getInstance( channel ) : null ) ;
		}

        /**
         * Returns the eden String representation of this object.
         * @return the eden String representation of this object.
         */
        override public function toSource( ...arguments:Array ):String
        {
            return "new " + ClassUtil.getPath(this) + "()" ;
        }

        public function unregisterEventListener(type:String, listener:*, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        }

		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		 * This method returns {@code true} if an event listener is triggered during any phase of the event flow when an event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
		 * @return A value of {@code true} if a listener of the specified type will be triggered; {@code false} otherwise.
		 */
        public function willTrigger(type:String):Boolean
        {
            return _dispatcher.willTrigger(type) ;
        }

    	private var _dispatcher:EventDispatcher ;  
    
    	/**
	 	 * The internal flag to indicate if the event flow is global.
		 */
		private var _isGlobal:Boolean ;
    	
    }
}