package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import observer.controller.PictureObserver;
	import observer.display.PictureDisplay;
	import observer.model.PictureModel;	

	/**
	 * The main Observer tutorial class.
	 */
	public class Observer extends Sprite
    {
    	
    	/**
    	 * Creates a new Observer main class.
    	 */
        public function Observer()
        {

            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align = StageAlign.TOP_LEFT ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , next ) ;
            stage.addEventListener( MouseEvent.CLICK       , next ) ;
            
            // view
            
            var pic:PictureDisplay = new PictureDisplay() ;
            pic.x = 100 ;
            pic.y = 100 ;

            addChild(pic) ;   
            
            // controller
            var controller:PictureObserver = new PictureObserver( pic ) ;
            
            // model
            model = new PictureModel() ;
            model.addObserver( controller ) ;
         
            model.insertUrl( "library/picture1.jpg" ) ;
            model.insertUrl( "library/picture2.jpg" ) ;
            model.insertUrl( "library/picture3.jpg" ) ;
            model.insertUrl( "library/picture4.jpg" ) ;
            model.insertUrl( "library/picture5.jpg" ) ;
            model.insertUrl( "library/picture6.jpg" ) ;
            
            model.run() ;
            

            
        }
        
        /**
         * The PictureModel Observable object.
         */
        public var model:PictureModel ;
        
        /**
         * Show the next picture in the model.
         */
        public function next( e:Event ):void
        {
			model.run() ;         
        }
	}
}











