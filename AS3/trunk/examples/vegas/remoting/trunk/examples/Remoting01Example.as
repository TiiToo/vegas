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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import system.events.ActionEvent;
    
    import vegas.events.RemotingEvent;
    import vegas.net.remoting.RemotingService;
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.net.ObjectEncoding;
    
    /**
     * Basic "hello world" example of the RemotingService class.
     */
    public class Remoting01Example extends Sprite 
    {
        public function Remoting01Example()
        {
            service                = new RemotingService() ;
            service.objectEncoding = ObjectEncoding.AMF0 ;
            
            service.addEventListener( RemotingEvent.ERROR  , error    ) ;
            service.addEventListener( RemotingEvent.FAULT  , fault    ) ;
            service.addEventListener( ActionEvent.FINISH   , finish   ) ;
            service.addEventListener( ActionEvent.PROGRESS , progress ) ;
            service.addEventListener( RemotingEvent.RESULT , result   ) ;
            service.addEventListener( ActionEvent.START    , start    ) ;
            service.addEventListener( ActionEvent.TIMEOUT  , timeOut  ) ;
            
            service.gatewayUrl  = "http://localhost/vegas/php/gateway.php" ;
            service.serviceName = "Test"  ;
            service.methodName  = "hello" ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , run ) ;
            
            run() ; // first trigger
        }
        
        public var cpt:uint ;
        
        public var service:RemotingService ;
        
        public function run( ...args:Array ):void
        {
            service.params = [ "world" + cpt++ ] ;
            service.run() ;
        }
        
        protected function error(e:RemotingEvent):void
        {
            trace("> " + e.type + " : " + e.code) ;
        }
          
        protected function finish(e:ActionEvent):void
        {
            trace("> " + e.type) ;
        }
          
        protected function fault(e:RemotingEvent):void
        {
            trace( "> " + e.type + " code:" + e.code + " description:" + e.description ) ;
        }
        
        protected function progress(e:ActionEvent):void
        {
            trace("> " + e.type ) ;
        }
         
        protected function result( e:RemotingEvent ):void
        {
             trace("-----------") ;
             trace("> service : " + e.target ) ;
             trace("> result  : " + e.result ) ;
             trace("-----------") ;
        }
        
        protected function start(e:ActionEvent):void
        {
            trace("> " + e.type ) ;
        }
          
        protected function timeOut(e:ActionEvent):void
        {
           trace("> " + e.type ) ;
        }
    }
}
