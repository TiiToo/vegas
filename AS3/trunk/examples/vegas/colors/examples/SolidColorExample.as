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
    import graphics.transitions.TweenTo;
    import graphics.transitions.easings.Elastic;
    
    import system.events.ActionEvent;
    
    import vegas.colors.SolidColor;
    
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLRequest;
    
    [SWF(width="260", height="260", frameRate="24", backgroundColor="#666666")]
    
    public class SolidColorExample extends Sprite 
    {
        public function SolidColorExample()
        {
            // initialize
            
            loader = new Loader() ;
            color  = new SolidColor( loader ) ;
            tween  = new TweenTo( color , { redOffset : 255 }, Elastic.easeOut, 2 , true , false , { redOffset : 0 } ) ;
            
            // behaviours
            
            loader.x = 10 ; 
            loader.y = 10 ;
            
            loader.contentLoaderInfo.addEventListener( Event.COMPLETE , complete ) ;
            
            addChild( loader ) ;
            
            tween.addEventListener( ActionEvent.CHANGE , change ) ;
            
            // run example
            
            loader.load( new URLRequest("library/picture.jpg")) ;
        }
        
        public var color:SolidColor ;
        
        public var loader:Loader ;
        
        public var tween:TweenTo ;
        
        public function change( e:ActionEvent ):void
        {
            trace( "red:" + color.red + " / redPercent:" + color.redPercent + " / redOffset:" + color.redOffset ) ;
        }
        
        public function complete( e:Event ):void
        {
            tween.run() ;
        }
    }
}
