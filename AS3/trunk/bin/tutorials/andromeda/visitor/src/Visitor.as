package 
{
    import flash.display.*;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    import visitor.display.PictureDisplay;
    import visitor.visitor.HideVisitor;
    import visitor.visitor.LoaderVisitor;
    import visitor.visitor.ShowVisitor;    

    /**
	 * The main class of the visitor tutorial.
	 * @author eKameleon
	 */
	public class Visitor extends Sprite
    {
    	
    	/**
    	 * Creates a new visitor instance.
    	 */
        public function Visitor()
        {
            
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = StageAlign.TOP_LEFT ;
            
            stage.addEventListener(KeyboardEvent.KEY_DOWN  , keyDownHandler ) ;
            
            // view
            
            picture   = new PictureDisplay() ;
            picture.x = 100 ;
            picture.y = 100 ;
            
            addChild( picture ) ;
            
            // test
            
            picture.accept( new LoaderVisitor( "library/picture1.jpg" )) ;
                        
        }
        
        /**
         * The picture display reference.
         */
        public var picture:PictureDisplay ;
        
        /**
         * Invoked when a key is down.
         */
        private function keyDownHandler( e:KeyboardEvent = null ):void
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
