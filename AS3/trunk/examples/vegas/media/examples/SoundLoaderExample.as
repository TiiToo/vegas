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
    
    import vegas.media.CoreSound;
    import vegas.media.SoundLoader;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLRequest;
    
    public class SoundLoaderExample extends Sprite 
    {
        public function SoundLoaderExample()
        {
            var url:String = "mp3/test.mp3" ;
            
            sound = new CoreSound() ;
            
            var process:SoundLoader = new SoundLoader( sound ) ;
            
            process.addEventListener(ActionEvent.START     , start ) ;
            process.addEventListener(ActionEvent.PROGRESS  , progress ) ;
            process.addEventListener(ActionEvent.FINISH    , finish ) ;
            
            process.request = new URLRequest( url ) ;
            
            process.run() ;
        }
        
        public var sound:CoreSound ;
        
        public function start( e:Event ):void
        {
            trace(e) ;
        }
        
        public function progress( e:Event ):void
        {
            var target:SoundLoader = e.target as SoundLoader ;
            trace( target.bytesLoaded + " : " + target.bytesTotal) ;
        }
        
        public function finish( e:Event ):void
        {
            trace(e) ;
            sound.play() ;
        }
    }
}
