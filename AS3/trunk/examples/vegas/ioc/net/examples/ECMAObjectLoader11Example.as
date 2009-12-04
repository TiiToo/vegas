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
    
    import vegas.date.Time;
    import vegas.events.SoundEvent;
    import vegas.ioc.io.SoundResource;
    import vegas.ioc.net.ECMAObjectLoader;
    import vegas.media.CoreSound;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.text.TextField;
    import flash.ui.Keyboard;
    
    [SWF(width="520", height="320", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Test the SoundResource class. 
     * Note : The SoundResource isn't register by default in the ObjectResourceBuilder, you must register it manualy.
     * Run  : Use this example only with the FP10 compilation with the compiler parameters :
     * -default-size 520 320 -default-frame-rate 31 -default-background-color 0x666666 -target-player=10.0
     */
    public class ECMAObjectLoader11Example extends Sprite 
    {
        public function ECMAObjectLoader11Example()
        {
            // register the resource in the ObjectResourceBuilder singleton.
            
            SoundResource.register() ; 
            
            // load the external IoC context and initialize the application.
            
            var loader:ECMAObjectLoader = new ECMAObjectLoader( "context/application_sound_resource.eden" ) ;
            
            loader.addEventListener( ActionEvent.FINISH , finish ) ;
            loader.addEventListener( ActionEvent.START  , start ) ;
            
            loader.root = this ;
            loader.run() ;
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
            trace( sound ) ;
            if ( sound )
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
        }
        
        public function soundComplete( e:Event ):void
        {
            var time:Time = new Time( sound.length ) ;
            trace( e + " : duration " + time.getMilliseconds(2) + " ms" ) ;
        }
        
        public function soundChange( e:ActionEvent = null ):void
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
        
        protected function finish( e:Event ):void
        {
            trace("finish") ;
        }
        
        protected function start( e:Event ):void
        {
            trace("start") ;
        }
    }
}