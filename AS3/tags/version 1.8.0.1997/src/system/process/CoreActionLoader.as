﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
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

package system.process 
{
    import system.URI;
    
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    
    /**
     * This core command object run a "loader" object and notify ActionEvent during a load process.
     */
    public class CoreActionLoader extends CoreAction
    {
        /**
         * Creates a new CoreActionLoader instance.
         * @param loader The loader reference.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function CoreActionLoader( loader:IEventDispatcher=null , global:Boolean = false, channel:String = null)
        {
            super( global, channel );
            _timer             = new Timer(DEFAULT_DELAY, 1) ;
            this.timeoutPolicy = TimeoutPolicy.LIMIT ;
            this.loader        = loader ;
        }
        
        /**
         * The name of the default cache uri query parameter ("random"). 
         * In the loader request you can set an other parameter name with the property <code>cacheParameterName</code>.
         */
        public static const DEFAULT_CACHE_PARAMETER:String = "random" ;
        
        /**
         * The default value of the delay before the ActionEvent.TIMEOUT event.
         */
        public static const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
        
        /**
         * Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public function get bytesLoaded():uint
        {
            return 0 ;
        }
        
        /**
         * Indicates the total number of bytes in the downloaded data.
         */
        public function get bytesTotal():uint
        {
            return 0 ;
        }
        
        /**
         * The cache flag of this resource (default is true).
         */
        public var cache:Boolean ;
        
        /**
         * The name of the uri query parameter when the cache attribute is true. By default the DEFAULT_CACHE_PARAMETER const is used.
         */
        public var cacheParameterName:String ;
        
        /**
         * Indicates the timeout interval duration.
         */
        public function get delay():uint
        {
            return _timer.delay ;
        }
        
        /**
         * Indicates the loader object of this process.
         */
        public function get loader():IEventDispatcher
        {
            return _loader ;
        }
        
        /**
         * @private
         */
        public function set loader( loader:IEventDispatcher ):void
        {
            unregister(_loader) ;
            _loader = loader ;
            register(_loader) ;
        }
        
        /**
         * Indicates the URLRequest object who captures all of the information in a single HTTP request.
         */
        public function get request():URLRequest
        {
            return _request ;
        }
        
        /**
         * @private
         */
        public function set request( request:URLRequest ):void
        {
            _request = request ;
        }
        
        /**
         * Indicates the timeout policy of the loader.
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
            if ( policy == TimeoutPolicy.LIMIT ) 
            {
                _policy = TimeoutPolicy.LIMIT ;
                _timer.addEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
            }
            else 
            {
                _policy = TimeoutPolicy.INFINITY ;
                _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
            }
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new CoreActionLoader(loader) ;
        }
        
        /**
         * Cancels a load() method operation that is currently in progress for the Loader instance.
         */
        public function close():void
        {
            notifyFinished() ;
        }
        
        /**
         * Notify an ActionEvent when the process is finished.
         */
        public override function notifyFinished():void 
        {
            _timer.stop() ;
            super.notifyFinished() ;
        }
        
        /**
         * Notify an ActionEvent when the process is started.
         */
        public override function notifyStarted():void
        {
            super.notifyStarted() ;
            _timer.start() ;
        }
        
        /**
         * Register the loader object.
         */
        public function register( dispatcher:IEventDispatcher ):void
        {
            if ( dispatcher != null )
            {
                dispatcher.addEventListener( Event.COMPLETE                    , complete      , false, 0, true ) ;
                dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS       , dispatchEvent , false, 0, true ) ;
                dispatcher.addEventListener( IOErrorEvent.IO_ERROR             , error         , false, 0, true ) ;
                dispatcher.addEventListener( Event.OPEN                        , dispatchEvent , false, 0, true ) ;
                dispatcher.addEventListener( ProgressEvent.PROGRESS            , dispatchEvent , false, 0, true ) ;
                dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR , error         , false, 0, true ) ;
            }
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            if ( loader == null )
            {
                dispatchEvent( new ErrorEvent( ErrorEvent.ERROR , false, false, this + " failed the loader reference of this process not must be 'null'.") ) ;
                notifyFinished() ;
            }
            else if ( request == null )
            {
                dispatchEvent( new ErrorEvent( ErrorEvent.ERROR , false, false, this + " failed the request reference of this process not must be 'null'.") ) ;
                notifyFinished() ;
            }
            else
            {
                // FIXME resolveRequest() ; // Problem with the URI class for the moment with the relative uris
                _run() ;
            }
        }
        
        /**
         * Sets the timeout interval duration.
         * @param time The time interval of the timeout limit.
         * @param useSeconds This optional boolean indicates if the time parameter is in seconds or milliseconds.
         */
        public function setDelay( time:uint , useSeconds:Boolean=false):void 
        {
            if (useSeconds) 
            {
                time = Math.round(time * 1000) ;
            }
            _timer.delay = time ;
        }    
        
        /**
         * Unregisters the loader object.
         */
        public function unregister( dispatcher:IEventDispatcher ):void
        {
            if ( dispatcher != null )
            { 
                dispatcher.removeEventListener( Event.COMPLETE                    , complete      ) ;
                dispatcher.removeEventListener( HTTPStatusEvent.HTTP_STATUS       , dispatchEvent ) ;
                dispatcher.removeEventListener( IOErrorEvent.IO_ERROR             , error         ) ;
                dispatcher.removeEventListener( Event.OPEN                        , dispatchEvent ) ;
                dispatcher.removeEventListener( ProgressEvent.PROGRESS            , dispatchEvent ) ;
                dispatcher.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , error         ) ;
            }
        }
        
        /**
         * Invoked when the loading is complete.
         */
        protected function complete( e:Event ):void
        {
            dispatchEvent(e) ;
            notifyFinished() ;
        }
//        
//        /**
//         * Dispatch HTTPStatusEvent if a call to load() attempts to access data over HTTP and the current Flash Player environment is able to detect and return the status code for the request.
//         */
//        protected function httpStatus( e:HTTPStatusEvent ):void
//        {
//            dispatchEvent(e) ;
//        }
        
        
        /**
         * Dispatch an ErrorEvent if a call to load() attempts a server problem (IOErrorEvent or SecurityErrorEvent). 
         */
        protected function error( e:ErrorEvent ):void
        {
            dispatchEvent(e) ;
            notifyFinished() ;
        }
        
        /**
         * This protected method contains the invokation of the load method of the current loader of this process.
         */
        protected function _run():void
        {
            //
        }
        
        /**
         * Dispatch Event.OPEN event when the download operation commences following a call to the load() method.
         */
        protected function open(e:Event):void
        {
            dispatchEvent(e) ;
        }
        
        /**
         * Invoked when the loading is in complete.
         */
        protected function progress( e:ProgressEvent ):void
        {
            dispatchEvent(e) ;
        }
        
        ///////////
        
        /**
         * Resolves the request of the loader with the cache query parameter if the cache attribute is true.
         */
        protected function resolveRequest():void
        {
            if ( _request && _request.url )
            {
                var uri:URI = new URI( _request.url ) ; // FIXME bug here with the relative uris !!!!
                uri.setParameterValue
                ( 
                    cacheParameterName || DEFAULT_CACHE_PARAMETER , 
                    cache ? ( Math.random() * (new Date()).valueOf() ) : undefined 
                ) ;
                _request.url = uri.toString() ;
            }
        }
        
        ///////////
        
        /**
         * @private
         */
        protected var _loader:* ;
        
        /**
         * The internal URLRequest reference of the loader.
         * @private
         */
        protected var _request:URLRequest ;
        
        /**
         * @private 
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private var _policy:TimeoutPolicy ;
        
        /**
         * @private
         */
        private function _onTimeOut(e:TimerEvent):void
        {
            notifyTimeOut() ;
            close() ;
        }
    }
}
