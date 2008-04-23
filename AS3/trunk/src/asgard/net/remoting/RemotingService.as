/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard AS3 Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net.remoting
{
	import flash.events.TimerEvent;
	import flash.net.ObjectEncoding;
	import flash.net.registerClassAlias;
	import flash.net.Responder;
	import flash.utils.Timer;
	
	import andromeda.process.Action;
	
	import asgard.events.RemotingEvent;
	import asgard.net.TimeoutPolicy;
	
	import system.Reflection;
	
	import vegas.core.ICloneable;
	import vegas.errors.Warning;	

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
	 *     import andromeda.events.ActionEvent;
	 *     import asgard.events.RemotingEvent;
	 *     import asgard.net.remoting.RemotingService;
	 *     import flash.display.Sprite;
	 *     
	 *     import test.User;
	 * 
	 *     public class TestRemotingService extends Sprite
	 *     {
	 * 
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
	 *              service.gatewayUrl = "http://localhost/work/vegas/php/gateway.php" ;
	 *              service.serviceName = "Test" ;
	 *              service.methodName = "getUser" ;
	 *              service.params = ["eka", 30, "http://www.ekameleon.net"] ;
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
	 * 
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
	 * @author eKameleon
 	 */
	public class RemotingService extends Action implements ICloneable
	{
		
		/**
		 * Creates a new RemotingService instance.
	 	 * @param gatewayUrl the url of the gateway of the remoting service.
		 * @param serviceName the name of the service in the server.
	 	 * @param responder (optional) The RemotingServiceResponder use to receive data from the server.
	 	 * @param bGlobal (optional) The flag to use a global event flow or a local event flow.
	     * @param sChannel (optional) The name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function RemotingService( gatewayUrl:String=null , serviceName:String=null , responder:Responder=null , bGlobal:Boolean = false , sChannel:String = null )
		{
			
			super( bGlobal, sChannel );
			
			setGatewayUrl( gatewayUrl );
			setServiceName( serviceName ) ;
			setResponder( responder ) ;
		
			_timer = new Timer(DEFAULT_DELAY, 1) ;
			setTimeoutPolicy(TimeoutPolicy.LIMIT) ;
			
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
	     * Returns a string containing a dot delimited path from the root of the Flash Remoting Server to the service name. 
    	 * @return a string containing a dot delimited path from the root of the Flash Remoting Server to the service name.
    	 */
		public function get gatewayUrl():String 
		{ 
			return getGatewayUrl() ;
		}
	
		/**
	     * Sets a string containing a dot delimited path from the root of the Flash Remoting Server to the service name. 
	     */
		public function set gatewayUrl(sUrl:String):void 
		{ 
			setGatewayUrl(sUrl) ;
		}

	    /**
    	 * Returns the proxy policy boolean value of this RemotingService.
    	 * @return the proxy policy boolean value of this RemotingService.
    	 */
		public function get isProxy():Boolean 
		{ 
			return getIsProxy() ;
		}

        /**
	     * Sets the proxy policy boolean value of this RemotingService.
	     */
		public function set isProxy(b:Boolean):void 
		{ 
			setIsProxy(b) ;
		}
		
		/**
		 * The object encoding (AMF version) for the internal NetConnection instance.
		 */
		public var objectEncoding:uint = ObjectEncoding.AMF0 ;

	    /**
    	 * Returns the Array representation of all arguments to pass in the service method.
    	 * @return the Array representation of all arguments to pass in the service method.
    	 */
		public function get params():Array 
		{ 
			return getParams() ;
		}

	    /**
    	 * Sets the Array representation of all arguments to pass in the service method.
    	 */
		public function set params(ar:Array):void 
		{ 
			setParams(ar) ;	
		}

    	/**
    	 * Returns the name of the server-side service's method.
    	 * @return the name of the server-side service's method.
    	 */
		public function get methodName():String 
		{ 
			return getMethodName() ;	
		}

    	/**
    	 * Sets the name of the server-side service's method.
    	 */
		public function set methodName(sName:String):void 
		{ 
			setMethodName(sName) ;
		}

    	/**
    	 * Defines if the service can lauch multiple simultaneous connections.
    	 */
		public var multipleSimultaneousAllowed:Boolean = false ;

    	/**
    	 * Returns the name of the server-side service.
    	 * @return the name of the server-side service.
    	 */
		public function get serviceName():String 
		{ 
			return getServiceName() ;	
		}

    	/**
    	 * Sets the name of the server-side service.
    	 */
		public function set serviceName(sName:String):void 
		{ 
			setServiceName(sName) ;
		}

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
		public override function clone():*
		{
			return new RemotingService( getGatewayUrl() , getServiceName() ) ;
		}
		
		/**
		 * Returns the internal RemotingConnection reference.
		 * @return the internal RemotingConnection reference.
		 */
		public function getConnection():RemotingConnection 
		{
			return _rc ;	
		}

    	/**
    	 * Returns the timeout interval duration.
    	 * @return the timeout interval duration.
    	 */
		public function getDelay():uint
		{
			return _timer.delay ;
		}

        /**
		 * Returns the event name use in the notifyError method.
		 * @return the event name use in the notifyError method.
		 */
		public function getEventTypeERROR():String
		{
			return _sTypeError ;
		}

        /**
		 * Returns the event name use in the notifyFault method.
		 * @return the event name use in the notifyFault method.
		 */
		public function getEventTypeFAULT():String
		{
			return _sTypeFault ;
		}
        
        /**
		 * Returns the event name use in the notifyResult method.
		 * @return the event name use in the notifyResult method.
		 */
		public function getEventTypeRESULT():String
		{
			return _sTypeResult ;
		}

    	/**
    	 * Returns a string containing a dot delimited path from the root of the Flash Remoting Server to the service name. 
    	 * @return a string containing a dot delimited path from the root of the Flash Remoting Server to the service name.
    	 */
		public function getGatewayUrl():String 
		{
			return _gatewayUrl ;	
		}

    	/**
	     * Returns the proxy policy boolean value of this RemotingService.
    	 * @return the proxy policy boolean value of this RemotingService.
    	 */
		public function getIsProxy():Boolean 
		{
			return _isProxy ;	
		}

	    /**
	     * Returns the name of the server-side service's method.
	     * @return the name of the server-side service's method.
	     */
		public function getMethodName():String 
		{
			return _methodName ;
		}
        
    	/**
    	 * Returns the Array representation of all arguments to pass in the service method.
    	 * @return the Array representation of all arguments to pass in the service method.
    	 */
		public function getParams():Array 
		{
			return _args  ;	
		}
        
    	/**
    	 * Returns the RemotingServiceResponder reference of the instance.
    	 * @return the RemotingServiceResponder reference of the instance.
    	 */
		public function getResponder():Responder 
		{
			return _responder ;
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
    	 * Returns the name of the server-side service.
    	 * @return the name of the server-side service.
    	 */
		public function getServiceName():String
		{
			return _serviceName ;
		}
		
	    /**
         * Returns the timeout policy value of this service.
         * @return the timeout policy value of this service.
         * @see TimeoutPolicy
         */
		public function getTimeoutPolicy():TimeoutPolicy 
		{
			return _policy ;	
		}
		
        /**
         * Initialize the internal events of this process.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
			_sTypeError  = RemotingEvent.ERROR  ;
			_sTypeFault  = RemotingEvent.FAULT  ;
			_sTypeResult = RemotingEvent.RESULT ;
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
			
			_rc = RemotingConnection.getConnection( _gatewayUrl ) ;
			
			_rc.objectEncoding = objectEncoding ;
			
			if ( (_rc == null) && !(_rc is RemotingConnection) ) 
			{
				throw new Warning(this + ", You can't run the RemotingConnection.") ;
			}
			
			if (_authentification != null)
			{
				_rc.setCredentials(_authentification) ;
			}
			
			if (getRunning() && multipleSimultaneousAllowed == false)  
			{
				notifyProgress() ;
			}
			else 
			{
				notifyStarted() ;
				_result = null ;
				setRunning(true) ;	
				var args:Array = [_serviceName + "." + _methodName , getResponder()].concat(_args) ;
				_rc.call.apply( _rc, args );
				_timer.start() ;
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
		 * Sets the event name use in the notifyError method.
		 */
		public function setEventTypeERROR( type:String ):void
		{
			_sTypeError = type || RemotingEvent.ERROR ;
		}

        /**
		 * Sets the event name use in the notifyFault method.
		 */
		public function setEventTypeFAULT( type:String ):void
		{
			_sTypeFault = type || RemotingEvent.FAULT ;
		}
        
        /**
		 * Sets the event name use in the notifyResult method.
		 */
		public function setEventTypeRESULT( type:String ):void
		{
			_sTypeResult = type || RemotingEvent.RESULT ;
		}
		
		/**
	     * Sets a string containing a dot delimited path from the root of the Flash Remoting Server to the service name. 
	     */
		public function setGatewayUrl( url:String ):void 
		{
			_gatewayUrl = url ;
		}
		
		/**
    	 * Sets the proxy policy of this RemotingService. 
    	 * If the passed-in argument is <code class="prettyprint">true</code> the RemotingService instances uses proxy to resolve all methods.
	     */
		public function setIsProxy(b:Boolean):void 
		{
			_isProxy = b ;
		}

	    /**
    	 * Sets the Array representation of all arguments to pass in the service method.
    	 */
		public function setParams(args:Array):void 
		{
			_args = args ;	
		}

    	/**
	     * Sets the name of the server-side service's method.
    	 */
		public function setMethodName( sName:String ):void 
		{
			_methodName = sName ;	
		}

    	/**
    	 * Sets the RemotingServiceResponder reference of the instance.
	     */
		public function setResponder( responder:Responder=null ):void 
		{
			_responder = (responder == null) ?  _internalResponder : responder ;
		}
	    
    	/**
    	 * Sets the name of the server-side service.
    	 */
		public function setServiceName( sName:String ):void 
		{
			_serviceName = sName ;	
		}
		
		/**
		 * Use limit timeout interval.
		 * @see TimeoutPolicy
		 */
		public function setTimeoutPolicy( policy:TimeoutPolicy ):void 
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
		public override function toString():String 
		{
			return (new RemotingFormat()).formatToString(this) ;	
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
		private var _gatewayUrl:String = null  ;

		/**
		 * @private
		 */
		private var _internalResponder:Responder = new Responder(_onResult, _onStatus) ;
		
		/**
		 * @private
		 */
		private var _isProxy:Boolean = false ;
		
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
		private var _rc:RemotingConnection = null ;

		/**
		 * @private
		 */
		private var _responder:Responder = null ;
		
		/**
		 * @private
		 */
		private var _result:* = null ;
		
		/**
		 * @private
		 */
		private var _serviceName:String = null ;
		
		/**
		 * @private
		 */
		private var _sTypeError:String ;
        
		/**
		 * @private
		 */
        private var _sTypeFault:String ;

		/**
		 * @private
		 */
        private var _sTypeResult:String ;

		/**
		 * @private
		 */
		private var _timer:Timer ;
		
		/**
		 * @private
		 */
		private function _onResult( data:* ):void
		{
			_timer.stop() ; // stop timeout interval
			_result = data ;
			setRunning(false) ;
			notifyResult() ;
			notifyFinished() ;
		}

		/**
		 * @private
		 */
		private function _onStatus( fault:Object ):void 
		{
			_timer.stop() ; // stop timeout interval
			setRunning(false) ;
			notifyFault(fault) ;
			notifyFinished() ;
		}

		/**
		 * @private
		 */
		private function _onTimeOut(e:TimerEvent):void 
		{
			_timer.stop() ;
			setRunning(false) ;
			notifyTimeOut() ;
    		notifyFinished() ;
		}

	}
	
}