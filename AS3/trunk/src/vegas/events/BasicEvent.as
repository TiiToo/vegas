
package vegas.events 
{
	
	import flash.events.Event;
	import flash.events.EventPhase;
	import vegas.util.ClassUtil;
	
	/**
	 * {@code BasicEvent} is the basical event structure to work with {@link vegas.events.EventDispatcher}.
	 * <p><b>Example</b></p>
	 * {@code var e:BasicEvent = new BasicEvent(type:String, target, context) ; } 
	 * @author  eKameleon
	 * @see Event	
	 */
	public class BasicEvent extends Event 
	{

		/**
		 * Constructs a new {@code BasicEvent} instance.
		 * <p>
		 * {@code
		 *     var e:BasicEvent = new BasicEvent(type, target, context, [bubbles:Boolean, [eventPhase:Number, [time:Number, [stop:Boolean]]]]) ;
	 	* }
		 * </p>
		 * @param type the string type of the instance. 
		 * @param target the target of the event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 	 */
		public function BasicEvent(type : String, target:* = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			
			super((getType() != null) ? getType() : type, bubbles, cancelable);
			
			_context = (getContext() != null) ? getContext() : context ;
			_target  = (getTarget() != null)  ? getTarget()  : target ;			
			_time    = ( time > 0) ? time : ( (new Date()).valueOf() ) ;
			_type    = (getType() != null) ? getType() : type ;
			 
		}
		

		/**
		 * Returns the optional context of this event.
		 * @return an object, corresponding the optional context of this event.
		 */
		public function get context():*
		{
			return getContext() ;	
		}
		
		/**
		 * Sets the optional context of this event.
		 */
		public function set context(o:*):void 
		{
			setContext(o) ;	
		}
		
		/**
		 * Returns the event target.
		 * @return the event target.
		 */
		public override function get target():Object
		{
			return getTarget() ;	
		}
	
		/**
		 * Sets the event target.
		 */
		public function set target(o:Object):void 
		{
			setTarget(o) ;	
		}
		
		/**
		 * Returns the timestamp of the event.
		 * @return the timestamp of the event.
		 */
		public function get timeStamp():Number 
		{
			return getTimeStamp() ;	
		}
		
		/**
		 * Returns the type of event.
		 * @return the type of event.
		 */
		public override function get type():String 
		{
			return _type ;	
		}
	
		/**
		 * Sets the type of event.
		 */
		public function set type(s:String):void 
		{
			setType(s) ;	
		}

		/**
		 * Returns the shallow copy of this event.
		 * @return the shallow copy of this event.
		 */
		public override function clone():Event 
		{
			return new BasicEvent(getType(), getTarget(), getContext()) ;
		}

		/**
		 * Returns the optional context of this event.
		 * @return an object, corresponding the optional context of this event.
	 	 */
		public function getContext():* 
		{
			return _context ;
		}
		
		/**
		 * Returns the event target.
	 	 * @return the event target.
		 */
		public function getTarget():Object 
		{
			return _target ;
		}

		/**
		 * Returns the timestamp of the event.
		 * @return the timestamp of the event.
		 */
		public function getTimeStamp():Number 
		{	
			return _time ;
		}
		
		/**
		 * Returns the type of event.
	 	 * @return the type of event.
		 */
		public function getType():String 
		{
			return _type ;
		}

		/**
		 * Sets the optional context object of this event. 
		 */
		public function setContext(context:*):void 
		{
			_context = context || null ;
		}
		
		/**
	 	 * Sets the event target.
		 */
		public function setTarget(target:Object):void 
		{
			_target = target || null ;
		}

		/**
		 * Sets the event type of this event.
		 */
		public function setType( type:String ):void 
		{
			_type = type || null ;
		}
	
		/**
	 	 * Returns the string representation of this event.
	 	 * @return the string representation of this event.
	 	 */
		public override function toString():String 
		{
			var name:String = ClassUtil.getName(this);
			var txt:String = "[" + name ;
			txt += " type=" + type ;
			if (target != null)
			{
				txt += " target=" + target ;
			}
			if (context != undefined)
			{
				txt += " context=" + context ;
			}	
			txt += " eventphase=" + eventPhase ;
			txt += " bubbles=" + bubbles ;
			txt += " cancelable=" + cancelable ;
			txt += "]" ;
			return txt ;
		}

		private var _context:* = null ;
	
		private var _target:Object = null ;
	
		private var _time:Number ;

		private var _type:String ;
		
		/**
		 * Sets the timestamp of the event (used this method only in internal in the Event class).
		 */
		protected function setTimeStamp( time:Number ):void 
		{
			_time = (time >= 0) ? time : (new Date()).valueOf() ;	
		}

	}
	
		
}
