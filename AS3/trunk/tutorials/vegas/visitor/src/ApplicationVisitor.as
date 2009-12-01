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

package
{
    import visitor.display.Picture;
    import visitor.visitors.HideVisitor;
    import visitor.visitors.LoaderVisitor;
    import visitor.visitors.ShowVisitor;
    
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.filters.DropShadowFilter;
    import flash.ui.Keyboard;
    
    [SWF(width="300", height="300", frameRate="24", backgroundColor="#666666")]
    
    /**
     * The main class of the visitor tutorial.
     * Compiler arguments :
     * -default-size 300 300 -default-frame-rate 31 -default-background-color 0x666666 -target-player=10.0
     */
    public class ApplicationVisitor extends Sprite
    {
        /**
         * Creates a new ApplicationVisitor instance.
         */
        public function ApplicationVisitor()
        {
            ///// stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = StageAlign.TOP_LEFT ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            ///// view
            
            picture = new Picture() ;
            
            picture.filters = [ new DropShadowFilter( 4, 45, 0x000000, 0.6, 6, 6, 1, 3 ) ] ;
            
            picture.x = 20 ;
            picture.y = 20 ;
            
            addChild( picture ) ;
            
            loader = new Loader() ;
            
            picture.addChild( loader ) ;
            
            ///// run
            
            picture.accept( new LoaderVisitor( loader , "library/picture.jpg" ) ) ;
        }
        
        /**
         * The Loader display reference.
         */
        public var loader:Loader ;
        
        /**
         * The picture display reference.
         */
        public var picture:Picture ;
        
        /**
         * Invoked when a key is down.
         */
        private function keyDown( e:KeyboardEvent = null ):void
        {
            var code:uint = e.keyCode ;
            trace("key down : " + code) ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    picture.accept( new HideVisitor() ) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    picture.accept( new ShowVisitor() ) ;
                    break ;
                }
            }
        }
    }
}
