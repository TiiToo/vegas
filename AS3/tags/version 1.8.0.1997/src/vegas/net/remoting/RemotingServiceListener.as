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

package vegas.net.remoting 
{
    import system.events.ActionEvent;
    import system.events.CoreEventDispatcher;
    
    import vegas.events.RemotingEvent;
    import vegas.logging.logger;
    
    import flash.utils.Dictionary;
    
    /**
     * The basic implementation of the <code class="prettyprint">IRemotingEventListener</code> interface.
     */
    public class RemotingServiceListener extends CoreEventDispatcher implements IRemotingServiceListener 
    {
        /**
         * Creates a new RemotingServiceListener instance.
         * @param service An optional RemotingService reference or an Array of RemotingService objects to be registered.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function RemotingServiceListener( service:* = null , verbose:Boolean = true , global:Boolean = false , channel:String = null )
        {
            super ( global , channel ) ;
            if ( service is RemotingService )
            {
                registerService( service ) ;
            }
            else if ( service is Array )
            {
                var s:RemotingService ;
                var a:Array = service as Array ;
                var l:int   = a.length ;
                while( --l > -1 )
                {
                    s = a[l] as RemotingService ;
                    if ( s )
                    {
                        registerService( s ) ;
                    }
                }
            }
            this.verbose = verbose ;
        }
        
        /**
         * Indicates the verbose mode of this listener.
         */
        public var verbose:Boolean ;
        
        /**
         * Invoked when the service notify an error.
         */
        public function error( e:RemotingEvent ):void
        {
            if ( verbose )
            {    
                logger.error( this + " " + e.type ) ;
            }
        }
        
        /**
         * Invoked when the service notify a fault.
         */
        public function fault( e:RemotingEvent ):void
        {
            if ( verbose )
            {
                logger.warn( this + " " + e.type + " description:" + e.description + ", code:" + e.code ) ;
            }
        }
        
        /**
         * Invoked when the service process is finished.
         */
        public function finish( e:ActionEvent ):void
        {
            if ( verbose )
            {
                logger.info( this + " " + e.type ) ;
            }
        }
        
        /**
         * Registers the specific remoting service.
         * @return True if the service is registered.
         */
        public function registerService( service:RemotingService ):Boolean
        {
            unregisterService( service ) ;
            if ( service && _map[service] == null )
            {
                _map[service] = service ;
                service.addEventListener( ActionEvent.FINISH   , finish  , false, 0 , true ) ;
                service.addEventListener( ActionEvent.START    , start   , false, 0 , true ) ;
                service.addEventListener( ActionEvent.TIMEOUT  , timeout , false, 0 , true ) ;
                service.addEventListener( RemotingEvent.ERROR  , error   , false, 0 , true ) ;
                service.addEventListener( RemotingEvent.FAULT  , fault   , false, 0 , true ) ;
                service.addEventListener( RemotingEvent.RESULT , result  , false, 0 , true ) ;
                return true ;
            }
            else
            {
                return false ; 
            }
        }
        
        /**
         * Invoked when the service notify a success.
         */
        public function result( e:RemotingEvent ):void
        {
            if ( verbose )
            {
                var service:RemotingService = e.target as RemotingService ;
                logger.debug( this + " " + e.type + " service:" + service ) ;
            }
        }
        
        /**
         * Invoked when the service process is started.
         */
        public function start( e:ActionEvent ):void
        {
            if ( verbose )
            {
                var service:RemotingService = e.target as RemotingService ;
                logger.info( this + " " + e.type + " service:" + service + " gatewayUrl:" + service.gatewayUrl ) ;
            }
        }
        
        /**
         * Invoked when the service notify a timeout.
         */
        public function timeout( e:ActionEvent ):void
        {
            if ( verbose )
            {
                logger.warn( this + " " + e.type ) ;
            }
        }
        
        /**
         * Unregister the service register in this listener.
         * @return True if the unregister is success.
         */
        public function unregisterService( service:RemotingService ):Boolean
        {
            if ( _map[service] )
            {
                service.removeEventListener( ActionEvent.FINISH   , finish  , false ) ;
                service.removeEventListener( ActionEvent.START    , start   , false ) ;
                service.removeEventListener( ActionEvent.TIMEOUT  , timeout , false ) ;
                service.removeEventListener( RemotingEvent.ERROR  , error   , false ) ;
                service.removeEventListener( RemotingEvent.FAULT  , fault   , false ) ;
                service.removeEventListener( RemotingEvent.RESULT , result  , false ) ;
                return delete _map[service] ;
            }
            return false ;
        }
        
        /**
         * The internal map of all services registered in this listener.
         */
        private var _map:Dictionary = new Dictionary(true) ;
    }
}
