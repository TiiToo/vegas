package {

    import asgard.display.DisplayObjectCollector;
    
    import display.*;
    
    import flash.display.*;
    
    import visitors.*;
    
    [SWF(backgroundColor="#CCCCCC", frameRate=24)]
    
    public class visitor extends Sprite
    {
        public function visitor()
        {
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align = StageAlign.TOP_LEFT ;
            
            var loader:Loader = new Loader() ;
            loader.name = UIList.LOADER ;
            DisplayObjectCollector.insert(loader.name, loader) ;
            
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
