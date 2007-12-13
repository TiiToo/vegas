package mvc.controller.model
{
    import flash.events.Event;
    
    import andromeda.controller.AbstractController;
    import andromeda.events.ModelObjectEvent;
    
    import asgard.display.DisplayObjectCollector;
    
    import mvc.display.PictureDisplay;
    import mvc.display.UIList;
    import mvc.visitors.LoaderVisitor;
    import mvc.vo.PictureVO;    

    public class ChangeCurrentPicture extends AbstractController
    {
        
        /**
         * Creates a new ChangeCurrentPicture instance.
         */
        public function ChangeCurrentPicture()
        {
            super();
        }
        
        /**
         * Handles the event.
         */
        public override function handleEvent(e:Event):void
        {

            var vo:PictureVO = (e as ModelObjectEvent).getVO() as PictureVO ;

            trace( this + " handleEvent : " + vo ) ;

            if (vo != null)
            {
                PictureDisplay(DisplayObjectCollector.get(UIList.PICTURE)).accept( new LoaderVisitor( vo.url ) ) ;
            }
            
        }
        
    }
}