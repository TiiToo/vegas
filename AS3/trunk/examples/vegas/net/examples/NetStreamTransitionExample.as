/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
    import system.eden;
    import system.process.Sequencer;
    
    import vegas.net.NetStreamClient;
    import vegas.net.NetStreamTransition;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.events.KeyboardEvent;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.ui.Keyboard;
    
    public class NetStreamTransitionExample extends Sprite 
    {
        public function NetStreamTransitionExample()
        {
            // stage
            
            stage.align = StageAlign.TOP_LEFT ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            // connection
            
            var connection:NetConnection = new NetConnection() ;
            
            connection.connect( null ) ;
            
            // stream
            
            stream = new NetStream( connection ) ;
            
            // video
            
            var video:Video = new Video() ;
            
            video.x = 20 ;
            video.y = 20 ;
            
            addChild( video ) ;
            
            // client
            
            var client:NetStreamClient = new NetStreamClient( stream , video ) ;
            
            client.status.connect( status );
            
            // sequencer
            
            sequencer = new Sequencer() ;
            
            sequencer.finishIt.connect( finish ) ;
            sequencer.progressIt.connect( progress ) ;
            sequencer.startIt.connect( start ) ;
            
            sequencer.addAction( new NetStreamTransition( stream , "flv/video.flv" ) ) ;
            sequencer.addAction( new NetStreamTransition( stream , "flv/motion.flv" ) ) ;
            sequencer.addAction( new NetStreamTransition( stream , "flv/video.flv" ) ) ;
            sequencer.addAction( new NetStreamTransition( stream , "flv/motion.flv" ) ) ;
            sequencer.addAction( new NetStreamTransition( stream , "flv/motion.flv" ) ) ;
            
            sequencer.run() ;
        }
        
        public var sequencer:Sequencer ;
        
        public var stream:NetStream ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    stream.play( "flv/video.flv" ) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    stream.play( "flv/motion.flv" ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    stream.close() ;
                    break ;
                }
            }
        }
        
        protected function finish():void
        {
            trace( "finish" ) ;
        }
        
        protected function progress():void
        {
            trace( "progress : " + (sequencer.current as NetStreamTransition).uri  ) ;
        }
        
        protected function start():void
        {
            trace( "start" ) ;
        }
        
        /**
         * @private
         */
        protected function status( info:Object ):void
        {
            trace( "status : " + eden.serialize( info ) ) ;
        }
    }
}
