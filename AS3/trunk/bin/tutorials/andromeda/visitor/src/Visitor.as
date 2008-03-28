package 
{
	import flash.display.*;
	
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
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = StageAlign.TOP_LEFT ;
            
            var pic:PictureDisplay = new PictureDisplay() ;
            
            pic.x = 100 ;
            pic.y = 100 ;
            
            addChild( pic ) ;
            
            var url:String = "library/picture1.jpg" ;
            
            pic.accept( new LoaderVisitor( url ) ) ;
            pic.accept( new HideVisitor() ) ;
            pic.accept( new ShowVisitor() ) ;
            
        }
    }
}
