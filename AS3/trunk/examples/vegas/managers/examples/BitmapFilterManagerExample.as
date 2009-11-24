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
    import vegas.managers.BitmapFilterManager;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.filters.BlurFilter;
    import flash.filters.DropShadowFilter;
    import flash.ui.Keyboard;
    
    public class BitmapFilterManagerExample extends Sprite 
    {
        public function BitmapFilterManagerExample()
        {
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            var shape:Shape = new Shape() ;
            
            shape.graphics.beginFill( 0xFF0000 ) ;
            shape.graphics.drawRect(0,0,50,50) ;
            
            shape.x = 50 ;
            shape.y = 50 ;
            
            addChild( shape ) ;
            
            manager = new BitmapFilterManager( shape ) ;
            
            manager.add( blur ) ;
            manager.add( shadow ) ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var blur:BlurFilter = new BlurFilter(10,5,3) ;
        
        public var manager:BitmapFilterManager ;
        
        public var shadow:DropShadowFilter = new DropShadowFilter(2,45,0,0.7,10,10,1,3) ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    blur.blurX      = 10 ;
                    shadow.distance = 2  ;
                    shadow.angle    = 45 ;
                    manager.update() ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    blur.blurX      = 20 ;
                    shadow.distance = 6  ;
                    shadow.angle    = 90 ;
                    manager.update() ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    manager.enabled = !manager.enabled ;
                    break ;
                }
            }
        }
    }
}
