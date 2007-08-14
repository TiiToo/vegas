package 
{
	
	import andromeda.controller.ApplicationController ;
	import andromeda.model.AbstractModelObject ;
	
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import test.control.Controller;
	import test.display.*;
	import test.events.EventList;
	import test.events.PictureEvent;
	import test.model.GalleryModel;
	import test.vo.PictureVO;

	public class mvc extends Sprite
	{
		
		/**
		 * Creates a new mvc application.
		 */
		public function mvc()
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align = StageAlign.TOP_LEFT ;
			
			// controller
			
			
			trace (ApplicationController.getInstance() ) ;
			
			trace( new AbstractModelObject() ) ;
			
			Controller.getInstance() ;
			
            // view
            
            var pic:PictureDisplay = new PictureDisplay() ;
            pic.x = 100 ;
            pic.y = 100 ;

            addChild(pic) ;   	
            
            // model
            
        	var nPicture:Number = 6 ;
		
			for (var i:uint = 1 ; i<= nPicture ; i++)
			{
				var picture:PictureVO = new PictureVO("picture_" + i , "library/picture" + i + ".jpg") ; 
				GalleryModel.getInstance().addPicture( picture ) ;
			}
			
			GalleryModel.getInstance().run() ;
		
		    stage.addEventListener( KeyboardEvent.KEY_DOWN, keyHandler ) ;
		
		}

		public function keyHandler( e:KeyboardEvent ):void
        {
 			
			var code:uint = e.keyCode ;
			
			trace(e.type + " : " + code) ;
			
			switch (code)
			{
				case Keyboard.RIGHT :
				{
					GalleryModel.getInstance().next() ;	
					break ;
				}
				case Keyboard.LEFT :
				{
					GalleryModel.getInstance().prev() ;	
					break ;
				}
        	}
        }
        
		
	}
}
