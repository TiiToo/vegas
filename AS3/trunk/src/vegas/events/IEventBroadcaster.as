package vegas.events
{
    import vegas.core.ISerializable;
    import vegas.core.IFormattable;
    import vegas.core.IHashable;
	import flash.events.IEventDispatcher ;
 
    public interface IEventBroadcaster extends IEventDispatcher, IFormattable, IHashable, ISerializable
    {
        
       function addListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
       
       function removeListener(type:String, listener:*, useCapture:Boolean = false):void ;
        
    }
}