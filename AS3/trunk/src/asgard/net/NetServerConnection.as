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
    import flash.events.IOErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.NetConnection;
    import flash.net.ObjectEncoding;
    import flash.utils.Timer;
    
    import asgard.events.NetServerEvent;
    
    import vegas.core.HashCode;
    import vegas.core.ICloneable;
    import vegas.core.IHashable;
    import vegas.core.IRunnable;
    import vegas.core.ISerializable;
    import vegas.events.EventDispatcher;
    import vegas.events.IEventDispatcher;
    import vegas.logging.ILogable;
    import vegas.logging.ILogger;
    import vegas.util.ClassUtil;
    
    /**
 	 * This class extends the NetConnection class and defined an implementation based on VEGAS to used Flash Remoting or Flash MediaServer (with AMF protocol).
	 * @author eKameleon
	 */	
	public class NetServerConnection extends NetConnection implements ICloneable, IEventDispatcher, IHashable, ILogable, IRunnable, ISerializable
	{
		
		/**
		 * Creates a new NetServerConnection instance.
	 	 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
		public function NetServerConnection( bGlobal:Boolean = false , sChannel:String = null )
		{
			
			setGlobal( bGlobal , sChannel ) ;	
			
			_timer = new Timer(DEFAULT_DELAY, 1) ;
			
			objectEncoding = ObjectEncoding.AMF0 ; // DEFAULT AMF0
			
			initEvent() ;
			
			addEventListener( IOErrorEvent.IO_ERROR             , onIOError) ;
			addEventListener( NetStatusEvent.NET_STATUS         , _onStatus) ;
			addEventListener( SecurityErrorEvent.SECURITY_ERROR , onSecurityError);
			
		}
		
		private static var _initHashCode:Boolean = HashCode.initialize(NetServerConnection.prototype) ;
		
		/**
	     * The default internal timeout delay value in milliseconds.
	     */
		public static const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
		
		public var noEvent:Boolean = false ;
		
		/**
		 * Returns the shallow copy of this object.
	 	 * @return the shallow copy of this object.
		 */
		public function clone():*
		{
			return new NetServerConnection() ;
		}
		
		/**
		 * Close the connection.
		 * @param noEvent if this argument is {@code true} the event propagation is disabled.
		 */		
		public override function close():void 
		{
			super.close() ;
			_timer.stop() ;
			if (!noEvent) 
			{
			    notifyClose() ;
			}
		}

		/**
		 * Connect the client with this method.
		 */
		public override function connect(command:String, ... arguments):void
		{
			notifyStarted() ;
			super.connect.apply(this, [command].concat(arguments)) ;
		}

    	/**
    	 * Returns and creates a new empty ModelObjectEvent. You can override this method.
    	 * @param type the type of the event.
    	 * @return a new empty ModelObjectEvent with the type specified in argument.
    	 */
	    public function createNewEvent( type:String ):NetServerEvent
	    {
    		return new NetServerEvent( type || null , this ) ;
    	}

    	/**
    	 * Returns the event name use in the connection is closed.
    	 * @return the event name use in the connection is closed.
    	 */
	    public function getEventTypeCLOSE():String
	    {
    		return _eClose.type ;
    	}
    
    	/**
	     * Returns the event name use in the connection is finished.
	     * @return the event name use in the connection is finished.
	     */
	    public function getEventTypeFINISH():String
	    {
    		return _eFinish.type ;
    	}
        	
    	/**
    	 * Returns the event name use in the connection is started.
	     * @return the event name use in the connection is started.
	     */
    	public function getEventTypeSTART():String
    	{
		    return _eStart.type ;
	    }
    	
    	/**
	     * Returns the event name use in the connection status changed.
	     * @return the event name use in the connection status changed.
	     */
	    public function getEventTypeSTATUS():String
	    {
            return _eStatus.type ;
	    }
    
        /**
	     * Returns the event name use in the connection is out of time.
    	 * @return the event name use in the connection is out of time.
    	 */
	    public function getEventTypeTIMEOUT():String
	    {
    		return _eTimeOut.type ;
    	}

		/**
		 * Returns timeout interval duration.
		 */
		public function getDelay():uint
		{
			return _timer.delay ;
		}
		
    	/**
	     * Returns the singleton instance of class.
	     * @return singleton instance of class.
	     */
	    public static function getInstance():NetServerConnection
	    {
    		if ( _instance == null )
		    {
    			_instance = new NetServerConnection() ;
		    }
		    return _instance ;
	    }
		
    	/**
	     * Returns the value of the isGlobal flag of this model.
	     * @return {@code true} if the model use a global EventDispatcher to dispatch this events.
	     */
	    public function getIsGlobal():Boolean 
	    {
    		return _isGlobal ;
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
	     * Returns the TimeoutPolicy value of this object.
	     * @return the TimeoutPolicy value of this object.
	     * @see TimeoutPolicy
	     */
		public function getTimeoutPolicy():TimeoutPolicy 
		{
			return _policy ;	
		}
	
	    /**
	     * Returns a hash code value for the object.
	     * @return a hash code value for the object.
	     */
		public function hashCode():uint
		{
			return null ;
		}
		
    	/**
    	 * This method is invoqued in the constructor of the class to initialize all events.
    	 * Overrides this method.
    	 */
    	public function initEvent():void
    	{
    	    _eClose = new NetServerEvent( NetServerEvent.CLOSE ) ;
			_eFinish = new NetServerEvent( NetServerEvent.FINISH ) ;
			_eStart = new NetServerEvent( NetServerEvent.START ) ;
			_eStatus = new NetServerEvent( NetServerEvent.NET_STATUS ) ;
			_eTimeOut = new NetServerEvent( NetServerEvent.TIMEOUT ) ;
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

    	/**
    	 * Invoqued when the connection is closed.
    	 */
		protected function notifyClose():void 
		{
			dispatchEvent( _eClose ) ;	
		}

    	/**
	     * Invoqued when the connection is finished.
    	 */
		protected function notifyFinished():void 
		{
			dispatchEvent(_eFinish) ;
		}

    	/**
    	 * Invoqued when the connection is started.
    	 */
		protected function notifyStarted():void 
		{
			_timer.start() ;
			dispatchEvent( _eStart ) ;
		}
		
    	/**
    	 * Invoqued when the status of the connection is changed.
    	 */
		protected function notifyStatus( status:NetServerStatus , info:* = null ):void 
		{
			_eStatus.setInfo(info) ;
			_eStatus.setStatus(status) ;
			dispatchEvent( _eStatus ) ;	
		}
	
    	/**
	     * Invoqued when the connection is timeout.
	     */
	    protected function notifyTimeOut():void
		{
			dispatchEvent(_eTimeOut) ;	
		}

       /**
        * Registers an {@code EventListener} object with an EventDispatcher object so that the listener receives notification of an event.
        */
       public function registerEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
       {
           // TODO finish this implementation.           
       }

	    /**
	     * Runs the process of this NetServerConnection.
	     */
		public function run( ...arguments:Array ):void 
		{
			connect(uri) ;	
		}
		
		/**
		 * Set timeout interval duration.
		 */
		public function setDelay(n:Number, useSeconds:Boolean):void 
		{
			var t:Number = (n > 0) ? n : 0 ;
			if (useSeconds) t = Math.round(t * 1000) ;
			_timer.delay = t ;
		}

    	/**
	     * Sets the internal {@code EventDispatcher} reference.
	     */
	    public function setEventDispatcher( e:EventDispatcher ):void 
	    {
    		_dispatcher = e || initEventDispatcher() ;
    	}

	    /**
	     * Sets the event name use in the connection is closed.
	     */
	    public function setEventTypeCLOSE( type:String ):void
	    {
    		_eClose.type = type ;
    	}

    	/**
	     * Sets the event name use in the connection is finished.
	     */
	    public function setEventTypeFINISH( type:String ):void
	    {
    		_eFinish.type = type ;
    	}
	
    	/**
	     * Sets the event name use in the connection is started.
	     */
    	public function setEventTypeSTART( type:String ):void
	    {
    		_eStart.type = type ;
    	}
	    
	    /**
	     * Sets the event name use in the connection status changed.
	     */
	    public function setEventTypeSTATUS( type:String ):void
	    {
    		_eStatus.type = type ;
    	}
        
	    /**
	     * Sets the event name use in the connection is out of time.
	     */
	    public function setEventTypeTIMEOUT( type:String ):void
	    {
    		_eTimeOut.type = type ;
    	}

    	/**
    	 * Sets if the model use a global {@code EventDispatcher} to dispatch this events, if the {@code flag} value is {@code false} the model use a local EventDispatcher.
    	 * @param flag the flag to use a global event flow or a local event flow.
	     * @param channel the name of the global event flow if the {@code flag} argument is {@code true}.  
	     */
    	public function setGlobal( flag:Boolean , channel:String ):void 
    	{
		    _isGlobal = flag ;
    		setEventDispatcher( flag ? EventDispatcher.getInstance( channel ) : null ) ;
        }

		/**
		 * Use limit timeout interval.
		 * @see TimeoutPolicy
		 */
		public function setLimitPolicy( policy:TimeoutPolicy ):void 
		{
			_policy = policy ;
			if (_policy == TimeoutPolicy.LIMIT) 
			{
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
			}
			else 
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
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
	     * Use this method to dispatch in FMS application an event.
	     */
	    public function sharedEvent( event:* = null , context:* = null ):void 
	    {
    		if (event is Event) 
		    {
    			this.call( (event as Event).type, null, event ) ;
		    }
		    else if ( event is String ) 
		    {
    			this.call( event, null, context ) ;
		    }
	    }
	
    	/**
    	 * Returns the string Eden representation of this object.
    	 * @return the string Eden representation of this object.
    	 */
		public function toSource(...arguments:Array):String
		{
			return "new asgard.net.NetServerConnection()" ;
		}
	
	    /**
	     * Returns the string representation of this object.
	     * @return the string representation of this object.
	     */
		public override function toString():String
		{
			return "[" + ClassUtil.getName(this) + "]" ;
		}
		
	    /**
         * Removes an {@code EventListener} from the EventDispatcher object.
         */
       public function unregisterEventListener(type:String, listener:*, useCapture:Boolean = false):void 
       {
           // TODO finish this implementation
       }
		
		protected function onIOError(e:IOErrorEvent):void
		{
			_timer.stop() ;
			notifyFinished() ;
		}
		
		protected function onSecurityError(e:SecurityErrorEvent):void
		{
			_timer.stop() ;
			notifyFinished() ;
		}
		
		private var _dispatcher:EventDispatcher ;
		
		private var _eClose:NetServerEvent ;

		private var _eFinish:NetServerEvent ;

		private var _eStart:NetServerEvent ;

		private var _eStatus:NetServerEvent ;

		private var _eTimeOut:NetServerEvent ;

	    private static var _instance:NetServerConnection;
	    
	    private var _isGlobal:Boolean ;
	    
	    private var _logger:ILogger ;

		private var _policy:TimeoutPolicy ;

		private var _timer:Timer ;
		
		private function _onStatus( e:NetStatusEvent ):void
		{
			
			_timer.stop() ;
			
			var code:NetServerStatus = NetServerStatus.format( e.info.code ) ;
			
			// trace("> " + this + "._onStatus(" + code + ")") ;
			
			switch (code) 
			{
				
				case NetServerStatus.BAD_VERSION :
				{
					notifyStatus( NetServerStatus.BAD_VERSION , e.info) ;
					break ;
				}
				case NetServerStatus.CLOSED :
				{
					notifyStatus(NetServerStatus.CLOSED, e.info) ;
					break ;
				}
				case NetServerStatus.FAILED :
				{
					notifyStatus(NetServerStatus.FAILED, e.info) ;
					break ;
				}
				case NetServerStatus.INVALID :
				{
					notifyStatus(NetServerStatus.INVALID, e.info) ;
					break ;
				}	
				case NetServerStatus.REJECTED :
				{
					notifyStatus(NetServerStatus.REJECTED, e.info) ;
					break ;
				}
				case NetServerStatus.SHUTDOWN :
				{
					notifyStatus(NetServerStatus.SHUTDOWN, e.info) ;
					break ;
				}
				case NetServerStatus.SUCCESS :
				{
					notifyStatus(NetServerStatus.SUCCESS, e.info) ;
					break ;
				}
			}
			notifyFinished() ;
		}
		
		/**
	     * Invoqued when the connection is out of time.
	     */
		public function _onTimeOut(e:TimerEvent):void 
		{
			this._timer.stop() ;
    		this.notifyTimeOut() ;
			this.notifyFinished() ;
			this.close() ;
		}
		
		
	}
	
}