/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net 
{
    import flash.events.Event;
    import flash.net.NetStream;
    
    import asgard.events.SoundEvent;
    
    import pegas.maths.Range;
    
    import system.Reflection;
    
    import vegas.core.HashCode;
    import vegas.core.ILockable;
    import vegas.events.EventDispatcher;
    import vegas.events.IEventDispatcher;    

    // TODO finish implements events etc.
	
    /**
     * The NetServerStream class opens a one-way streaming connection between Flash Player and RTMP server through 
     * a connection made available by a flash.net.NetConnection object or asgard.net.NetServerConnectio object.
 	 * A Stream object is like a channel inside a NetConnection object; this channel can either publish audio and/or video data, 
 	 * using NetStream.publish(), or subscribe to a published stream and receive data, using NetServerStream.play(). 
	 * You can publish or play live (real-time) data and previously recorded data.
     * @author eKameleon
     */
    public class NetServerStream extends NetStream implements IEventDispatcher, ILockable
    {

		/**
		 * Creates the NetServerStream singleton.
		 * @param connection the NetConnection or NetServerConnection reference of this NetServerStream Object.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
        public function NetServerStream( connection:* , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( ( connection is NetServerConnection ) ? ( connection as NetServerConnection ).getNetConnection() : connection ) ;
            client = new NetServerStreamClient(this) ;
            setGlobal( bGlobal , sChannel ) ;
            // addEventListener( ) ;
        }
        
		/**
		 * Returns the percentage of the buffer that is filled.
		 * @return the percentage of the buffer that is filled.
		 */
		public function get bufferPercent():Number
		{
			return Math.min( Math.round( bufferLength / bufferTime * 100 ), 100 ) ;
		}
		
		/**
		 * (read-only) Indicates the duration of the media.
		 * This feature work only if the client property is NetServerStream and the metadaData object is initialize with the duration value, else return 0.
		 */
		public function get duration():Number 
		{
			return _duration ;
		}

		/**
		 * The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). 
		 * A value of 0 represents no panning (balanced center between right and left). 
		 */
		public function get pan():Number
		{
			return soundTransform.pan ;
		}
		
		/**
		 * @private
		 */
		public function set pan( value:Number ):void
		{
			soundTransform.pan = Range.UNITY_RANGE.clamp( isNaN(value) ? 0 : value ) ; 
			_fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
		}		
		
		/**
		 * Returns the percentage progress value of the stream. Using duration and time properties.
		 * @return the percentage progress value of the stream.
		 */
		public function get progress():Number
		{
			var percent:Number = Math.round( this.time * 100 / duration ) ;
			return Range.PERCENT_RANGE.clamp( ( isNaN(percent) || !isFinite(percent) ) ? 0 : percent ) ;
		}
		
		/**
		 * The volume, ranging from 0 (silent) to 1 (full volume). 
		 */
		public function get volume():Number
		{
			return soundTransform.volume ;
		}
		
		/**
		 * @private
		 */
		public function set volume( value:Number ):void
		{
			soundTransform.volume = Range.UNITY_RANGE.clamp( isNaN(value) ? 0 : value ) ; 
			_fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
		}		
		
		/**
		 * Allows the registration of event listeners on the event target.
		 * @param type A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
		 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <code class="prettyprint">EventListener</code> interface.
	 	 * @param useCapture Determinates if the event flow use capture or not.
		 * @param priority Determines the priority level of the event listener.
		 * @param useWeakReference Indicates if the listener is a weak reference.
		 */
        public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener( type, listener, useCapture, priority, useWeakReference ) ;
        }

		/**
		 * Dispatches an event into the event flow.
		 * @param event The Event object that is dispatched into the event flow.
		 * @return <code class="prettyprint">true</code> if the Event is dispatched.
		 */
        public override function dispatchEvent( event:Event ):Boolean
        {
            return _dispatcher.dispatchEvent( event ) ;
        }
 
	 	/**
		 * Returns the internal <code class="prettyprint">EventDispatcher</code> reference.
		 * @return the internal <code class="prettyprint">EventDispatcher</code> reference.
		 */
     	public function getEventDispatcher():EventDispatcher 
     	{
	    	return _dispatcher ;
	    }
  	
		/**
		 * Returns the value of the isGlobal flag of this model.
		 * @return <code class="prettyprint">true</code> if the instance use a global EventDispatcher to dispatch this events.
	 	 */
		public function getIsGlobal():Boolean 
		{
			return _isGlobal ;
		}
 
 		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
		 */ 
        public override function hasEventListener(type:String):Boolean
        {
            return _dispatcher.hasEventListener(type) ;
        }

		/**
		 * Returns a hashcode value for the object.
		 * @return a hashcode value for the object.
		 */
		public function hashCode():uint 
		{
			if ( isNaN( __hashcode__ ) ) 
			{
				__hashcode__ = HashCode.next() ;
			}
			return __hashcode__ ;
		}

		/**
		 * Creates and returns the internal <code class="prettyprint">EventDispatcher</code> reference (this method is invoked in the constructor).
		 * You can overrides this method if you wan use a global <code class="prettyprint">EventDispatcher</code> singleton.
		 * @return the internal <code class="prettyprint">EventDispatcher</code> reference.
	 	 */
       	public function initEventDispatcher():EventDispatcher 
       	{
		    return new EventDispatcher( this ) ;
	    }		
		
    	/**
	     * Returns <code class="prettyprint">true</code> if the object is locked.
	     * @return <code class="prettyprint">true</code> if the object is locked.
	     */
	    public function isLocked():Boolean 
	    {
        	return ___isLock___ ;
    	}
    	
    	/**
	     * Locks the object.
	     */
	    public function lock():void 
	    {
        	___isLock___ = true ;
    	}

		/**
		 * Allows the registration of event listeners on the event target (Function or EventListener).
		 * @param type A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
		 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <code class="prettyprint">EventListener</code> interface.
	 	 * @param useCapture Determinates if the event flow use capture or not.
		 * @param priority Determines the priority level of the event listener.
		 * @param useWeakReference Indicates if the listener is a weak reference.
		 */
        public function registerEventListener(type:String, listener:*, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }

		/** 
		 * Removes a listener from the EventDispatcher object.
		 * If there is no matching listener registered with the <code class="prettyprint">EventDispatcher</code> object, then calling this method has no effect.
		 * @param type Specifies the type of event.
		 * @param the listener object.
		 */
        public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        } 
		
		/**
		 * Sets the duration of the stream video.
		 */
		public function setDuration( duration:Number ):void
		{
			_duration = duration > 0 ? duration : 0 ; 	
		}	

		/**
		 * Sets the internal <code class="prettyprint">EventDispatcher</code> reference.
		 */
		public function setEventDispatcher( e:EventDispatcher ):void 
		{
			_dispatcher = e || initEventDispatcher() ;
		}

		/**
		 * Sets if the instance use a global <code class="prettyprint">EventDispatcher</code> to dispatch this events, if the <code class="prettyprint">flag</code> value is <code class="prettyprint">false</code> the instance use a local EventDispatcher.
		 * @param flag the flag to use a global event flow or a local event flow.
		 * @param channel the name of the global event flow if the <code class="prettyprint">flag</code> argument is <code class="prettyprint">true</code>.  
		 */
		public function setGlobal( flag:Boolean=false , channel:String=null ):void 
		{
			_isGlobal = (flag == true) ;
			setEventDispatcher( _isGlobal ? EventDispatcher.getInstance( channel ) : null ) ;
		}		
        
        /**
         * Returns the eden String representation of this object.
         * @return the eden String representation of this object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "()" ;
        }
   		
	    /**
	     * Unlocks the display.
	     */
    	public function unlock():void 
    	{
	        ___isLock___ = false ;
	    }
		
		/** 
		 * Removes a listener (Function or EventListener object) from the EventDispatcher object.
		 * If there is no matching listener registered with the <code class="prettyprint">EventDispatcher</code> object, then calling this method has no effect.
		 * @param type Specifies the type of event.
		 * @param the listener object.
		 */
        public function unregisterEventListener(type:String, listener:*, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        }

		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		 * This method returns <code class="prettyprint">true</code> if an event listener is triggered during any phase of the event flow when an event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
		 * @return A value of <code class="prettyprint">true</code> if a listener of the specified type will be triggered; <code class="prettyprint">false</code> otherwise.
		 */
        public override function willTrigger(type:String):Boolean
        {
            return _dispatcher.willTrigger(type) ;
        }

		/**
		 * The internal EventDispatcher reference.
		 */
    	private var _dispatcher:EventDispatcher ;  		
		
		/**
		 * @private
		 */
		private var _duration:Number = 0 ;
		
		/**
		 * @private
		 */
		private var __hashcode__:Number ;		
		
    	/**
	 	 * The internal flag to indicate if the event flow is global.
		 * @private
		 */
		private var _isGlobal:Boolean ;		
		
	    /**
	     * The internal flag to indicates if the display is locked or not.
	     * @private
	     */ 
	    private var ___isLock___:Boolean = false ;
		
		/**
		 * @private
		 */
		private function _fireSoundEvent( type:String ):void
		{
			if ( isLocked() )
			{
				return ;	
			}
			dispatchEvent( new SoundEvent( type, this , soundTransform ) ) ; 
		}		
    }
}

