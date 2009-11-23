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
    import graphics.Align;
    import graphics.display.DisplayObjects;
    
    import vegas.display.Parallaxe;
    
    import flash.display.MovieClip;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;
    
    [SWF(width="700", height="200", frameRate="24", backgroundColor="#A9A988")]
    
    public dynamic class ParallaxeExample extends MovieClip 
    {
        public function ParallaxeExample()
        {
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.addEventListener(Event.ENTER_FRAME , enterFrame ) ;
            
            // init
            
            var area:Rectangle = new Rectangle( 0 , 0 , 700 , 200 ) ;
            
            scrollRect = area ;
            
            DisplayObjects.align( layer1 , area , Align.CENTER ) ;
            DisplayObjects.align( layer2 , area , Align.CENTER ) ;
            DisplayObjects.align( layer3 , area , Align.CENTER ) ;
            
            focus = layer2.focus ; // the circle display in layer2
            
            // parallaxe
            
            parallaxe = new Parallaxe( area ) ;
            
            parallaxe.smoothing = 10 ; // default 10
            
            parallaxe.addLayer( layer1 ) ;
            parallaxe.addLayer( layer2 , true ) ; // sets the main layer
            parallaxe.addLayer( layer3 ) ;
        }
        
        public var layer1:MovieClip ;
        public var layer2:MovieClip ;
        public var layer3:MovieClip ;
        
        public var parallaxe:Parallaxe ;
        
        public var focus:MovieClip ;
        
        protected function enterFrame( e:Event ):void 
        {
            focus.x = focus.parent.mouseX;
            focus.y = focus.parent.mouseY;
            
            parallaxe.focus.x = focus.x ;
            parallaxe.focus.y = focus.y ;
            
            parallaxe.interpolate();
        }
    }
}
