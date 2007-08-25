package vegas.events.dom
{
	
	import vegas.core.ICloneable;
	import vegas.core.ICopyable;
	import vegas.core.IFormattable;
	import vegas.core.IHashable;
	import vegas.core.ISerializable;

	public interface IEvent extends ICloneable, ICopyable, IFormattable, IHashable, ISerializable
	{
		
		/**
		 * Indicates if the event propagation is stopped.
		 */
		function get stop():uint ;

		function set stop( value:uint ):void ;

	    /**
    	 * Cancel the event.
	     */
		function cancel():void ;

		/**
    	 * Returns {@code true} if this event is a bubbling event.
    	 * @return {@code true} if this event is a bubbling event.
    	 */
		function getBubbles():Boolean ;
		
		/**
	     * Returns the event context.
	     * @return the event context.
	     */
		function getContext():* ;
		
		/**
	     * Returns the current target of this event in a capturing or a bubbling phase.
	     * @return the current target of this event in a capturing or a bubbling phase.
	     */
		function getCurrentTarget():* ;
		
		/**
	     * Returns the event phase value of this event.
	     * @see EventPhase
	     */
		function getEventPhase():uint ;
		
		/**
	     * Returns the target of this event.
	     */
		function getTarget():* ;
		
		/**
	     * Returns the timestamp value of this event.
	     */
		function getTimeStamp():uint ;
		
		/**
	     * Returns the type of the event.
	     * @return the string representation of the type of this event.
	     */
		function getType():String ;
		
		/**
		 * Initialize the event.
		 */
		function initEvent(type:String, bubbles:Boolean, cancelable:Boolean):void ;
		
		/**
	     * Check, whether the event has been cancelled.
	     * @return {@code true} if the event has been cancelled, false otherwise.
	     */
		function isCancelled():Boolean ;
	
		/**
	     * Check, whether the event already is in a queue.
	     * @return (@code true} if the event already is in a queue. 
	     */
		function isQueued():Boolean ;
		
		/**
	     * Flags the event as queued.
	     */
		function queueEvent():void ;
	
		/**
	     * Sets if the event is bubbling.
	     */
		function setBubbles(b:Boolean=false):void ;
		
		/**
	     * Sets the context of this event.
	     */
		function setContext(context:*=null):void ;
		
		/**
	     * Sets the current target of this event in a bubbling or capturing phase.
	     */
		function setCurrentTarget(target:*=null):void ;
		
		/**
	     * Sets the {@code EventPhase} of this event.
	     */
		function setEventPhase(phase:uint):void ;
		
		/**
	     * Sets the target of this event.
	     */
		function setTarget(target:*=null):void ;
		
		/**
	     * Sets the event type.
	     */
		function setType(type:String):void ;
		
		/**
	     * Stops the propagation of this event in the event flow.
	     */
		function stopPropagation():void ;
	
		/**
	     * Stops immediately the propagation of this event in the event flow.
	     */
		function stopImmediatePropagation():void ;
		
	}
	
}