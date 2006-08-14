package vegas.events.dom
{
	
	import vegas.core.ISerializable;
	import vegas.core.IFormattable;
	import vegas.core.IHashable;
	import vegas.core.ICloneable;
	import vegas.core.ICopyable;

	public interface IEvent extends ICloneable, ICopyable, IFormattable, IHashable, ISerializable
	{
		
		// ----o Virtual Properties

		function get stop():uint ;

		function set stop( value:uint ):void ;

		// ----o Public Methods

		function cancel():void ;
			
		function getBubbles():Boolean ;
			
		function getContext():* ;
			
		function getCurrentTarget():* ;
			
		function getEventPhase():uint ;
			
		function getTarget():* ;
		
		function getTimeStamp():uint ;
		
		function getType():String ;
		
		function initEvent(type:String, bubbles:Boolean, cancelable:Boolean):void ;
		
		function isCancelled():Boolean ;
	
		function isQueued():Boolean ;
		
		function queueEvent():void ;
	
		function setBubbles(b:Boolean=false):void ;
		
		function setContext(context:*=null):void ;
		
		function setCurrentTarget(target:*=null):void ;
		
		function setEventPhase(phase:uint):void ;
		
		function setTarget(target:*=null):void ;
		
		function setType(type:String):void ;
		
		function stopPropagation():void ;
	
		function stopImmediatePropagation():void ;
		
	}
	
}