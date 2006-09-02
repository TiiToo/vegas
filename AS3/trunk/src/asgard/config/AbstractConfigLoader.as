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

/*	AbstractConfigLoader

	AUTHOR

		Name : AbstractConfigLoader
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2008-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/

// TODO : finir de cabler les propriétés et méthodes de URLLoader.
// TODO : voir pour le protect Config.
// TODO : créer asgard.net.ActionLoader
// TODO : créer asgard.net.MassiveLoader

package asgard.config
{

    import asgard.events.ActionEvent ;

    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    
    import vegas.events.AbstractCoreEventBroadcaster;
    import vegas.logging.Log ;
    import vegas.logging.ILogger 
    import vegas.util.ClassUtil 

    public class AbstractConfigLoader extends AbstractCoreEventBroadcaster implements IConfigLoader
    {
        
        // ----o Constructor
        
        public function AbstractConfigLoader( name:String="" )
        {

            super() ;
            
            _loader = getLoader() ;
            _loader.addEventListener( Event.COMPLETE , complete ) ;
            _loader.addEventListener( HTTPStatusEvent.HTTP_STATUS , httpStatus ) ;
            _loader.addEventListener( IOErrorEvent.IO_ERROR, ioError ) ;
            _loader.addEventListener( Event.OPEN, open ) ;
            _loader.addEventListener( ProgressEvent.PROGRESS, progress ) ;
            _loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityError ) ;

            _request = new URLRequest() ;
            
            _name = name ;
            
            _config = Config.getInstance( name ) ;
            
            _logger = Log.getLogger("asgard.config") ;
            
        }
        
    	// ----o Public Properties

        /**
         * Return the config object.
         */
        public function get config():Config 
    	{
    		return _config ;	
    	}
    	
        /**
         * The data received from the load operation. 
         */
        public function get data():*
    	{
    		return _loader.data ;	
    	}
    	
        public function set data( value:* ):void
    	{
    		_loader.data = value ;	
    	}
    	
        /**
         *
         */
    	public var default_file_name:String = "config" ;
        
        /**
         * 
         */
    	public var default_file_suffix:String = ".eden" ;
        
        
        /**
         * The name of the config file with datas.
         */
        public function get fileName():String 
        {
		    return (_fileName == null) ? default_file_name : _fileName ;	
    	}

    	public function set fileName( value:String ):void 
    	{
    		_fileName = value ;	
    	}

        /**
         * (read-only) Returns 'true' if load method is launched
         */
    	public function get running():Boolean 
    	{
		    return _isRunning ;
        }

        /**
         * The name of the config.
         */
    	public function get name():String 
    	{
		    return _name ;
        }
   
        /**
         * The path of the config file with datas.
         */
    	public function get path():String 
    	{
		    return _path ;
        }
 
        public function set path( value:String ):void
        {
		    _path = value ;
    	}

        /**
         * The suffix of the config file with datas.
         */
    	public function get suffix():String 
    	{
	    	return (_suffix == null) ? default_file_suffix : _suffix ;
    	}
 
	    public function set suffix( value:String ):void
	    {
		    _suffix = value ;
    	}
 
        // ----o Public Methods
    
        /**
         * Returns a clone.
         */
        public function clone():*
        {
            var cName:String = ClassUtil.getPath(this) ;
            var clazz:Class = ( getDefinitionByName( cName ) as Class ) ;
            var cloader:IConfigLoader = (new clazz(_name) as IConfigLoader) ;
            if (cloader != null)
            {
                cloader.data = data ;
                cloader.fileName = fileName ;
                cloader.path = path ;
                cloader.suffix = suffix ;
            }
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
         * Return the original loader in the constructor. Override this method.
         */ 
        public function getLoader():URLLoader
        {
            return new URLLoader() ;
        }
        
        /**
         * Sends and loads data from the specified URL.
         * @param request:URLRequest broke the internal request with your custom URLRequest
         */
        public function load( request:URLRequest=null ):void
        {

            notifyStarted() ;

            if (request == null)
            {
                _request.url = path + fileName + suffix ;
                _loader.load(_request) ;    
            }
            else
            {
                _loader.load(request) ;
            }
            
        }

        /**
         * Dispatch the ActionEvent.FINISH event.
         */
		public function notifyFinished():void 
		{
		    setRunning(false) ;
			var eFinish:ActionEvent = new ActionEvent(ActionEvent.FINISH) ;
			dispatchEvent(eFinish) ;
		}

        /**
         * Dispatch the ActionEvent.START event.
         */
		public function notifyStarted():void
		{
   			setRunning(true) ;
			var eStart:ActionEvent = new ActionEvent(ActionEvent.START) ;
			dispatchEvent( eStart ) ;
		}

        /**
         * Sends and loads data from the specified URL.
         */
        public function run( ...arguments:Array ):void
        {

            _request.url = path + fileName + suffix ;
            _loader.load(_request) ;
            
        }

        // ----o Protected Methods

        /**
         * Dispatch Event.COMPLETE event after all the received data is decoded and placed in the data property. 
         */
        protected function complete(e:Event):void
		{
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

        protected function setRunning( b:Boolean ):void
        {
            _isRunning = b ;
        }

        // ----o Private Properties
        
        private var _config:Config = null ;
        private var _fileName:String = null ;
		private var _isRunning:Boolean = false ;
        private var _loader:URLLoader = null ;
        private var _logger:ILogger ;
        private var _name:String ;
        private var _path:String = null ;
        private var _request:URLRequest = null ;
        private var _suffix:String = null ;

    }
}