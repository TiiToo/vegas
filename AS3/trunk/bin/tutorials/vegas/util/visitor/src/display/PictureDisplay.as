
package display
{
    
    import asgard.display.DisplayObjectCollector ;
    
    import flash.display.* ;

    import vegas.util.visitor.IVisitable;
    import vegas.util.visitor.IVisitor ;

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
    	    name = UIList.PICTURE ;
		    DisplayObjectCollector.insert(name , this ) ;
		    update() ;
    	}
        
        /**
         * The virtual height of the picture.
         */  
        public var h:uint = 260 ;
    
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
		public function accept( visitor:IVisitor ):*
		{
			visitor.visit(this) ;
		}

        /**
         * Update the view of the display.
         */
        public function update():void
        {
            graphics.clear() ;
            graphics.beginFill(0xFFFFFF, 100) ;
            graphics.lineTo(w, 0) ;
            graphics.lineTo(w, h) ;
            graphics.lineTo(0, h) ;
            graphics.lineTo(0, 0) ;
            graphics.endFill() ;
        }

    }
    
}