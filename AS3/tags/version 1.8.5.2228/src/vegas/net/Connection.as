/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.net 
{
    import system.events.ActionEvent;
    import system.events.EventListener;
    import system.process.Action;
    import system.process.TaskPhase;
    import system.process.TimeoutPolicy;
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.events.AsyncErrorEvent;
    import flash.events.ErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.NetConnection;
    import flash.utils.Timer;
    
    /**
     * Dispatched when a process is finished.
     * @eventType system.events.ActionEvent.FINISH
     * @see #notifyFinished
     */
    [Event(name="finish", type="system.events.ActionEvent")]
    
    /**
     * Dispatched when an info process is running.
     * @eventType system.events.ActionEvent.INFO
     * @see #notifyInfo
     */
    [Event(name="info", type="system.events.ActionEvent")]
    
    /**
     * Dispatched when a process is started.
     * @eventType system.events.ActionEvent.START
     * @see #notifyStarted
     */
    [Event(name="start", type="system.events.ActionEvent")]
    
    /**
     * Dispatched when a process is out of time.
     * @eventType system.events.ActionEvent.TIMEOUT
     * @see #notifyTimeOut
     */
    [Event(name="timeout", type="system.events.ActionEvent")]
    
   /**
    * The Connection class creates a two-way connection between a client and a server. 
    * The client can be a Flash Player or AIR application. 
    * The server can be a web server, Flash Media Server, an application server running Flash Remoting, or the Adobe Stratus service. 
    * Call Connection.connect() to establish the connection. Use the NetStream class to send streams of media and data over the connection.
    */
   public class Connection extends NetConnection implements Action
    {
        /**
         * Creates a new Connection instance.
         */
        public function Connection()
        {
            addEventListener( AsyncErrorEvent.ASYNC_ERROR       , error  ) ;
            addEventListener( IOErrorEvent.IO_ERROR             , error  ) ;
            addEventListener( NetStatusEvent.NET_STATUS         , status ) ;
            addEventListener( SecurityErrorEvent.SECURITY_ERROR , error  ) ;
            
            _timer = new Timer( DEFAULT_DELAY , 1 ) ;
            
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE , timeout) ;
        }
        
        /**
         * The default internal timeout delay value in milliseconds.
         */
        public static const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
        
        /**
         * This signal emit when a packet encoded in an unidentified format.
         */
        public function get callBadVersion():Signaler
        {
            return _callBadVersion ;
        }
        
        /**
         * @private
         */
        public function set callBadVersion( signal:Signaler ):void
        {
            _callBadVersion = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the call method was not able to invoke the server-side method or command.
         */
        public function get callFailed():Signaler
        {
            return _callFailed ;
        }
        
        /**
         * @private
         */
        public function set callFailed( signal:Signaler ):void
        {
            _callFailed = signal || new Signal() ;
        }
        
        /**
         * This signal emit when an Action Message Format (AMF) operation is prevented for security reasons.
         */
        public function get callProhibited():Signaler
        {
            return _callProhibited ;
        }
        
        /**
         * @private
         */
        public function set callProhibited( signal:Signaler ):void
        {
            _callProhibited = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the specified application is shutting down.
         */
        public function get connectAppShutDown():Signaler
        {
            return _connectAppShutDown ;
        }
        
        /**
         * @private
         */
        public function set connectAppShutDown( signal:Signaler ):void
        {
            connectAppShutDown = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the connection was closed successfully.
         */
        public function get connectClosed():Signaler
        {
            return _connectClosed ;
        }
        
        /**
         * @private
         */
        public function set connectClosed( signal:Signaler ):void
        {
            _connectClosed = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the connection attempt failed.
         */
        public function get connectFailed():Signaler
        {
            return _connectFailed ;
        }
        
        /**
         * @private
         */
        public function set connectFailed( signal:Signaler ):void
        {
            _connectFailed = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the application name specified during connect is invalid.
         */
        public function get connectInvalidApp():Signaler
        {
            return _connectInvalidApp ;
        }
        
        /**
         * @private
         */
        public function set connectInvalidApp( signal:Signaler ):void
        {
            _connectInvalidApp = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the connection attempt did not have permission to access the application.
         */
        public function get connectRejected():Signaler
        {
            return _connectRejected ;
        }
        
        /**
         * @private
         */
        public function set connectRejected( signal:Signaler ):void
        {
            _connectRejected = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the Flash Player has detected a network change, for example, a dropped wireless connection, a successful wireless connection,or a network cable loss. 
         */
        public function get connectNetworkChange():Signaler
        {
            return _connectNetworkChange ;
        }
        
        /**
         * @private
         */
        public function set connectNetworkChange( signal:Signaler ):void
        {
            _connectNetworkChange = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the connection attempt succeeded.
         */
        public function get connectSuccess():Signaler
        {
            return _connectSuccess ;
        }
        
        /**
         * @private
         */
        public function set connectSuccess( signal:Signaler ):void
        {
            _connectSuccess = signal || new Signal() ;
        }
        
        /**
         * Indicates the timeout interval duration.
         */
        public function get delay():Number
        {
            return _timer.delay ;
        }
        
        /**
         * This signal emit when the notifyFinished method is invoked. 
         */
        public function get finishIt():Signaler
        {
            return _finishIt ;
        }
        
        /**
         * @private
         */
        public function set finishIt( signal:Signaler ):void
        {
            _finishIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyInfo method is invoked. 
         */
        public function get infoIt():Signaler
        {
            return _infoIt ;
        }
        
        /**
         * @private
         */
        public function set infoIt( signal:Signaler ):void
        {
            _infoIt = signal || new Signal() ;
        }
        
        /**
         * The current phase of the action.
         * @see system.process.TaskPhase
         */
        public function get phase():String
        {
            return _phase ;
        }
        
        /**
         * Indicates <code class="prettyprint">true</code> if the process is in progress.
         */
        public function get running():Boolean 
        {
            return _running ;
        }
        
        /**
         * This signal emit when the notifyStarted method is invoked. 
         */
        public function get startIt():Signaler
        {
            return _startIt || new Signal() ;
        }
        
        /**
         * @private
         */
        public function set startIt( signal:Signaler ):void
        {
            _startIt = signal ;
        }
        /**
         * Indicates the timeout policy of the connection (TimeoutPolicy.LIMIT or TimeoutPolicy.INFINITY)
         * @see system.process#TimeoutPolicy
         */
        public function get timeoutPolicy():TimeoutPolicy
        {
            return _policy ;
        }
        
        /**
         * @private
         */
        public function set timeoutPolicy( policy:TimeoutPolicy ):void 
        {
            _policy = policy ;
            if (_policy == TimeoutPolicy.LIMIT) 
            {
                _timer.addEventListener(TimerEvent.TIMER_COMPLETE, timeout) ;
            }
            else 
            {
                _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timeout) ;
            }
        }
        
        /**
         * The URI of the application server that was passed to NetConnection.connect(), if connect was used to connect to a server. 
         * If NetConnection.connect() hasn't yet been called or if no URI was passed, this property is undefined.
         * This property is a read-write property and we can use this property in to launch the connect process with the run method.
         * @see Runnable
         */
        public override function get uri():String
        {
            return _uri || super.uri ;
        }
        
        /**
         * @private
         */
        public function set uri( uri:String ):void
        {
            _uri = uri ;
        }
        
        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public function clone():*
        {
            return new Connection() ;
        }
        
        /**
         * Closes the connection that was opened locally or with the server and dispatches the netStatus event with a code property of NetConnection.Connect.Closed. 
         * @return A boolean to indicates if the connection is closed.
         */
        public override function close():void 
        {
            if ( _timer.running )
            {
                _timer.stop() ;
            }
            super.close() ;
        }
        
        /**
         * Connect the client with this method.
         */
        public override function connect( command:String, ...arguments:Array ):void
        {
            notifyStarted() ;
            _timer.start() ;
            super.connect.apply( this, [command].concat(arguments)) ;
        }
        
        /**
         * Notify when the connection is finished.
         */
        public function notifyFinished():void 
        {
            _running = false ;
            _phase = TaskPhase.FINISHED ;
            if ( hasEventListener( ActionEvent.FINISH ) )
            {
                dispatchEvent( new ActionEvent( ActionEvent.FINISH , this ) ) ;
            }
            _finishIt.emit() ;
            _phase = TaskPhase.INACTIVE ;
        }
        
        /**
         * Notify when the connection is started.
         */
        public function notifyStarted():void 
        {
            _running = true ;
            _phase  = TaskPhase.RUNNING ;
            _startIt.emit() ;
            if ( hasEventListener( ActionEvent.START ) )
            {
                dispatchEvent( new ActionEvent( ActionEvent.START , this ) ) ;
            }
        }
        
        /**
         * Notify a specific information when the process is changed.
         */
        public function notifyInfo( info:* ):void
        {
            _infoIt.emit( this , info ) ;
            if ( hasEventListener( ActionEvent.INFO ) )
            {
                dispatchEvent( new ActionEvent( ActionEvent.INFO , this , info ) ) ;
            }
        }
        
        /**
         * Notify when the connection is out of time.
         */
        public function notifyTimeOut():void
        {
            _phase  = TaskPhase.TIMEOUT ;
            _timeoutIt.emit( this ) ;
            if ( hasEventListener( ActionEvent.TIMEOUT ) )
            {
                dispatchEvent( new ActionEvent( ActionEvent.TIMEOUT , this ) ) ;
            }
        }
        
        /**
         * Registers an <code class="prettyprint">system.events.EventListener</code> object with an <code class="prettyprint">system.events.EventDispatcher</code> object so that the listener receives notification of an event.
         */
        public function registerEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
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
            addEventListener(type, func, useCapture, priority, useWeakReference) ;
        }
        
        /**
         * Runs the process.
         */
        public function run( ...arguments:Array ):void 
        {
            connect( uri ) ;
        }
        
        /**
         * Set timeout interval duration.
         */
        public function setDelay( delay:Number , useSeconds:Boolean ):void 
        {
            var t:Number = (delay > 0) ? delay : 0 ;
            if ( useSeconds ) 
            {
                t = Math.round(t * 1000) ;
            }
            _timer.delay = delay ;
        }
        
        /**
         * Removes an <code class="prettyprint">system.events.EventListener</code> from the <code class="prettyprint">system.events.EventDispatcher</code> object.
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
                func = (listener as EventListener).handleEvent ;
            }
            removeEventListener(type, func, useCapture) ;
        }
        
        ///////////////////////
        
        /**
         * @private
         */
        protected var _callBadVersion:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _callFailed:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _callProhibited:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _connectAppShutDown:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _connectClosed:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _connectFailed:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _connectInvalidApp:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _connectNetworkChange:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _connectRejected:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _connectSuccess:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _finishIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _infoIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _running:Boolean ;
        
        /**
         * @private
         */
        protected var _phase:String = TaskPhase.INACTIVE ;
        
        /**
         * @private
         */
        protected var _startIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _timeoutIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _uri:String ;
        
        /**
         * @private
         */
        protected function error( e:ErrorEvent ):void
        {
            _timer.stop() ;
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * Changes the running property value.
         */
        protected function setRunning( b:Boolean ):void
        {
            _running = b ;
        }
        
        /**
         * @private
         */
        protected function status( e:NetStatusEvent ):void
        {
            var info:Object = e.info ;
            var code:String = info.code ;
            
            if ( _timer.running )
            {
                _timer.stop() ;
            }
            
            switch ( code )
            {
                case ConnectionCode.CALL_BAD_VERSION :
                {
                    _callBadVersion.emit( this , info ) ;
                    break ;
                }
                case ConnectionCode.CALL_FAILED :
                {
                    _callFailed.emit( this , info ) ;
                   break ;
                }
                case ConnectionCode.CALL_PROHIBITED :
                {
                    _callProhibited.emit( this , info ) ;
                   break ;
                }
                case ConnectionCode.CONNECT_CLOSED :
                {
                   _connectClosed.emit( this , info ) ;
                   break ;
                }
                case ConnectionCode.CONNECT_FAILED :
                {
                    _connectFailed.emit( this , info ) ;
                    break ;
                }
                case ConnectionCode.CONNECT_INVALID_APP :
                {
                    _connectInvalidApp.emit( this , info ) ;
                   break ;
                }
                case ConnectionCode.CONNECT_NETWORK_CHANGE :
                {
                    _connectNetworkChange.emit( this, info ) ;
                    break ;
                }
                case ConnectionCode.CONNECT_REJECTED :
                {
                   _connectRejected.emit( this , info ) ;
                   break ;
                }
                case ConnectionCode.CONNECT_SHUTDOWN :
                {
                    _connectAppShutDown.emit( this , info ) ;
                   break ;
                }
                case ConnectionCode.CONNECT_SUCCESS :
                {
                   _connectSuccess.emit( this , info ) ;
                   break ;
                }
            }
            
            notifyInfo( info ) ;
            
            if ( running )
            {
                switch ( code )
                {
                    case ConnectionCode.CONNECT_CLOSED :
                    case ConnectionCode.CONNECT_FAILED :
                    case ConnectionCode.CONNECT_REJECTED :
                    case ConnectionCode.CONNECT_SUCCESS :
                    {
                       notifyFinished() ;
                       break ;
                    }
                }
            }
        }
        
        /**
         * @private
         */
        protected function timeout( e:TimerEvent ):void 
        {
            if ( _timer.running )
            {
                _timer.stop() ;
            }
            notifyTimeOut() ;
            if ( connected )
            {
                close() ;
            }
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        ///////////////////////
        
        /**
         * @private
         */
        private var _policy:TimeoutPolicy = TimeoutPolicy.INFINITY ;
        
        /**
         * @private
         */
        private var _timer:Timer ;
    }
}