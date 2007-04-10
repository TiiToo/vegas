
import test.events.Author ;

import vegas.events.Event ;
import vegas.events.EventListener ;

class test.events.AuthorLogger implements EventListener 
{
    
    /**
     * Creates a new AuthorLogger instance.
     */
    public function AuthorLogger() 
    {
        //
    }
    
    /**
     * Handle the event.
     */
    public function handleEvent(e:Event) 
    {
        
        var type:String   = e.getType();
        var author:Author  = Author( e.getTarget() ) ;
        var name:String   = author.getUsername() ;
        
        trace("-------- AuthorLogger : Event has been triggered");
        
        trace( "event-type   : " + type ) ;
        trace( "event-target : " + author ) ;
        trace( "author-name  : " + name ) ;
        
    }
}