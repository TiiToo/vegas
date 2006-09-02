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

/* ActionLoader

	AUTHOR

		Name : ActionLoader
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2008-09-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/


// TODO : finir de cabler les propriétés et méthodes de URLLoader.
// TODO : créer asgard.net.MassiveLoader

package asgard.net
{

    import asgard.events.ActionEvent ;
    import asgard.net.IActionLoader ;

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
    import vegas.util.ClassUtil ;

    public class ActionLoader extends AbstractCoreEventBroadcaster implements IActionLoader
    {

        // ----o Constructor
        
        public function ActionLoader()
        {
            super();
            
            _loader = getLoader() ;
            _loader.addEventListener( Event.COMPLETE , complete ) ;
            _loader.addEventListener( HTTPStatusEvent.HTTP_STATUS , httpStatus ) ;
            _loader.addEventListener( IOErrorEvent.IO_ERROR, ioError ) ;
            _loader.addEventListener( Event.OPEN, open ) ;
            _loader.addEventListener( ProgressEvent.PROGRESS, progress ) ;
            _loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityError ) ;
            
            _request = new URLRequest() ;
            
            _logger = Log.getLogger( ClassUtil.getPackage(this) ) ;
            
        }
        
        // ----o Public Properties
        
        /**
         * (read-write) The data received from the load operation. 
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
         * (read-only) Returns 'true' if load method is launched
         */
    	public function get running():Boolean 
    	{
		    return _isRunning ;
        }

        // ----o Public Methods

        /**
         * Returns a clone.
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

        // ----o Protected Methods
        
      /**
         * Dispatch Event.COMPLETE event after all the received data is decoded and placed in the data property. 
         */
        protected function complete(e:Event):void
		{
		    parse() ;
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

        // ----o Protected Properties
        
        protected var _loader:URLLoader = null ;
        protected var _logger:ILogger ;
        protected var _request:URLRequest = null ;

        // ----o Private Properties
        
  		private var _isRunning:Boolean = false ;
  
    }
}