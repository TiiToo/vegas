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
    import system.eden;
    
    import vegas.net.NetStreamClient;
    
    import flash.display.Sprite;
    import flash.events.NetStatusEvent;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;

    public class NetStreamClientExample extends Sprite 
    {
        public function NetStreamClientExample()
        {
            // connection
            
            var connection:NetConnection = new NetConnection() ;
            
            connection.addEventListener( NetStatusEvent.NET_STATUS , statusConnection ) ;
            
            connection.connect( null ) ;
            
            // stream
            
            var stream:NetStream = new NetStream( connection ) ;
            
            var expert:NetStreamClient = new NetStreamClient( stream ) ;
            
            trace( expert.bufferPercent ) ;
            trace( expert.progress ) ;
            
            stream.addEventListener( NetStatusEvent.NET_STATUS , statusStream ) ;
            
            // stream.play( "my_stream" ) ;
            
            // video
            
            var video:Video = new Video() ;
            
            video.x = 20 ;
            video.y = 20 ;
            
            video.attachNetStream( stream ) ;
            
            addChild(video) ;
        }
        
        public function statusConnection( e:NetStatusEvent ):void
        {
            trace( eden.serialize( e.info ) ) ;
        }
        
        public function statusStream( e:NetStatusEvent ):void
        {
            trace( eden.serialize( e.info ) ) ;
        }
    }
}
