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
    import flash.events.Event;
    import examples.display.SpriteSheetBitmap;
    
    import vegas.display.SpriteSheet;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    [SWF(width="70", height="100", frameRate="12", backgroundColor="#333333")]
    
    /**
     * Example with the vegas.display.Background class.
     */
    public class SpriteSheetExample extends Sprite 
    {
        public function SpriteSheetExample()
        {
            //////////
            
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            //////////
            
            canvas = new Bitmap() ;
            
            canvas.x = 20 ;
            canvas.y = 20 ;
            
            addChild( canvas ) ;
            
            //////////
            
            spritesheet = new SpriteSheet( new SpriteSheetBitmap().bitmapData , 32 , 62 ) ;
            
            //////////
            
            addEventListener( Event.ENTER_FRAME , next ) ;
        }
        
        protected var canvas:Bitmap ;
        
        protected var index:uint ;
        
        protected var sprite:BitmapData ;
        
        protected var spritesheet:SpriteSheet ;
        
        protected function next( e:Event = null ):void
        {
            if ( sprite )
            {
                canvas.bitmapData = null ;
                sprite.dispose() ;
                sprite = null ;
            }
            sprite = spritesheet.getSpriteAt( index++ %24 ) ; // 24 numbers of sprites in the spritesheet
            if ( sprite )
            {
                canvas.bitmapData = sprite ;
            }
        }
        
        protected function keyDown( e:KeyboardEvent ):void 
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    if ( hasEventListener( Event.ENTER_FRAME ) )
                    {
                        removeEventListener( Event.ENTER_FRAME , next ) ;
                    }
                    else
                    {
                        addEventListener( Event.ENTER_FRAME , next ) ;
                    }
                    break ;
                }
            }
        }
    }
}
