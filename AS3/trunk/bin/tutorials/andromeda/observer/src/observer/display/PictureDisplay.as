
package observer.display
{
    import flash.display.*;
    import flash.events.Event;
    
    import andromeda.util.visitor.IVisitable;
    import andromeda.util.visitor.IVisitor;	

    /**
     * The PictureDisplay class.
     */
    public class PictureDisplay extends Sprite implements IVisitable
    {

        /**
         * Creates a new PictureDisplay instance.
         */ 
        public function PictureDisplay() 
        {
            super() ;
            
            loader = new Loader() ;
            loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete ) ;
            
            update() ;
        }
        
        /**
         * The virtual height of the picture.
         */  
        public var h:uint = 260 ;
        
        /**
         * The loader of the picture display.
         */
        public var loader:Loader ;
        
        /**
         * The virtual hwidth of the picture.
         */  
        public var w:uint = 260 ;

        /**
         * Accept a IVisitor object. 
         */
        public function accept( visitor:IVisitor ):void
        {
            visitor.visit(this) ;
        }

        /**
         * Invoked when the picture loading is complete.
         */
        public function complete( e:Event ):void
        {
            trace("complete : " + e) ;
            addChild( loader ) ; 
            update() ;
        }

        /**
         * Update the view of the display.
         */
        public function update():void
        {
            
            graphics.clear() ;
            graphics.beginFill(0xFFFFFF, 100) ;
            graphics.drawRect(0, 0, w, h) ;
            graphics.endFill() ;
            
            if ( contains(loader) )
            {
                loader.x = ( w - loader.width  ) / 2 ;
                loader.y = ( h - loader.height ) / 2 ;
            }
            
        }

    }
    
}