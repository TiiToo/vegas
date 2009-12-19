/*

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
package vegas.net.remoting
{
    import system.Cloneable;
    import system.Reflection;
    import system.process.CoreAction;
    import system.process.TimeoutPolicy;
    
    import vegas.events.RemotingEvent;
    import vegas.ioc.ObjectScope;
    
    import flash.errors.IllegalOperationError;
    import flash.events.TimerEvent;
    import flash.net.ObjectEncoding;
    import flash.net.Responder;
    import flash.net.registerClassAlias;
    import flash.utils.Timer;
    
    /**
     * This class provides a service object to communicate with a remoting gateway server.
     * <p><b>Example : RemotingService and classmapping</b></p>
     * <p>Value object : test.User :</p>
     * <pre class="prettyprint">
     * package test
     * {
     *     import flash.net.registerClassAlias ;
     *  
     *     public class User
     *     {
     *          
     *         public function User( init:Object = null )
     *         {
     *             if (init != null)
     *             {
     *                 this.name = init.name ;
     *                 this.age  = init.age ;
     *                 this.url  = init.url ;
     *             }
     *         }
     *          
     *         public var age:uint ;
     *         public var name:String ;
     *         public var url:String ;
     *          
     *         public static function register():void
     *         {
     *             registerClassAlias("test.User", User) ;
     *         }
     *          
     *         public function toString():String
     *         {
     *             return "[User name:" + name + ", age:" + this.age + ", url:" + this.url + "]"  ;
     *         }
     *         
     *     }
     * }
     * </pre>
     * <p>TestRemotingService :</p>
     * <pre class="prettyprint">
     * package
     * {
     * 
     *     import system.events.ActionEvent;
     *     import vegas.events.RemotingEvent;
     *     import vegas.net.remoting.RemotingService;
     *     import flash.display.Sprite;
     *     
     *     import test.User;
     *      
     *     public class TestRemotingService extends Sprite
     *     {
     *         public function TestRemotingService()
     *         {
     *              
     *              User.register() ; // register the User class for class mapping
     *              
     *              var service:RemotingService = new RemotingService() ;
     *              
     *              service.addEventListener( RemotingEvent.ERROR  , onError    ) ;
     *              service.addEventListener( RemotingEvent.FAULT  , onFault    ) ;
     *              service.addEventListener( ActionEvent.FINISH   , onFinish   ) ;
     *              service.addEventListener( ActionEvent.PROGRESS , onProgress ) ;
     *              service.addEventListener( RemotingEvent.RESULT , onResult   ) ;
     *              service.addEventListener( ActionEvent.START    , onStart    ) ;
     *              service.addEventListener( ActionEvent.TIMEOUT  , onTimeOut  ) ;
     *              
     *              service.gatewayUrl  = "http://localhost/work/vegas/php/gateway.php" ;
     *              service.serviceName = "Test" ;
     *              service.methodName  = "getUser" ;
     *              service.params      = ["eka", 31, "http://www.ekameleon.net"] ;
     *              
     *              service.trigger() ;
     *         }
     *         
     *         public function onError(e:RemotingEvent):void
     *         {
     *             trace("> " + e.type + " : " + e.code) ;
     *         }
     *          
     *         public function onFinish(e:ActionEvent):void
     *         {
     *              trace("> " + e.type) ;
     *         }
     *          
     *         public function onFault(e:RemotingEvent):void
     *         {
     *              trace("> " + e.type + " : " + e.getCode() + " :: " + e.getDescription()) ;
     *         }
     *         
     *         public function onProgress(e:ActionEvent):void
     *         {
     *             trace("> " + e.type ) ;
     *         }
     *         
     *         public function onResult( e:RemotingEvent ):void
     *         {
     *              trace("-----------") ;
     *              trace("> result : " + e.result) ;
     *              trace("-----------") ;
     *         }
     *          
     *         public function onStart(e:ActionEvent):void
     *         {
     *             trace("> " + e.type ) ;
     *         }
     *          
     *         public function onTimeOut(e:ActionEvent):void
     *         {
     *             trace("> " + e.type ) ;
     *         }
     *     }
     * }
     * </pre>
     * <p>The PHP AMFPHP service to test the RemotingService class :</p>
     * <pre class="prettyprint">
     * &lt;?php
     * require("test/User.php") ;
     * 
     * class Test 
     * {
     * 
     *     // constructor
     * 
     *     function Test ()
     *     {
     * 
     *          $this->methodTable = array
     *          (
     *               "getUser" => array
     *               (
     *                   "description" => "Returns a user instance (value object with class mapping).",
     *                   "access"      => "remote",
     *                   "returns"     => "test.User",
     *                   "roles"       => "admin"
     *               )
     *          ) ;
     *    }
     *
     *    function getUser( $name, $age, $url )
     *    {
     *        return new User( $name, $age, $url ) ;
     *    }
     *    
     *    function _authenticate( $user, $pass ) 
     *    {
     *        if ($user == "vegas" && $pass == "vegas")
     *        {
     *             return "admin" ;
     *        }
     *        else
     *        {
     *             return false ;
     *        }
     *    }
     * }
     * ?&gt;
     * </pre>
      */
    public class RemotingService extends CoreAction implements Cloneable
    {
        /**
         * Creates a new RemotingService instance.
         * @param gatewayUrl the url of the gateway of the remoting service.
         * @param serviceName the name of the service in the server.
         * @param responder (optional) The RemotingServiceResponder use to receive data from the server.
         * @param global (optional) The flag to use a global event flow or a local event flow.
         * @param channel (optional) The name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function RemotingService( gatewayUrl:String=null , serviceName:String=null , responder:Responder=null , global:Boolean = false , channel:String = null )
        {
            super( global, channel );
            this._proxy        = new RemotingServiceProxy( this ) ;
            this._timer        = new Timer( DEFAULT_DELAY, 1 ) ;
            this.gatewayUrl    = gatewayUrl  ;
            this.serviceName   = serviceName ;
            this.responder     = responder   ;
            this.timeoutPolicy = TimeoutPolicy.LIMIT ;
        }
        
        /**
         * The default delay value before notify the timeout event.
         */
        public static const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
        
        /**
         * The string representation value of the level error of the service.
         */
        public static const LEVEL_ERROR:String = "error" ;
        
        /**
         * Indicates the timeout interval duration (default 8000 ms).
         * <p>Uses the setDelay() method to change this value.</p>
         */
        public function get delay():uint
        {
            return _timer.delay ;
        }
        
        /**
         * Indicates a string containing a dot delimited path from the root of the Flash Remoting Server to the service name. 
         */
        public function get gatewayUrl():String 
        { 
            return _gatewayUrl ;
        }
        
        /**
         * @private
         */
        public function set gatewayUrl( url:String ):void 
        { 
            _gatewayUrl = url ;
        }
        
        /**
         * Defines the <code class="prettyprint">IRemotingService</code> reference of this remoting service.
         */
        public function get listener():IRemotingServiceListener
        {
            return _listener ;
        }
        
        /**
         * @private
         */
        public function set listener( listener:IRemotingServiceListener ):void
        {
            if ( _listener != null )
            {
                _listener.unregisterService() ;
            }
            _listener = listener ;
            if ( _listener != null )
            {
                _listener.registerService(this) ;
            }
        }
        
        /**
         * Indicates the name of the server-side service's method.
         */
        public function get methodName():String 
        { 
            return _methodName ;
        }
        
        /**
         * @private
         */
        public function set methodName( name:String ):void 
        { 
            _methodName = name ;
        }
        
        /**
         * Defines if the service can lauch multiple simultaneous connections.
         */
        public var multipleSimultaneousAllowed:Boolean ;
        
        /**
         * The object encoding (AMF version) for the internal NetConnection instance.
         */
        public var objectEncoding:uint = ObjectEncoding.AMF3 ;
        
        /**
         * Determinates the Array representation of all arguments to pass in the service method.
         */
        public function get params():Array 
        { 
            return _args ;
        }
        
        /**
         * @private
         */
        public function set params( args:Array ):void 
        { 
            _args = args || [] ;
        }
        
        /**
         * Determinates a RemotingServiceProxy of the current service to use simple methods to run remoting queries.
         */
        public function get proxy():RemotingServiceProxy
        {
            return _proxy ;
        }
        
        /**
         * Indicates the Responder reference of the instance. 
         * <p>The responder can't be null, by default the service use an internal Responder with the IAction strategy.</p>
         */
        public function get responder():Responder
        {
            return _responder ;
        }
        
        /**
         * @private
         */
        public function set responder( responder:Responder ):void 
        {
            _responder = (responder == null) ?  _internalResponder : responder ;
        }
        
        /**
         * The scope of this object ("prototype" or "singleton")
         * @see vegas.ioc.ObjectScope
         */
        public function get scope():String
        {
            return _scope ;
        }
        
        /**
         * @private
         */
        public function set scope( value:String ):void
        {
            _scope = ObjectScope.validate(value) ? value : ObjectScope.SINGLETON ;
        }
        
        /**
         * Indicates the name of the server-side service.
         */
        public function get serviceName():String 
        { 
            return _serviceName ;
        }
        
        /**
         * @private
         */
        public function set serviceName( name:String ):void 
        { 
            _serviceName = name ;
        }
        
        /**
         * Indicates the timeout policy value of this service. Use limit timeout interval.
         * @see TimeoutPolicy
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
                _timer.addEventListener(TimerEvent.TIMER_COMPLETE, _timeout) ;
            }
            else
            {
                _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _timeout) ;
            }
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new RemotingService( gatewayUrl , serviceName ) ;
        }
        
        /**
         * Returns the internal RemotingConnection reference.
         * @return the internal RemotingConnection reference.
         */
        public function getConnection():RemotingConnection 
        {
            return _scope == ObjectScope.SINGLETON ? RemotingConnection.getConnection( _gatewayUrl ) : new RemotingConnection( _gatewayUrl ) ;    
        }
        
        /**
         * Returns the result value returns by the server after a trigger process.
         * @return the result value returns by the server.
         */
        public function getResult():*
        {
            return _result ;
        }
        
        /**
         * Notify a RemotingEvent 'error event'.
         */
        protected function notifyError( code:String = null ):void 
        {
            setRunning(false) ;
            var e:RemotingEvent = new RemotingEvent( _sTypeError , this ) ;
            e.code = (code == null) ? RemotingEvent.ERROR : code ;
            dispatchEvent( e ) ;
            notifyFinished() ;
        }
        
        /**
         * Notify a RemotingEvent 'fault event'.
         */
        protected function notifyFault( fault:Object = null ):void
        {
            var e:RemotingEvent = new RemotingEvent( _sTypeFault , this ) ;
            e.setFault(fault, _methodName) ;
            dispatchEvent( e ) ;
        }
        
        /**
         * Notify a RemotingEvent 'result event'.
         */
        protected function notifyResult():void
        {
            var e:RemotingEvent = new RemotingEvent( _sTypeResult , this ) ;
            e.setResult(_result , _methodName) ;
            dispatchEvent( e ) ;
        }
        
        /**
         * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF).
         */
        public static function registerClassAlias( classObject:Class, aliasName:String=null  ):void
        {
            if (aliasName == null)
            {
                aliasName = Reflection.getClassName( classObject ) ;
            }
            flash.net.registerClassAlias(aliasName, classObject) ; 
        }
        
        /**
         * Run the process of the remoting service.
         */
        public override function run(...arguments:Array):void 
        {
            if ( arguments.length > 0 )
            {
               this.params = [].concat( arguments ) ;   
            }
            var rc:RemotingConnection = getConnection() as RemotingConnection ;
            if ( rc == null )
            {
                throw new IllegalOperationError(this + ", You can't run the service with a null internal RemotingConnection reference.") ;
            }
            rc.objectEncoding = objectEncoding ;
            if ( rc.connected == false)
            {
                rc.connect( gatewayUrl ) ;
            }
            
            if ( _authentification != null )
            {
                rc.setCredentials( _authentification ) ;
            }
            if ( running && multipleSimultaneousAllowed == false )
            {
                notifyProgress() ;
            }
            else 
            {
                notifyStarted() ;
                _result = null ;
                var params:Array = [ _serviceName + "." + _methodName , responder ] ;
                if (_args != null && _args.length > 0)
                {
                    params = params.concat( _args ) ;
                }
                _timer.start() ;
                rc.call.apply( rc, params ) ;
            } 
        }
        
        /**
         * Defines a set of credentials to be presented to the server on all subsequent requests.
         * @param authentification The RemotingAuthentification instance to presented to the server.
         * @see RemotingAuthentification
         */
        public function setCredentials( authentification:RemotingAuthentification = null ):void  
        {
            _authentification = authentification ;
        }
        
        /**
         * Set timeout interval duration.
         * @param time the delay value of the timeout event notification.
         * @param useSeconds Indicates if the time value is in seconds <code class="prettyprint">true</code> or milliseconds <code class="prettyprint">false</code>.
         */
        public function setDelay( time:uint , useSeconds:Boolean=false):void 
        {
            if (useSeconds) time = Math.round(time * 1000) ;
            _timer.delay = time ;
        }
        
        /**
         * Triggers the process to launch the method of the current service server side.
         */
        public function trigger():void 
        {
            run() ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public function toString():String 
        {
            return _formatter.format(this) ;
        }
        
        /**
         * @private
         */
        private var _args:Array ;
        
        /**
         * @private
         */
        private var _authentification:RemotingAuthentification ;
        
        /**
         * @private
         */
        private static var _formatter:RemotingServiceFormatter = new RemotingServiceFormatter() ;
        
        /**
         * @private
         */
        private var _gatewayUrl:String ;
        
        /**
         * @private
         */
        private var _internalResponder:Responder = new Responder(_response, _status) ;
        
        /**
         * @private
         */
        private var _listener:IRemotingServiceListener ;
        
        /**
         * @private
         */
        private var _methodName:String ; 
        
        /**
         * @private
         */
        private var _policy:TimeoutPolicy ;
        
        /**
         * @private
         */
        private var _proxy:RemotingServiceProxy ;
        
        /**
         * @private
         */
        private var _responder:Responder ;
        
        /**
         * @private
         */
        private var _result:* = null ;
        
        /**
         * @private 
         */
        private var _scope:String = ObjectScope.PROTOTYPE ;
        
        /**
         * @private
         */
        private var _serviceName:String ;
        
        /**
         * @private
         */
        protected var _sTypeError:String = RemotingEvent.ERROR ;
        
        /**
         * @private
         */
        protected var _sTypeFault:String = RemotingEvent.FAULT ;
        
        /**
         * @private
         */
        protected var _sTypeResult:String = RemotingEvent.RESULT ;
        
        /**
         * @private
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private function _response( data:* ):void
        {
            _timer.stop() ; // stop timeout interval
            _result = data ;
            notifyResult() ;
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        private function _status( fault:Object ):void 
        {
            _timer.stop() ; // stop timeout interval
            notifyFault(fault) ;
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        private function _timeout(e:TimerEvent):void 
        {
            _timer.stop() ;
            if ( _scope == ObjectScope.SINGLETON && getConnection() != null )
            {
                getConnection().close() ;
            }
            notifyTimeOut() ;
            notifyFinished() ;
        }
    }
}