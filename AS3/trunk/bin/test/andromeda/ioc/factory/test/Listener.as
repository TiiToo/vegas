
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
         * The custom callback method who handle an event.
         */
        public function change( e:Event ):void
        {
            trace( this + " change " + e ) ;
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