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
    import system.events.ActionEvent;
    import system.process.Action;
    
    import vegas.date.Time;
    import vegas.events.SoundEvent;
    import vegas.ioc.io.SoundResource;
    import vegas.media.CoreSound;
    import vegas.net.ApplicationLoader;
    
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
    public class ApplicationLoader11Example extends Sprite 
    {
        public function ApplicationLoader11Example()
        {
            // register the resource in the ObjectResourceBuilder singleton.
            
            SoundResource.register() ; 
            
            // load the external IoC context and initialize the application.
            
            var loader:ApplicationLoader = new ApplicationLoader( "context/application_sound_resource.eden" ) ;
            
            loader.finishIt.connect( finish ) ; 
            loader.startIt.connect( start ) ; 
            
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
        
        protected function finish( action:Action ):void
        {
            trace("finish") ;
        }
        
        protected function start( action:Action ):void
        {
            trace("start") ;
        }
    }
}