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

// TODO : finir de cabler les propriétés et méthodes de URLLoader.
// TODO : créer asgard.net.MassiveLoader

package asgard.net
{
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    import flash.utils.getDefinitionByName;
    
    import pegas.events.ActionEvent;
    
    import vegas.events.AbstractCoreEventDispatcher;
    import vegas.logging.ILogger;
    import vegas.logging.Log;
    import vegas.util.ClassUtil;
    
	/**
	 * The ActionLoader class.
     * @author eKameleon
     */
    public class ActionLoader extends AbstractCoreEventDispatcher implements IActionLoader
    {

        /**
         * Creates a new ActionLoader instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}. 
         */
        public function ActionLoader( bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal , sChannel );
            
            _loader = getLoader() ;
            _loader.addEventListener( Event.COMPLETE , complete ) ;
            _loader.addEventListener( HTTPStatusEvent.HTTP_STATUS , httpStatus ) ;
            _loader.addEventListener( IOErrorEvent.IO_ERROR, ioError ) ;
            _loader.addEventListener( Event.OPEN, open ) ;
            _loader.addEventListener( ProgressEvent.PROGRESS, progress ) ;
            _loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityError ) ;
            
            _request = new URLRequest() ;
            
            _logger = Log.getLogger( ClassUtil.getPackage(this) ) ;
            
            _timer = new Timer(DEFAULT_DELAY, 1) ;

			setTimeoutPolicy( TimeoutPolicy.LIMIT ) ;
            
        }
        
		/**
		 * The default value of the delay before the ActionEvent.TIMEOUT event.
		 */
		static public const DEFAULT_DELAY:uint = 8000 ; // 8 secondes
        
        /**
         * (read-only) Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public function get bytesLoaded():uint
    	{
    		return _loader.bytesLoaded ;	
    	}
        
        /**
         * (read-write) Indicates the total number of bytes in the downloaded data.
         */
        public function get bytesTotal():uint
    	{
    		return _loader.bytesTotal ;	
    	}
        
        /**
         * (read-write) Returns the data received from the load operation. 
         */
        public function get data():*
    	{
    		return _loader.data ;	
    	}
   
        /**
         * (read-write) Sets the data received from the load operation. 
         */
        public function set data( value:* ):void
    	{
    		_loader.data = value ;	
    	}
        
        /**
         * (read-write) Controls whether the downloaded data is received as 
         *   - text (URLLoaderDataFormat.TEXT),
         *   - raw binary data (URLLoaderDataFormat.BINARY)
         *   - URL-encoded variables (URLLoaderDataFormat.VARIABLES).
         */
        public function get dataFormat():String
    	{
    		return _loader.dataFormat ;	
    	}
    	
        public function set dataFormat( value:String ):void
    	{
    		_loader.dataFormat = value ;	
    	}
        
        /**
         * (read-only) Returns 'true' if load method is launched
         */
    	public function get running():Boolean 
    	{
		    return _isRunning ;
        }

        /**
         * (read-write) Activate or disactivate parsing (Use this with XML, EDEN, JSON...). 
         */
        public function get parsing():Boolean
    	{
    		return _isParsing ;	
    	}
    	
        public function set parsing( b:Boolean ):void
    	{
    	    _isParsing = b ;	
    	}

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public function clone():*
        {
            var cName:String = ClassUtil.getPath(this) ;
            var clazz:Class = ( getDefinitionByName( cName ) as Class ) ;
            var cloader:* = new clazz() ;
            return cloader ;
        }

        /**
         * Closes the load operation in progress.
         */
        public function close():void
        {
            _loader.close() ;
        }

		/**
		 * Returns timeout interval duration.
		 */
		public function getDelay():uint
		{
			return _timer.delay ;
		}

        /**
         * Return the original loader in the constructor. Override this method.
         */ 
        public function getLoader():URLLoader
        {
            return new URLLoader() ;
        }
        
        /**
         * Returns the timeout policy.
         */
		public function getTimeoutPolicy():TimeoutPolicy 
		{
			return _policy ;	
		}

        /**
         * Sends and loads data from the specified URL.
         * @param request:URLRequest broke the internal request with your custom URLRequest
         */
        public function load( request:URLRequest=null ):void
        {

            if (running)
            {
                return ;
            }

            notifyStarted() ;
            _loader.load(request) ;
            
        }

        /**
         * Dispatch the ActionEvent.FINISH event.
         */
		public function notifyFinished():void 
		{
		    setRunning(false) ;
            _timer.stop() ;
			var eFinish:ActionEvent = new ActionEvent(ActionEvent.FINISH) ;
			dispatchEvent(eFinish) ;
		}

        /**
         * Dispatch the ActionEvent.START event.
         */
		public function notifyStarted():void
		{
   			setRunning(true) ;
            _timer.start() ;
			var eStart:ActionEvent = new ActionEvent(ActionEvent.START) ;
			dispatchEvent( eStart ) ;
		}

        /**
         * Override this method. Parse your datas when loading is complete.
         */
        public function parse():void
        {
            // override this method.
        }

        /**
         * Sends and loads data from the specified URL.
         */
        public function run( ...arguments:Array ):void
        {

           load( arguments[0] as URLRequest ) ;
            
        }

		/**
		 * Set timeout interval duration.
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
         * Dispatch Event.COMPLETE event after all the received data is decoded and placed in the data property. 
         */
        protected function complete(e:Event):void
		{
		    if (_isParsing) 
		    {
		        parse() ;
		    }
            dispatchEvent(e) ;
            notifyFinished()
        }

        /**
         * Dispatch HTTPStatusEvent if a call to load() attempts to access data over HTTP and the current Flash Player environment is able to detect and return the status code for the request.
         */
        protected function httpStatus( e:HTTPStatusEvent ):void
        {
            dispatchEvent(e) ;
        }

        /**
         * Dispatch IOErrorEvent if a call to load() results in a fatal error that terminates the download.
         */
        protected function ioError( e:IOErrorEvent ):void
        {
            dispatchEvent(e) ;
            notifyFinished() ;
        }

        /**
         * Notify the time imparted to load data is timeout.
         */
		protected function notifyTimeOut():void
		{
			var eTimeOut:ActionEvent = new ActionEvent(ActionEvent.TIMEOUT) ;
			dispatchEvent(eTimeOut) ;
		}

        /**
         * Dispatch Event.OPEN event when the download operation commences following a call to the load() method.
         */
        protected function open(e:Event):void
        {
            dispatchEvent(e) ;
        }
        
        /**
         * Dispatch ProgressEvent.PROGRESS event when data is received as the download operation progresses. 
         */
        protected function progress( e:ProgressEvent ):void
        {
            dispatchEvent(e) ;
        }

        /**
         * Dispatch SecurityErrorEvent if a call to load() attempts to load data from a server outside the security sandbox. 
         */
        protected function securityError( e:SecurityErrorEvent ):void
        {
            dispatchEvent(e) ;
            notifyFinished() ;
        }

        /**
         * Sets the running property.
         */
        protected function setRunning( b:Boolean ):void
        {
            _isRunning = b ;
        }

        protected var _loader:URLLoader = null ;

        protected var _logger:ILogger ;

        protected var _request:URLRequest = null ;

  		private var _isRunning:Boolean = false ;

  		private var _isParsing:Boolean = false ;

  		private var _policy:TimeoutPolicy = null ;

  		private var _timer:Timer = null ;
  		
  		private function _onTimeOut(e:TimerEvent):void
  		{
  		    close() ; // test the close method here...
			notifyTimeOut() ;
			notifyFinished() ;
  		}
  		
    }
}