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
    import vegas.media.FLV;
    
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.media.Camera;
    import flash.media.Video;
    import flash.net.FileReference;
    import flash.ui.Keyboard;
    
    [SWF(width="740", height="480", frameRate="30", backgroundColor="0x000000")]
    
    public class FLVExample extends Sprite 
    {
        public function FLVExample()
        {
            ////////////
            
            camera = Camera.getCamera() ;
            
            camera.setMode( 320 , 240 , stage.frameRate ) ;
            
            ////////////
            
            video = new Video() ;
            
            video.x = 10 ;
            video.y = 10 ;
            
            video.attachCamera( camera ) ;
            
            addChild( video ) ;
            
            /////////////
            
            flv = new FLV( video.width , video.height , stage.frameRate , 5 ) ;
            
            ////////////
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            ////////////
        }
        
        /**
         * The Camera reference.
         */
        public var camera:Camera ;
        
        /**
         * The FLV reference.
         */
        public var flv:FLV ;
        
        /**
         * Indicates the current number of frames during the recording process.
         */
        public function get frameCount():uint
        {
            return _frameCount ;
        }
        
        /**
         * Indicates if the playing process is in progress.
         */
        public function get playing():Boolean
        {
            return _playing ;
        }
        
        /**
         * Indicates if the recording process is in progress.
         */
        public function get recording():Boolean
        {
            return _recording ;
        }
        
        /**
         * The video reference.
         */
        public var video:Video ;
        
        /**
         * Play the FLV video.
         */
        public function play():void
        {
            if ( _recording || _playing )
            {
                return ;
            }
            _playing = true ;
            // TODO implement this feature
        }
        
        /**
         * Record the FLV video.
         */
        public function record():void
        {
            if ( _recording || _playing || _saving )
            {
                return ;
            }
            _recording  = true ;
            _frameCount = 0 ;
            addEventListener( Event.ENTER_FRAME , _record );
        }
        
        
        /**
         * Save the current FLV video.
         */
        public function save():void
        {
            if ( _recording || _playing || _saving )
            {
                return ;
            }
            _saving = true ;
            var file:FileReference = new FileReference() ;
            file.save( flv , "video.flv" ) ;
        }
        
        /**
         * Stop the recording or the playing.
         */
        public function stop():void
        {
            if ( _recording )
            {
                trace( "stop recording" ) ;
                _recording = false ;
                removeEventListener(Event.ENTER_FRAME, _record) ;
            }
        }
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    record() ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    play() ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    save() ;
                    break ;
                }
            }
        }
        
        /**
         * @private
         */
        private var _frameCount:uint ;
        
        /**
         * @private
         */
        private var _playing:Boolean ;
        
        /**
         * @private
         */
        private var _recording:Boolean ;
        
        /**
         * @private
         */
        private var _saving:Boolean ;
        
        /**
         * @private
         */
        private function _record( e:Event ):void
        {
            if(! camera.muted ) 
            {
                _frameCount++;
                if( _frameCount >= ( flv.frameRate * flv.duration ) ) 
                {
                    stop() ;
                } 
                else 
                {
                    trace( "record : " + frameCount ) ;
//                    var snapshot:BitmapData = new BitmapData( camera.width , camera.height ) ;
//                    snapshot.draw( video ) ;
//                    flv.addFrame = snapshot ;
//                    snapshot.dispose() ;
                }
            }
        }
    }
}
