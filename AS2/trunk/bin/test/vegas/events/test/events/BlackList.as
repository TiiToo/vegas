
import test.events.Author ;

import vegas.core.CoreObject ;
import vegas.events.Event ;
import vegas.events.EventListener ;
import vegas.util.ArrayUtil ;

class test.events.BlackList extends CoreObject implements EventListener 
{
    
    /**
     * Creates a new BlackList instance.
     */
    public function BlackList() {}
    
    /**
     * The static 'black list' array representation.
     */
    static public var BLACK_LIST:Array = [ "ekameleon" , "kronos" ] ;
    
    /**
     * Handles the event.
     */
    public function handleEvent(ev:Event) 
    {
        
        var name:String  = Author( ev.getContext() ).getUsername() ;
        
        if ( ArrayUtil.contains( BLACK_LIST, name ) ) 
        {
            ev.cancel() ; // cancel the event
        }
        
    }
    
}