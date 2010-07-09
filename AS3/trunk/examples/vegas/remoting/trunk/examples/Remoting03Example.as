﻿/*

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
package examples 
{
    import system.events.ActionEvent;

    import vegas.events.RemotingEvent;
    import vegas.net.remoting.RemotingAuthentification;
    import vegas.net.remoting.RemotingService;
    
    import flash.display.Sprite;
    
    /**
     * Tests the RemotingService class with the authentification engine (credentials).
     */
    public class Remoting03Example extends Sprite 
    {
        public function Remoting03Example()
        {
            service = new RemotingService() ;
            
            service.addEventListener( RemotingEvent.ERROR  , error    ) ;
            service.addEventListener( RemotingEvent.FAULT  , fault    ) ;
            service.addEventListener( ActionEvent.FINISH   , finish   ) ;
            service.addEventListener( ActionEvent.PROGRESS , progress ) ;
            service.addEventListener( RemotingEvent.RESULT , result   ) ;
            service.addEventListener( ActionEvent.START    , start    ) ;
            service.addEventListener( ActionEvent.TIMEOUT  , timeOut  ) ;
            
            var authentification:RemotingAuthentification = new RemotingAuthentification("vegas","vegas") ;
            
            service.setCredentials( authentification ) ; // creates a server-side session.
            
            service.gatewayUrl  = "http://localhost:8888/vegas/amfphp/gateway.php" ;
            service.serviceName = "TestAuthentificate" ;
            service.methodName  = "register" ;
            
            service.run() ;
        }
        
        public var service:RemotingService ;
        
        public function error( e:RemotingEvent ):void
        {
            trace( "> " + e.type + " : " + e.code) ;
        }
          
        public function fault( e:RemotingEvent ):void
        {
            trace( "> " + e.type + " code:" + e.code + " description:" + e.description ) ;
        }
        
        public function finish( e:ActionEvent ):void
        {
            trace( "> " + e.type ) ;
        }
        
        public function progress( e:ActionEvent ):void
        {
            trace( "> " + e.type ) ;
        }
         
        public function result( e:RemotingEvent ):void
        {
             trace( "-----------" ) ;
             trace( "> result : " + e.result ) ;
             trace( "-----------" ) ;
        }
        
        public function start( e:ActionEvent ):void
        {
            trace( "> " + e.type ) ;
        }
        
        public function timeOut( e:ActionEvent ):void
        {
            trace( "> " + e.type ) ;
        }
    }
}
