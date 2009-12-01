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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
*/

package examples 
{
    import graphics.colors.RGB;
    import graphics.transitions.TweenUnit;
    import graphics.transitions.easings.Bounce;
    
    import system.events.ActionEvent;
    
    import vegas.colors.Color;
    
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class RGBInterpolateExample extends Sprite 
    {
        public function RGBInterpolateExample()
        {
            // gets the display references on the stage
            
            display = getChildByName( "display" ) as MovieClip ;
            
            pink    = getChildByName( "pink"    ) as SimpleButton ;
            pink    = getChildByName( "pink"    ) as SimpleButton ;
            red     = getChildByName( "red"     ) as SimpleButton ;
            gray    = getChildByName( "gray"    ) as SimpleButton ;
            green   = getChildByName( "green"   ) as SimpleButton ;
            black   = getChildByName( "black"   ) as SimpleButton ;
            yellow  = getChildByName( "yellow"  ) as SimpleButton ;
            
            // init
            
            finish = RGB.fromNumber( 0x0066CC ) as RGB ;
            
            color  = new Color( display ) ;
            
            tween  = new TweenUnit( Bounce.easeOut , 1.5 ,true ) ;
            
            tween.addEventListener( ActionEvent.CHANGE , change ) ;
            
            // behaviours
            
            blue.addEventListener   ( MouseEvent.MOUSE_DOWN , down ) ;
            pink.addEventListener   ( MouseEvent.MOUSE_DOWN , down ) ;
            red.addEventListener    ( MouseEvent.MOUSE_DOWN , down ) ;
            gray.addEventListener   ( MouseEvent.MOUSE_DOWN , down ) ;
            green.addEventListener  ( MouseEvent.MOUSE_DOWN , down ) ;
            black.addEventListener  ( MouseEvent.MOUSE_DOWN , down ) ;
            yellow.addEventListener ( MouseEvent.MOUSE_DOWN , down ) ;
        }
        
        public var display:MovieClip ;
        
        public var blue:SimpleButton ;
        public var pink:SimpleButton ;
        public var red:SimpleButton ;
        public var gray:SimpleButton ;
        public var green:SimpleButton ;
        public var black:SimpleButton ;
        public var yellow:SimpleButton ;
        
        public var color:Color ;
        
        public var current:RGB ;
        public var tmp:RGB ;
        public var finish:RGB ; 
        
        public var tween:TweenUnit ;
        
        public function change( e:Event ):void
        {
            color.setRGB( current.interpolateToNumber( finish , tween.position )) ;
        }
        
        public function down( e:Event ):void
        {
            current = finish ;
            if(  tween.running )
            {
                tween.stop() ;
            }
            switch( e.target )
            {
                case blue :
                {
                    finish = RGB.fromNumber( 0x0066CC ) ;
                    break ;
                }
                case pink :
                {
                    finish = RGB.fromNumber( 0xFF33CC ) ;
                    break ;
                }
                case red :
                {
                    finish = RGB.fromNumber( 0xFF0000 ) ;
                    break ;
                }
                case gray :
                {
                    finish = RGB.fromNumber( 0x999999 ) ;
                    break ;
                }
                case green :
                {
                    finish = RGB.fromNumber( 0x33CC00 ) ;
                    break ;
                }
                case black :
                {
                    finish = RGB.fromNumber( 0x000000 ) ;
                    break ;
                }
                case yellow :
                {
                    finish = RGB.fromNumber( 0xFFCC00 ) ;
                    break ;
                }
            }
            tween.run() ;
        }
    }
}
