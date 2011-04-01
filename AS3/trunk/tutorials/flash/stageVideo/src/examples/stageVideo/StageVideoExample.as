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

package examples.stageVideo
{
    import vegas.media.FLVMetaData;
    import vegas.media.StageVideoExpert;
    import vegas.net.NetStreamExpert;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.events.StageVideoAvailabilityEvent;
    import flash.media.StageVideo;
    import flash.media.StageVideoAvailability;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.ui.Keyboard;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    // -static-link-runtime-shared-libraries=true -target-player={playerVersion}
    
    public class StageVideoExample extends Sprite
    {
        public function StageVideoExample()
        {
            ///// stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = StageAlign.TOP_LEFT ;
            
            stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, stageVideoAvailability );
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            ///// stream
            
            connection = new NetConnection() ;
            
            connection.connect(null) ;
            
            streamExpert = new NetStreamExpert( new NetStream( connection ) ) ;
            
            streamExpert.meta.connect( metaData ) ;
        }
        
        public var available:Boolean ;
        
        public var connection:NetConnection ;
        
        public var streamExpert:NetStreamExpert ;
        
        public var stageVideo:StageVideo ;
        
        public var stream:NetStream ;
        
        public var videoExpert:StageVideoExpert ;
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code ) 
            {
                case Keyboard.SPACE :
                {
                    if ( videoExpert )
                    {
                        videoExpert.autoSize = !videoExpert.autoSize ;
                        videoExpert.isFull   = !videoExpert.isFull ;
                    }
                    break ;
                }
                case Keyboard.UP :
                {
                    streamExpert.close() ;
                    streamExpert.play( "videos/dozrok_reel.f4v") ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    streamExpert.close() ;
                    streamExpert.play( "videos/dozrokhd.f4v") ;
                    break ;
                }
            }
        }
        
        protected function metaData( metaData:FLVMetaData ):void
        {
            trace( "metaData : " + metaData ) ;
        }
        
        protected function renderState( status:String , colorSpace:String , expert:StageVideoExpert ):void
        {
            trace( "renderState status:" + status + " colorSpace:" + colorSpace + " width:" + expert.videoWidth + " height:" + expert.videoHeight ) ;
        }
        
        protected function stageVideoAvailability( e:StageVideoAvailabilityEvent ):void
        {
            available = e.availability == StageVideoAvailability.AVAILABLE;
            
            trace( "stageVideoAvailability : " + available + " :: " + e.availability ) ;
            
            if ( available )
            {
                videoExpert = new StageVideoExpert(stage,0,0,600,337) ;
                
                videoExpert.minWidth  = 600 ;
                videoExpert.minHeight = 337 ;
                
                videoExpert.keepAspectRatio = true ;
                
                videoExpert.renderState.connect( renderState ) ;
                
                trace( videoExpert.videoWidth + " :: " + videoExpert.videoHeight ) ;
                
                //videoExpert.zoom = new Point(2,2) ;
                //videoExpert.pan = new Point(-1,-1) ;
                
                videoExpert.attachNetStream( streamExpert.netStream ) ;
                
                streamExpert.volume = 0.2 ;
                streamExpert.play( "videos/dozrok_reel.f4v") ;
            }
        }
    }
}
