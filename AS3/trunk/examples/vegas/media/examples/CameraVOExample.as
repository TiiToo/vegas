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
    import vegas.media.CameraVO;
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.media.Camera;
    import flash.media.Video;
    import flash.ui.Keyboard;
    
    public class CameraVOExample extends Sprite 
    {
        public function CameraVOExample()
        {
            cam1 = new CameraVO() ;
            cam1.bandwidth     = 7800 ;
            cam1.favorarea     = true ;
            cam1.fps           =   15 ;
            cam1.height        =  240 ;
            cam1.quality       =   50 ;
            cam1.motionLevel   =   50 ;
            cam1.motionTimeout = 2000 ;  
            cam1.width         =  320 ;
            
            trace(cam1) ;
            
            cam2 = new CameraVO() ;
            cam2.bandwidth     = 128000 ;
            cam2.favorarea     =   true ;
            cam2.fps           =     15 ;
            cam2.height        =    225 ;
            cam2.quality       =     70 ;
            cam2.motionLevel   =     50 ;
            cam2.motionTimeout =   1500 ;
            cam2.width         =    300 ;
            
            trace(cam2) ;
            
            camera = Camera.getCamera() ;
            
            var video:Video = new Video() ;
            
            addChild( video ) ;
            
            video.x = 25 ;
            video.y = 25 ;
            
            video.attachCamera( camera ) ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var camera:Camera ;
        
        public var cam1:CameraVO ;
        
        public var cam2:CameraVO ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch ( code ) 
            {
                case Keyboard.UP :
                {
                    cam1.apply(camera) ;
                    break ;         
                }
                case Keyboard.DOWN :
                {
                    cam2.apply(camera) ;
                    break ;
                }
            }
            
        }
    }
}
