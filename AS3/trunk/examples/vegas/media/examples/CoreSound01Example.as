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
    import vegas.media.CoreSound;

    import flash.display.MovieClip;
    import flash.events.Event;

    public dynamic class CoreSound01Example extends MovieClip 
    {
        public function CoreSound01Example()
        {
            // See in the library of this fla file the BipSound Sound symbol and this linkage class id.
            
            var sound:CoreSound = new BipSound() ;
            
            sound.addEventListener( Event.SOUND_COMPLETE    , soundComplete ) ;
            sound.addEventListener( SoundEvent.SOUND_UPDATE , soundUpdate   ) ;
            
            sound.addEventListener( ActionEvent.FINISH , debug ) ;
            sound.addEventListener( ActionEvent.LOOP   , debug ) ;
            sound.addEventListener( ActionEvent.STOP   , debug ) ;
            sound.addEventListener( ActionEvent.START  , debug ) ;
            
            sound.volume = 0.6 ;
            
            // sound.looping = true ;
            
            sound.play() ;
        }
        
        public function debug( e:ActionEvent ):void
        {
            trace(e) ;
        }
        
        public function soundComplete( e:Event ):void
        {
            var time:Time = new Time( (e.target as CoreSound).length ) ;
            trace( e.type + " duration " + time.getMilliseconds(2) + " ms" ) ;
        }
        
        public function soundUpdate( e:SoundEvent ):void
        {
            trace( e.type + " volume:" + e.soundTransform.volume ) ;
        }
    }
}
