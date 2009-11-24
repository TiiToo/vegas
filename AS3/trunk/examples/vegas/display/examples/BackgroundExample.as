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
  
*/

package examples 
{
    import graphics.Direction;
    import graphics.FillGradientStyle;
    import graphics.FillStyle;

    import vegas.display.Background;

    import flash.display.GradientType;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    /**
     * Example with the vegas.display.Background class.
     */
    public class BackgroundExample extends Sprite 
    {
        public function BackgroundExample()
        {
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown) ;
            
            background         = new Background() ;
            background.fill    = new FillStyle(0xD97BD0, 1) ;
            background.w       = 400 ;
            background.h       = 300 ;
            
            addChild( background ) ;
            
            // little tests
            // background.minWidth = 600 ;
            // background.maxWidth = 250 ;
            // background.line = new LineStyle(2, 0xFFFFFF, 1) ;
        }
        
        protected var background:Background ;
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    if( background.isFull )
                    {
                        background.autoSize  = false ;
                        background.direction = null ;
                        background.isFull    = false ;
                        background.fill      = new FillStyle(0xD97BD0) ;
                    }
                    else
                    {
                        background.autoSize         = true ;
                        background.isFull           = true ;
                        background.direction        = null ;
                        background.gradientRotation = 90 ;
                        background.useGradientBox   = true ;
                        background.fill             = new FillGradientStyle
                        (
                            GradientType.LINEAR , // type 
                            [0x071E2C,0x81C2ED] , // colors
                            [1,1]               , // alphas
                            [0,0xFF]              // ratios
                        ) ;
                    }
                    break ;
                }
                case Keyboard.UP :
                {
                    background.autoSize  = true ;
                    background.fill      = new FillStyle(0x000000) ;
                    background.isFull    = true ;
                    background.direction = Direction.HORIZONTAL ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    background.autoSize  = true ;
                    background.fill      = new FillStyle(0xFFFFFF) ;
                    background.isFull    = true ;
                    background.direction = Direction.VERTICAL ;
                    break ;
                }
            }
        }
    }
}
