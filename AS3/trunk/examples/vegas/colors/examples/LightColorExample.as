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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
  
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
    import vegas.colors.LightColor;

    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public dynamic class LightColorExample extends Sprite 
    {
        public function LightColorExample()
        {
            color1 = new LightColor( mc1 ) ;
            color2 = new LightColor( mc2 ) ;
            
            trace( "contrast:" + color1.contrast + " brightness:" + color1.brightness ) ;
            
            stage.scaleMode = "noScale" ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var color1:LightColor ;
        public var color2:LightColor ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    //color1.brightness += 10 ;
                    //color1.brightOffset += 10 ;
                    color1.negative += 10 ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    //color1.brightness -= 10 ;
                    //color1.brightOffset -= 10 ;
                    color1.negative -= 10 ;
                    break ;
                }
                case Keyboard.LEFT :
                {
                    color1.contrast += 10 ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    color1.contrast -= 10 ;
                    break ;
                }
            }
            trace( "contrast:" + color1.contrast + " brightness:" + color1.brightness + " negative:" + color1.negative  ) ;
        }
    }
}
