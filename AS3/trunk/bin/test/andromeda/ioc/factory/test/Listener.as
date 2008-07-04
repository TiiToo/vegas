
package test
{
    import flash.events.Event;
    
    import vegas.events.EventListener;    

    /**
     * The Listener class.
     */
    public class Listener implements EventListener
    {
		
        /**
         * Creates a new Listener instance.
         */
        public function Listener()
        {
            //
        }
		
        /**
         * Handles the event.
         */
        public function handleEvent( e:Event ):void
        {
			trace( this + " handleEvent " + e ) ;
        }
		
    }

}