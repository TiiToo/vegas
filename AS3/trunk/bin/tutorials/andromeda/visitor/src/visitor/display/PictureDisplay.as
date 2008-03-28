
package visitor.display
{
	import flash.display.*;
	
	import andromeda.util.visitor.IVisitable;
	import andromeda.util.visitor.IVisitor;
	
	import asgard.display.CoreLoader;
	import asgard.display.CoreSprite;	

	/**
     * The PictureDisplay class.
     */
    public class PictureDisplay extends CoreSprite implements IVisitable
    {

	    /**
    	 * Creates a new PictureDisplay instance.
	     */	
    	public function PictureDisplay() 
    	{
    	    super( UIList.PICTURE ) ;
            loader = new CoreLoader( UIList.LOADER ) ;
		    update() ;
    	}
        
        /**
         * The virtual height of the picture.
         */  
        public var h:uint = 260 ;
    	
    	/**
    	 * The loader of the picture display.
    	 */
    	public var loader:CoreLoader ;
    	
	    /**
    	 * The margin in the picture to display the container.
    	 */
    	public var margin:Number = 10 ;

        /**
         * The virtual hwidth of the picture.
         */  
        public var w:uint = 260 ;

		/**
		 * Accept a IVisitor object. 
		 * You can overrides this method in complexe Visitor pattern implementation.
		 */
		public function accept( visitor:IVisitor ):void
		{
			visitor.visit(this) ;
		}

        /**
         * Update the view of the display.
         */
        public override function update():void
        {
            graphics.clear() ;
            graphics.beginFill(0xFFFFFF, 100) ;
            graphics.drawRect(0, 0, w, h) ;
            graphics.endFill() ;
        }

    }
    
}