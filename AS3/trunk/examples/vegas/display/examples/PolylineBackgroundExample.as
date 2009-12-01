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
    import graphics.FillStyle;
    import graphics.LineStyle;

    import vegas.display.PolyLineBackground;

    import flash.display.Sprite;
    import flash.display.StageScaleMode;

    /**
     * Example to test the PolylineBackground class.
     */
    public class PolylineBackgroundExample extends Sprite 
    {
        public function PolylineBackgroundExample()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            var background:PolyLineBackground = new PolyLineBackground() ;
            
            background.x = 25 ;
            background.y = 25 ;
            
            var data:Array = 
            [
                {x :  10 , y :  10 } , 
                {x : 110 , y :  10 } ,
                {x : 110 , y :  45 } ,
                {x : 120 , y :  55 } ,
                {x : 110 , y :  65 } ,
                {x : 110 , y : 110 } ,
                {x :  10 , y : 110 } 
            ] ;
            
            background.fill = new FillStyle( 0xFF0000 ) ;
            background.line = new LineStyle( 2, 0xFFFFFF ) ;
            background.data = data ;
            
            addChild( background ) ;
        }
    }
}
