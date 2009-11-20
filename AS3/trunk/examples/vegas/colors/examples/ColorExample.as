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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
*/

package examples 
{
    import vegas.colors.Color;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    public class ColorExample extends Sprite 
    {
        public function ColorExample()
        {
            // mc1 and mc2 are 2 MovieClip in the Stage of the application.
            
            var display1:MovieClip  = getChildByName( "mc1" ) as MovieClip ;
            var display2:MovieClip  = getChildByName( "mc2" ) as MovieClip ;
            
            var color1:Color = new Color( display1 );
            color1.rgb = 0xFF0000 ;
            
            var color2:Color = new Color( display2 ) ;
            color2.invert() ;
        }
    }
}