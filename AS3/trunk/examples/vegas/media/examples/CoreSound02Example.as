﻿/*

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

    import vegas.date.Time;
    import vegas.events.SoundEvent;
    import vegas.media.CoreSound;
    import vegas.media.SoundCollector;

    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.KeyboardEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;

    public class CoreSound02Example extends MovieClip 
    {
        public function CoreSound02Example()
        {
            // debug TextField
            
            field        = new TextField() ;
            field.x      = 10 ;
            field.y      = 10 ;
            field.width  = 500 ;
            field.height = 300 ;
            field.defaultTextFormat = new TextFormat( "Verdana" , 11, 0xFFFFFF, true ) ;
            
            addChild(field) ;
            
            
            var request:URLRequest = new URLRequest( "mp3/test.mp3" ) ;
            
            sound = new CoreSound( request , null , "mySound" ) ;
            
            trace("SoundCollector.get('mySound') : " + SoundCollector.get( "mySound" ) ) ;
            
            sound.addEventListener( Event.COMPLETE         , debug );
            sound.addEventListener( Event.ID3              , debug );
            sound.addEventListener( IOErrorEvent.IO_ERROR  , debug );
            sound.addEventListener( ProgressEvent.PROGRESS , debug );
            
            sound.addEventListener( Event.SOUND_COMPLETE    , soundComplete ) ;
            sound.addEventListener( SoundEvent.SOUND_UPDATE , soundUpdate   ) ;
            
            sound.addEventListener( ActionEvent.CHANGE   , soundChange ) ;
            
            sound.addEventListener( ActionEvent.FINISH   , debug ) ;
            sound.addEventListener( ActionEvent.LOOP     , debug ) ;
            sound.addEventListener( ActionEvent.PAUSE    , debug ) ;
            sound.addEventListener( ActionEvent.RESUME   , debug ) ;
            sound.addEventListener( ActionEvent.STOP     , debug ) ;
            sound.addEventListener( ActionEvent.START    , debug ) ;
            
            sound.volume = 0.6 ;
            
            // sound.looping = true ;
            
            sound.play() ;
            
            /// stage
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var field:TextField ;
        
        public var sound:CoreSound ;
        
        public function debug( e:Event=null ):void
        {
            trace(e) ;
            soundChange() ;
        }
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode  ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    if ( sound.pausing )
                    {
                        sound.resume() ;
                    }
                    else if ( sound.running )
                    {
                        sound.pause() ;
                    }
                    else
                    {
                        sound.play() ;
                    }
                    break ;
                }
                case Keyboard.UP :
                {
                    sound.stop() ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    sound.togglePause() ;
                    break ;
                }
            }
        }
        public function soundComplete( e:Event ):void
        {
            var time:Time = new Time( (e.target as CoreSound).length ) ;
            trace( e + " : duration " + time.getMilliseconds(2) + " ms" ) ;
        }
        
        public function soundChange( e:ActionEvent =null ):void
        {
            var percent:uint    = Math.floor( ( ( sound.position > 0 ) ? sound.position : 0 ) * 100 / sound.length )  ;
            
            var tPosition:Time  = new Time( sound.position > 0 ? sound.position : 0 ) ;
            var tDuration:Time  = new Time( sound.length ) ;
            
            var position:Number = tPosition.getSeconds(0) ;
            var duration:Number = tDuration.getSeconds(0) ;
            
            var pausing:Boolean = sound.pausing ;
            var running:Boolean = sound.running ;
            
            var txt:String = "" ;
            txt += " sound progress : " + percent + " %" ;
            txt += "\r position  : " + position + " seconds" ;
            txt += "\r duration  : " + duration + " seconds" ;
            txt += "\r pausing : " + pausing ;
            txt += "\r running : " + running ;
            
            field.text = txt ;
        }
        
        public function soundUpdate( e:SoundEvent ):void
        {
            trace( e.type + " volume:" + e.soundTransform.volume ) ;
        }
    }
}