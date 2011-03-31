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
    import vegas.net.NetStreamExpert;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.StageVideoAvailabilityEvent;
    import flash.events.StageVideoEvent;
    import flash.geom.Rectangle;
    import flash.media.StageVideo;
    import flash.media.StageVideoAvailability;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    
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
            stage.addEventListener( Event.RESIZE , resize ) ;
            
            ///// stream
            
            connection = new NetConnection() ;
            
            connection.connect(null) ;
            
            stream = new NetStream( connection ) ;
            
            expert = new NetStreamExpert( stream ) ;
        }
        
        public var connection:NetConnection ;
        
        public var expert:NetStreamExpert ;
        
        public var stageVideo:StageVideo ;
        
        public var stream:NetStream ;
        
        protected function renderState( e:Event ):void
        {
            switch( true )
            {
                case e is StageVideoEvent :
                {
                    var sEvent:StageVideoEvent = (e as StageVideoEvent) ;
                    trace( "renderState status:" + sEvent.status ) ;
                    trace( "renderState status:" + sEvent.colorSpace ) ;
                    /*
                      Returns the names of available color spaces for this video surface. Usually this list includes "BT.601" and "BT.709". 
                      On some configurations, only "BT.601" is supported which means a video is possibly not rendered in the correct color space.
                     */
                    break ;
                }
            }
        }
        
        protected function resize( e:Event ):void
        {
             if ( stageVideo && stage )
             {
                stageVideo.viewPort = new Rectangle( 0 , 0, stage.stageWidth , stage.stageHeight ) ;
             }
        }
        
        protected function stageVideoAvailability( e:StageVideoAvailabilityEvent ):void
        {
            var available:Boolean = e.availability == StageVideoAvailability.AVAILABLE;
            
            trace( "stageVideoAvailability : " + available + " :: " + e.availability ) ;
            
            if ( available )
            {
                stageVideo = stage.stageVideos[0] as StageVideo ;
                if ( stageVideo )
                {
                    stageVideo.addEventListener( StageVideoEvent.RENDER_STATE, renderState );
                    stageVideo.attachNetStream( stream ) ;
                    
                    //stageVideo.zoom = new Point(2,2) ;
                    //stageVideo.pan = new Point(-1,-1) ;
                    
                    stageVideo.viewPort = new Rectangle( 0 , 0, stage.stageWidth , stage.stageHeight ) ;
                    
                    expert.play( "videos/dozrok_reel.f4v") ;
                }
            }
        }
    }
}
