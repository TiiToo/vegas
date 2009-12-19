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
    import graphics.FillGradientStyle;
    import graphics.transitions.easings.Back;

    import vegas.display.Background;
    import vegas.process.display.SwitchBackgroundGradientColor;

    import flash.display.GradientType;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    import flash.ui.Keyboard;

    [SWF(width="980", height="600", frameRate="24", backgroundColor="#FFFFFF")]
    
    public class SwitchBackgroundGradientColorExample extends Sprite 
    {
        public function SwitchBackgroundGradientColorExample()
        {
            /////////
            
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown) ;
            
            /////////
            
            background = new Background() ;
            
            background.autoSize         = true ;
            background.isFull           = true ;
            background.direction        = null ;
            background.gradientRotation = 90   ;
            background.useGradientBox   = false ;
            background.gradientTranslation = new flash.geom.Point(400 , 0) ;
            
            background.fill = new FillGradientStyle
            (
                GradientType.RADIAL , // type
                [0xEFFD71,0x225677] , // colors 
                [1, 1 ], // alphas
                [0, 255] , // ratios
                null, "pad" , "rgb" , 0.6
            ) ;
            
            addChild( background ) ;
            
            /////////
            
            switcher = new SwitchBackgroundGradientColor( background ) ;
            
            switcher.easing     = Back.easeOut ;
            switcher.duration   = 1 ;
            switcher.useSeconds = true ;
        }
        
        protected var background:Background ;
        protected var switcher:SwitchBackgroundGradientColor ;
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    switcher.alphas = [1,1] ;
                    switcher.colors = [0x3D2640,0xBF5188]  ;
                    switcher.ratios = [0, 100] ,
                    switcher.run() ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    switcher.alphas = [0.8,1] ;
                    switcher.colors = [0xEFFD71,0x225677]  ;
                    switcher.ratios = [0, 255] ,
                    switcher.run() ;
                    break ;
                }
            }
        }
    }
}
