﻿/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
    import graphics.Align;
    import graphics.FillStyle;

    import vegas.display.Protector;

    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    import flash.ui.Keyboard;

    /**
     * Example of the Protector class.
     */
    public dynamic class ProtectorExample extends MovieClip 
    {
        public function ProtectorExample()
        {
            // stage
            
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            // protector
            
            cursor       = new Cursor() ; // see in the library of the fla
            
            protect      = new Protector() ;
            protect.fill = new FillStyle( 0xD97BD0 , 0.2 ) ;
            
            protect.cursor         = cursor ;
            protect.magnetic       = false  ;
            protect.mouseVisible   = true   ;
            
            // protect.cursorAutoPlay = false  ;
            
            addChild( protect ) ;
            
            protect.start() ;
        }
        
        public var cursor:MovieClip ;
        
        public var protect:Protector ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    if ( protect.stopped )
                    {
                        protect.start() ;
                    }
                    else
                    {
                        protect.stop() ;
                    }
                    
                    break ;
                }
                case Keyboard.UP :
                {
                    protect.cursorAlign  = Align.TOP ;
                    protect.cursorOffset = new Point( 0 , 0 ) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    protect.cursorAlign  = Align.BOTTOM ;
                    protect.cursorOffset = new Point( 0 , cursor.height ) ;
                    break ;
                }
                case Keyboard.LEFT :
                {
                    protect.cursorAlign  = Align.LEFT ;
                    protect.cursorOffset = new Point( 0 , 0 ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    protect.cursorAlign  = Align.RIGHT ;
                    protect.cursorOffset = new Point( cursor.width , 0 ) ;
                    break ;
                }
                default :
                {
                    protect.cursorAlign = Align.CENTER ;
                }
            }
        }
    }
}
