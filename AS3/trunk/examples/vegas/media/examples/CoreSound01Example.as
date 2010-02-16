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
