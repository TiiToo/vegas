package 
{

    import flash.display.*;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    
    import test.controller.PictureObserver;
    import test.display.*;
    import test.model.PictureModel;
    
    [SWF(backgroundColor="#CCCCCC", frameRate=24)]

    public class observer extends Sprite
    {
    	
    	/**
    	 * Creates a new observer main class.
    	 */
        public function observer()
        {

            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align = StageAlign.TOP_LEFT ;
            
            // view
            
            var pic:PictureDisplay = new PictureDisplay() ;
            pic.x = 100 ;
            pic.y = 100 ;

            addChild(pic) ;   
            
            // controller
            var c:PictureObserver = new PictureObserver( pic ) ;
            
            // model
            m = new PictureModel() ;
            m.addObserver( c ) ;
         
            m.insertUrl( "library/picture1.jpg" ) ;
            m.insertUrl( "library/picture2.jpg" ) ;
            m.insertUrl( "library/picture3.jpg" ) ;
            m.insertUrl( "library/picture4.jpg" ) ;
            m.insertUrl( "library/picture5.jpg" ) ;
            m.insertUrl( "library/picture6.jpg" ) ;
            
            m.run() ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN, handler ) ;
            stage.addEventListener( MouseEvent.CLICK , handler ) ;
            
        }
        
        public var m:PictureModel ;
        
        public function handler( e:Event ):void
        {
			m.run() ;         
        }
        
    }

}
