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
    import system.logging.LoggerLevel;
    import system.logging.targets.TraceTarget;
    
    import vegas.net.remoting.RemotingService;
    import vegas.net.remoting.RemotingServiceListener;
    
    import flash.display.Sprite;
    import flash.net.ObjectEncoding;
    
    /**
     * Tests the RemotingServiceListener class. 
     * Note : you can create your custom listener, 
     * you must just extend the RemotingServiceListener class and override the result, fault, etc. methods.
     */
    public class Remoting05Example extends Sprite 
    {
        public function Remoting05Example()
        {
            //////////////
            
            var target:TraceTarget = new TraceTarget() ;
            target.includeLines   = true ;
            target.filters        = [ "*" ] ;
            target.level          = LoggerLevel.ALL ;
            
            //////////////
            
            var gatewayUrl:String  = "http://localhost/vegas/php/gateway.php" ;
            var serviceName:String = "Test"  ;
            
            var service:RemotingService = new RemotingService( gatewayUrl , serviceName ) ;
            
            service.listener = new RemotingServiceListener() ;
            
            service.objectEncoding = ObjectEncoding.AMF0 ;
            service.methodName     = "hello" ;
            
            service.run( "world" ) ;
        }
    }
}
