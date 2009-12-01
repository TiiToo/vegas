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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import system.events.ActionEvent;
    
    import vegas.events.NetServerEvent;
    import vegas.net.NetServerConnection;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.NetStatusEvent;
    import flash.net.ObjectEncoding;

    public class NetServerConnectionExample extends Sprite 
    {
        public function NetServerConnectionExample()
        {
            var nc:NetServerConnection = new NetServerConnection() ;
            
            nc.addEventListener( ActionEvent.FINISH        , debug  ) ;
            nc.addEventListener( ActionEvent.START         , debug  ) ;
            nc.addEventListener( NetServerEvent.ACCEPT     , accept ) ;
            nc.addEventListener( NetServerEvent.REJECT     , reject ) ;
            nc.addEventListener( NetStatusEvent.NET_STATUS , status ) ;
            
            nc.objectEncoding = ObjectEncoding.AMF0 ;
            
            nc.connect("rtmp://127.0.0.1/yourapplication") ; // creates in FMS a little empty main.asc file
        }
        
        public function accept( e:NetServerEvent ):void
        {
            trace("accept " + e.info ) ;
            trace("----") ; 
        }
        
        public function debug( e:Event ):void
        {
            trace(">>>> " + e) ;
        }
        
        public function reject( e:NetServerEvent ):void
        {
            trace("reject " + e.info ) ;
            trace("----") ; 
        }
        
        public function status( e:NetStatusEvent ):void
        {
            trace("status " + e ) ; 
            var info:Object = e.info ;
            for (var prop:String in info)
            {
                trace(prop + " : " + info[prop]) ;
            }
            trace("----") ;
        }
    }
}
