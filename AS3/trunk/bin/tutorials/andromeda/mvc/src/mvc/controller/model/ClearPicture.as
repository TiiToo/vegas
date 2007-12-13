package mvc.controller.model
{
    import flash.events.Event;
    
    import andromeda.controller.AbstractController;
    
    import asgard.display.DisplayObjectCollector;
    
    import mvc.display.PictureDisplay;
    import mvc.display.UIList;
    import mvc.visitors.ClearVisitor;    

    public class ClearPicture extends AbstractController
    {
        
        /**
         * Creates a new ClearPicture instance.
         */
        public function ClearPicture()
        {
            super();
        }
        
        /**
         * Handles the event.
         */
        public override function handleEvent(e:Event):void
        {
            trace( this + " handleEvent : " + e ) ;
            PictureDisplay(DisplayObjectCollector.get(UIList.PICTURE)).accept( new ClearVisitor() ) ;
        }
        
    }
}