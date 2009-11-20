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
    import graphics.transitions.Tween;
    import graphics.transitions.easings.Bounce;
    
    import vegas.colors.LightColor;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    public class LightColorExample extends Sprite 
    {
        public function LightColorExample()
        {
            // mc1 and mc2 are 2 MovieClip in the Stage of the application.
            
            var color1:LightColor = new LightColor( getChildByName( "mc1" ) as MovieClip ) ;
            var color2:LightColor = new LightColor( getChildByName( "mc2" ) as MovieClip ) ;
            
            var tween1:Tween = new Tween( color1 , "brightness" , Bounce.easeOut, 100 , 0 , 2 , true ) ;
            var tween2:Tween = new Tween( color2 , "negative"   , Bounce.easeOut, 100 , 0 , 2 , true ) ;
            
            tween1.run() ;
            tween2.run() ;
        }
    }
}
