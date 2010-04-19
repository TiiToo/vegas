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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
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
    import system.Cloneable;
    import system.events.ActionEvent;
    import system.events.CoreEventDispatcher;
    import system.process.Action;
    import system.process.TimeoutPolicy;
    import system.signals.Signal;
    import system.signals.Signaler;

    import vegas.events.NetServerEvent;

    import flash.events.AsyncErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.NetConnection;
    import flash.net.Responder;
    import flash.utils.Timer;

    /**
     * This class extends the NetConnection class and defined an implementation based on VEGAS to used Flash Remoting or Flash MediaServer (with AMF protocol).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     *
     * import vegas.events.NetServerEvent ;
     * import vegas.net.NetServerConnection ;
     * 
     * import flash.events.Event ;
     * 
     * var status:Function = function( e:NetStatusEvent ):void
     * {
     *     trace("status " + e ) ;
     *     var info:Object = e.info ;
     *     for (var prop:String in info)
     *     {
     *         trace(prop + " : " + info[prop]) ;
     *     }
     *     trace("----") ;
     * }
     * 
     * var accept:Function = function( e:NetServerEvent ):void
     * {
     *     trace("accept " + e.info ) ;
     *     trace("----") ;
     * }
     * 
     * var reject:Function = function( e:NetServerEvent ):void
     * {
     *     trace("reject " + e.info ) ;
     *     trace("----") ;
     * }
     * 
     * var debug:Function = function( e:Event ):void
     * {
     *     trace("debug " + e) ;
     * }
     * 
     * var nc:NetServerConnection = new NetServerConnection() ;
     * 
     * nc.addEventListener(ActionEvent.FINISH        , debug  ) ;
     * nc.addEventListener(ActionEvent.START         , debug  ) ;
     * nc.addEventListener(NetServerEvent.ACCEPT     , accept ) ;
     * nc.addEventListener(NetServerEvent.REJECT     , reject ) ;
     * nc.addEventListener(NetStatusEvent.NET_STATUS , status ) ;
     * 
     * nc.objectEncoding = ObjectEncoding.AMF0 ;
     * 
     * nc.connect("rtmp://localhost/yourapplication") ; // The RTMP application server
     * </pre>
     */    
    public dynamic class NetServerConnection extends CoreEventDispatcher implements Action, Cloneable
    {
        /**
         * Creates a new NetServerConnection instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function NetServerConnection( global:Boolean = false , channel:String = null )
        {
            super( global , channel ) ;
            
            _nc        = new NetConnection() ;
            _nc.client = this ;
            
            _nc.addEventListener( AsyncErrorEvent.ASYNC_ERROR       , _onAsyncError    ) ;
            _nc.addEventListener( IOErrorEvent.IO_ERROR             , _onIOError       ) ;
            _nc.addEventListener( NetStatusEvent.NET_STATUS         , _onStatus        ) ;
            _nc.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _onSecurityError ) ;
            
            _timer = new Timer( DEFAULT_DELAY, 1 ) ;
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE , _onTimeOut) ;
        }
        
        /**
         * The default internal timeout delay value in milliseconds.
         */
        public static const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
        
        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public function get client():Object
        {
            return _nc.client ;
        }
        
        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public function set client( client:Object ):void
        {
           _nc.client = client ;
        }
       
        /**
         * [read-only] Indicates whether Flash Player has connected to a server through a persistent RTMP connection (true) or not (false). 
         * When connected through HTTP, this property is always false. 
         * It is always true for AMF connections to application servers. 
         */
        public function get connected():Boolean
        {
            return _nc.connected ;
        }
        
        /**
         * [read-only] Indicates whether Flash Player has connected to a server through a persistent RTMP connection (true) or not (false). 
         * When connected through HTTP, this property is always false. 
         * It is always true for AMF connections to application servers. 
         */
        public function get connectedProxyType():String
        {
            return _nc.connectedProxyType ;
        }
        
        /**
         * Indicates the internal NetConnection reference of this object.
         */
        public function get connection():NetConnection
        {
            return _nc ;
        }
        
        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public static function get defaultObjectEncoding():uint
        {
            return NetConnection.defaultObjectEncoding ;
        }
        
        /**
         * The default object encoding (AMF version) for NetConnection objects created in the SWF file. 
         * When an object is written to or read from binary data, the defaultObjectEncoding property indicates which Action Message Format version should be used: the ActionScript 3.0 format or the ActionScript 1.0 and ActionScript 2.0 format. 
         */
        public static function set defaultObjectEncoding( encoding:uint ):void
        {
           NetConnection.defaultObjectEncoding = encoding ;
        }
        
        /**
         * The identifier of the Flash Media Server instance to which this Flash Player or Adobe AIR instance is connected.
         */
        public function get farID():String
        {
            return _nc["farID"] as String ;
        }
        
        /**
         * A value chosen substantially by Flash Media Server, unique to this connection.
         */
        public function get farNonce():String
        {
            return _nc["farNonce"] as String ;
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
         * The total number of inbound and outbound peer connections that this instance of Flash Player or Adobe AIR allows.
         */
        public function get maxPeerConnections():uint
        {
            return _nc["maxPeerConnections"] as uint ;
        }
        
        /**
         * @private
         */
        public function set maxPeerConnections( value:uint ):void
        {
            _nc["maxPeerConnections"] = value ;
        }
        
        /**
         * The identifier of this Flash Player or Adobe AIR instance for this NetConnection instance.
         */
        public function get nearID():String
        {
            return _nc["nearID"] as String ;
        }
        
        /**
         * A value chosen substantially by this Flash Player or Adobe AIR instance, unique to this connection.
         */
        public function get nearNonce():String
        {
            return _nc["nearNonce"] as String ;
        }
        
        /**
         * The ObjectEncoding class allows classes that serialize objects (such as FileStream, NetStream, NetConnection, SharedObject, and ByteArray) to work with prior versions of ActionScript.
         */
        public function get objectEncoding():uint
        {
            return _nc.objectEncoding ;
        }
        
        /**
         * @private
         */
        public function set objectEncoding( encoding:uint ):void
        {
            _nc.objectEncoding = encoding ;
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
            return _isRunning ;
        }
        
        /**
         * Indicates the protocol used to establish the connection.
         */
        public function get protocol():String
        {
            return _nc["protocol"] as String ;
        }
        
        /**
         * Determines whether native SSL is used for RTMPS instead of HTTPS, and whether the CONNECT method of tunneling is used to connect through a proxy server. 
         * Acceptable values are "none", "HTTP", "CONNECT", and "best". This property is used in Flex applications and Flash Media Server 2 applications. 
         */
        public function get proxyType():String
        {
            return _nc.proxyType ;
        }
        
        /**
         * @private 
         */
        public function set proxyType( type:String ):void
        {
            _nc.proxyType = type ;
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
         * An object that holds all of the peer subscriber NetStream objects that are not associated with publishing NetStream objects.
         */
        public function get unconnectedPeerStreams():Array
        {
            return _nc["unconnectedPeerStreams"] as Array ;
        } 
        
        /**
         * The URI of the application server that was passed to NetConnection.connect(), if connect was used to connect to a server. 
         * If NetConnection.connect() hasn't yet been called or if no URI was passed, this property is undefined.
         * This property is a read-write property and we can use this property in to launch the connect process with the run method.
         * @see Runnable
         */
        public function get uri():String
        {
            return _uri || _nc.uri ;
        }
        
        /**
         * @private
         */
        public function set uri( uri:String ):void
        {
            _uri = uri ;
        }
        
        /**
         * Indicates whether a secure connection was made using native Transport Layer Security (TLS) rather than HTTPS. 
         * This property is valid only when a NetConnection object is connected. 
         */
        public function get usingTLS():Boolean
        {
            return _nc.usingTLS ;
        }
        
        /**
         * Adds a context header to the AMF packet structure. This header is sent with every future AMF packet.
         * @param operation A string; identifies the header and the ActionScript object data associated with it.
         * @param mustUnderstand A Boolean value; true indicates that the server must understand and process this header before it handles any of the following headers or messages.
         * @param param Any ActionScript object.
         */
        public function addHeader( operation:String , mustUnderstand:Boolean = false , param:Object = null ):void
        {
            _nc.addHeader( operation , mustUnderstand , param ) ;
        }
        
        /**
         * Invokes a command or method on the server running Flash Media Server, or on an application server, to which the application instance is connected. You must create a server-side function to pass to this method.
         * @param command A method specified in the form [objectPath/]method.
         * @param responder An optional object that is used to handle return values from the server. 
         * @param ... arguments Optional arguments that can be of any ActionScript type, including a reference to another ActionScript object. 
         * These arguments are passed to the method specified in the command parameter when the method is executed on the remote application server.
         * @return For RTMP connections, returns a Boolean value of true if a call to methodName is sent to the client ; otherwise, false. 
         * For application server connections, it always returns true.
         */
        public function call( command:String, responder:Responder , ...rest:Array  ):Boolean 
        {
            return _nc.call.apply( _nc, [ command, responder ].concat( rest) ) ;
        }
        
        /**
         * Returns the shallow copy of this object.
          * @return the shallow copy of this object.
         */
        public function clone():*
        {
            return new NetServerConnection() ;
        }
        
        /**
         * Closes the connection that was opened locally or with the server and dispatches the netStatus event with a code property of NetConnection.Connect.Closed. 
         * @return A boolean to indicates if the connection is closed.
         */        
        public function close( noEvent:Boolean = false ):Boolean 
        {
            _timer.stop() ;
            if ( _nc.connected )
            {
                _nc.close() ;
                return true ;
            }
            return false ;
        }
        
        /**
         * Connect the client with this method.
         */
        public function connect( command:String, ...arguments:Array ):void
        {
            notifyStarted() ;
            _timer.start() ;
            _nc.connect.apply( _nc, [command].concat(arguments)) ;
        }
        
        /**
         * Returns timeout interval duration.
         */
        public function getDelay():uint
        {
            return _timer.delay ;
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
         * Invoked when the connection is finished.
         */
        public function notifyFinished():void 
        {
            setRunning( false ) ;
            if ( hasEventListener( ActionEvent.FINISH ) )
            {
                dispatchEvent( new ActionEvent( ActionEvent.FINISH , this ) ) ;
            }
            _finishIt.emit() ;
        }
        
        /**
         * Invoked when the connection is closed.
         */
        protected function notifyNetServerEvent( type:String , status:NetServerStatus = null , info:* = null ):void 
        {
            dispatchEvent( new NetServerEvent( type , this , status , info ) ) ;
        }
        
        /**
         * Invoked when the connection is started.
         */
        public function notifyStarted():void 
        {
            setRunning( true ) ;
            _startIt.emit() ;
            if ( hasEventListener( ActionEvent.START ) )
            {
                dispatchEvent( new ActionEvent( ActionEvent.START , this ) ) ;
            }
        }
        
        /**
         * Invoked when the connection is timeout.
         */
        protected function notifyTimeOut():void
        {
            dispatchEvent( new ActionEvent( ActionEvent.TIMEOUT, this) ) ;
        }
        
        /**
         * Runs the process of this NetServerConnection.
         */
        public function run( ...arguments:Array ):void 
        {
            connect( _nc.uri ) ;
        }
        
        /**
         * Set timeout interval duration.
         */
        public function setDelay(n:Number, useSeconds:Boolean):void 
        {
            var t:Number = (n > 0) ? n : 0 ;
            if (useSeconds) 
            {
                t = Math.round(t * 1000) ;
            }
            _timer.delay = t ;
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
         * Changes the running property value.
         */
        protected function setRunning( b:Boolean ):void
        {
            _isRunning = b ;
        }
        
        /**
         * Use this method to dispatch in FMS application an event.
         */
        public function sharedEvent( event:* = null , context:* = null ):void 
        {
            if (event is Event) 
            {
                _nc.call( (event as Event).type, null, event ) ;
            }
            else if ( event is String ) 
            {
                _nc.call( event, null, context ) ;
            }
        }
        
        /**
         * @private
         */
        private var _finishIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        private var _nc:NetConnection ;
        
        /**
         * @private
         */
        private var _isRunning:Boolean ;
        
        /**
         * @private
         */
        protected var _phase:String = TaskPhase.INACTIVE ;
        
        /**
         * @private
         */
        private var _policy:TimeoutPolicy ;
        
        /**
         * @private
         */
        private var _startIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private var _uri:String ;
            
        /**
         * @private
         */
        protected function _onAsyncError(e:AsyncErrorEvent):void
        {
            _timer.stop() ;
            dispatchEvent(e) ;
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        protected function _onIOError(e:IOErrorEvent):void
        {
            _timer.stop() ;
            dispatchEvent(e) ;
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        protected function _onSecurityError(e:SecurityErrorEvent):void
        {
            _timer.stop() ;
            dispatchEvent(e) ;
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        private function _onStatus( e:NetStatusEvent ):void
        {
            var info:Object = e.info ;
            var code:String = info.code ;
            var status:NetServerStatus = NetServerStatus.get( code ) ;
            _timer.stop() ;
            dispatchEvent( e ) ;
            switch ( code )
            {
                case NetServerStatus.CONNECT_CLOSED.code :
                {
                   notifyNetServerEvent( NetServerEvent.CLOSE, status, e.info ) ;
                   break ;
                }
                case NetServerStatus.CONNECT_REJECTED.code :
                {
                   notifyNetServerEvent( NetServerEvent.REJECT, status , e.info ) ;
                   break ;
                }
                case NetServerStatus.CONNECT_SUCCESS.code :
                {
                   notifyNetServerEvent( NetServerEvent.ACCEPT, status , e.info ) ;
                   break ;
                }
            }
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        protected function _onTimeOut(e:TimerEvent):void 
        {
            this._timer.stop() ;
            this.notifyTimeOut() ;
            if ( this.connected )
            {
                this.close() ;
            }
            if ( running )
            {
                notifyFinished() ;
            }
        }
    }
}