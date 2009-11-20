﻿/*

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
    import graphics.Align;
    import graphics.FillStyle;
    import graphics.drawing.StarPen;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    
    public class StarPenExample extends Sprite 
    {
        public function StarPenExample()
        {
            var shape:Shape = new Shape() ;
            shape.x         = 740 / 2 ;
            shape.y         = 420 / 2 ;
            
            pen       = new StarPen( shape ) ;
            pen.align = Align.CENTER ;
            pen.fill  = new FillStyle( 0xEBD936 , 1 ) ;
            pen.draw() ;
            
            addChild( shape ) ;
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = "" ;

            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            stage.addEventListener( MouseEvent.MOUSE_DOWN  , mouseDown ) ;
            stage.addEventListener( MouseEvent.MOUSE_UP    , mouseUp   ) ;
        }
        
        public var pen:StarPen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    pen.draw( 0, 0, 3, 40, 80 , 0,  Align.LEFT ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    pen.draw( 0, 0, 5, 80, 40 , 0,  Align.RIGHT ) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.draw( 0, 0, 20, 100, 40 , 0 , Align.TOP ) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    pen.draw( 0, 0, 10 , 100, 60 , 0, Align.BOTTOM ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    pen.x = 10 ;
                    pen.y = 40 ;
                    pen.points  = 8  ;
                    pen.innerRadius = 100 ;
                    pen.outerRadius = 50 ;
                    pen.angle  = 40 ;
                    pen.align  = Align.TOP_RIGHT ;
                    pen.draw() ;
                    break ;
                }
            }
        }
        
        public function enterFrame( e:Event ):void
        {
            pen.angle += 15 ;
            pen.draw() ;
        }
        
        public function mouseDown( e:MouseEvent ):void
        {
            stage.addEventListener( Event.ENTER_FRAME , enterFrame ) ;
        }
        
        public function mouseUp( e:MouseEvent ):void
        {
            stage.removeEventListener( Event.ENTER_FRAME , enterFrame ) ;
        }
    }
}
