package 
{
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import andromeda.model.ModelCollector;
	
	import mvc.controller.model.AddPicture;
	import mvc.controller.model.ChangeCurrentPicture;
	import mvc.controller.model.ClearPicture;
	import mvc.controller.model.RemovePicture;
	import mvc.display.PictureDisplay;
	import mvc.events.EventList;
	import mvc.model.GalleryModel;
	import mvc.vo.PictureVO;
	
	import vegas.events.FrontController;	

	/**
	 * The MVC main tutorial class.
	 */
	public class MVC extends Sprite
	{
		
		/**
		 * Creates a new mvc application.
		 */
		public function MVC()
		{
			
			// stage
			
			stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = StageAlign.TOP_LEFT ;
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyHandler ) ;
			
			// model
			
			var gallery:GalleryModel = new GalleryModel( GalleryModel.GALLERY_MODEL , true ) ;

			gallery.setEventTypeADD    ( EventList.ADD_PICTURE    ) ;
			gallery.setEventTypeCHANGE ( EventList.CHANGE_PICTURE ) ;
			gallery.setEventTypeCLEAR  ( EventList.CLEAR_PICTURE  ) ;
			gallery.setEventTypeREMOVE ( EventList.REMOVE_PICTURE ) ;
			
            // view
            
            var pic:PictureDisplay = new PictureDisplay() ;
            pic.x = 100 ;
            pic.y = 100 ;

            addChild(pic) ;   	
            
			// controller
						
			FrontController.getInstance().insert( EventList.ADD_PICTURE    , new AddPicture() ) ;
			FrontController.getInstance().insert( EventList.CHANGE_PICTURE , new ChangeCurrentPicture() ) ;
			FrontController.getInstance().insert( EventList.CLEAR_PICTURE  , new ClearPicture() ) ;
			FrontController.getInstance().insert( EventList.REMOVE_PICTURE , new RemovePicture() ) ;
            
            // initialize
            
            var picture:PictureVO   ;
        	
        	var count:Number = 6 ;
		
			for (var i:uint = 1 ; i<= count ; i++)
			{
				var init:Object =
				{
					id:i , name:"picture_" + i , url:"library/picture" + i + ".jpg" 
				} ;
				picture = new PictureVO(  init ) ; 
				gallery.addVO( picture ) ;
			}
			
			gallery.run() ;
		    
		
		}
		
		/**
		 * Invoqued when a key event is notify.
		 */
		public function keyHandler( e:KeyboardEvent ):void
        {
 			
			var code:uint = e.keyCode ;
			var gallery:GalleryModel = GalleryModel( ModelCollector.get( GalleryModel.GALLERY_MODEL ) ) ;
			
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
						gallery.prev() ;	
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
