/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package mvc
{
    import mvc.controllers.models.pictures.AddPicture;
    import mvc.controllers.models.pictures.ChangePicture;
    import mvc.controllers.models.pictures.ClearPicture;
    import mvc.controllers.models.pictures.RemovePicture;
    import mvc.display.picture;
    import mvc.events.EventList;
    import mvc.vo.PictureVO;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    [SWF(width="300", height="300", frameRate="24", backgroundColor="#666666")]
    
    /**
     * The ApplicationMVC main tutorial class.
     * Compiler arguments :
     * -default-size 300 300 -default-frame-rate 24 -default-background-color 0x666666 -target-player=10.0
     */
    public class Application extends Sprite
    {
        /**
         * Creates a new ApplicationMVC instance.
         */
        public function Application()
        {
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = StageAlign.TOP_LEFT ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown ) ;
            
            // initialize
            
            addChild( picture ) ;
            
            controller.add( EventList.ADD_PICTURE    , new AddPicture() ) ;
            controller.add( EventList.CHANGE_PICTURE , new ChangePicture() ) ;
            controller.add( EventList.CLEAR_PICTURE  , new ClearPicture() ) ;
            controller.add( EventList.REMOVE_PICTURE , new RemovePicture() ) ;
            
            var count:int = 6 ;
            
            for (var i:int = 1 ; i<= count ; i++)
            {
                model.addVO( new PictureVO( { id:i , name:"picture_" + i , url:"library/picture" + i + ".jpg" } ) ) ;
            }
            
            // run application
            
            model.run() ;
        }
        
        /**
         * Invoked when a key event is notify.
         */
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch (code)
            {
                case Keyboard.RIGHT :
                {
                    model.next() ;
                    break ;
                }
                case Keyboard.LEFT :
                {
                    model.previous() ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    model.clear() ;
                    break ;
                }
            }
        }
    }
}

