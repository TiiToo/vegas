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

package 
{
    import graphics.FillStyle;
    
    import mvc.controller.model.AddPicture;
    import mvc.controller.model.ChangePicture;
    import mvc.controller.model.ClearPicture;
    import mvc.controller.model.RemovePicture;
    import mvc.display.DisplayList;
    import mvc.events.EventList;
    import mvc.model.GalleryModel;
    import mvc.model.ModelList;
    import mvc.vo.PictureVO;
    
    import system.events.FrontController;
    
    import vegas.display.Background;
    import vegas.display.CoreLoader;
    import vegas.models.ModelCollector;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.filters.DropShadowFilter;
    import flash.ui.Keyboard;
    
    [SWF(width="300", height="300", frameRate="24", backgroundColor="#666666")]
    
    /**
     * The ApplicationMVC main tutorial class.
     * Compiler arguments :
     * -default-size 300 300 -default-frame-rate 24 -default-background-color 0x666666 -target-player=10.0
     */
    public class ApplicationMVC extends Sprite
    {
        /**
         * Creates a new ApplicationMVC instance.
         */
        public function ApplicationMVC()
        {
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = StageAlign.TOP_LEFT ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown ) ;
            
            // model
            
            var gallery:GalleryModel = new GalleryModel( ModelList.GALLERY_MODEL ) ;
            
            gallery.setEventTypeADD    ( EventList.ADD_PICTURE    ) ;
            gallery.setEventTypeCHANGE ( EventList.CHANGE_PICTURE ) ;
            gallery.setEventTypeCLEAR  ( EventList.CLEAR_PICTURE  ) ;
            gallery.setEventTypeREMOVE ( EventList.REMOVE_PICTURE ) ;
            
            // view
            
            var picture:Background = new Background( DisplayList.PICTURE ) ;
            
            picture.filters = [ new DropShadowFilter(2,60,0,0.6,12,12,1,2) ] ;
            
            picture.fill = new FillStyle(0xFFFFFF, 0.4) ;
            picture.w    = 260 ;
            picture.h    = 260 ;
            picture.x    =  20 ;
            picture.y    =  20 ;
            
            addChild(picture) ;
            
            var loader:CoreLoader = new CoreLoader( DisplayList.LOADER ) ;
            
            picture.addChild( loader ) ;
            
            // controller
            
            var controller:FrontController = FrontController.getInstance() ;
            
            controller.add( EventList.ADD_PICTURE    , new AddPicture() ) ;
            controller.add( EventList.CHANGE_PICTURE , new ChangePicture() ) ;
            controller.add( EventList.CLEAR_PICTURE  , new ClearPicture() ) ;
            controller.add( EventList.REMOVE_PICTURE , new RemovePicture() ) ;
            
            // initialize
            
            var count:int = 6 ;
            
            for (var i:int = 1 ; i<= count ; i++)
            {
                gallery.addVO( new PictureVO( { id:i , name:"picture_" + i , url:"library/picture" + i + ".jpg" } ) ) ;
            }
            
            // run application
            
            gallery.run() ;
        }
        
        /**
         * Invoked when a key event is notify.
         */
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            var gallery:GalleryModel = ModelCollector.get( ModelList.GALLERY_MODEL ) as GalleryModel ;
            trace( e.type + " : " + code ) ;
            try
            {
                switch (code)
                {
                    case Keyboard.RIGHT :
                    {
                        gallery.next() ;
                        break ;
                    }
                    case Keyboard.LEFT :
                    {
                        gallery.previous() ;
                        break ;
                    }
                    case Keyboard.SPACE :
                    {
                        gallery.clear() ;
                        break ;
                    }
                }
            }
            catch( error:Error )
            {
                trace( " keyHandler failed : " + error.toString() )  ;
            }
        }
    }
}

