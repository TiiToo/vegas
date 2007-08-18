
package vegas.events 
{	import flash.events.Event;	
	/**	 * @author eKameleon	 */	class BasicEvent extends Event 
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
			super(type, bubbles, cancelable);
			
			_context = (getContext() != null) ? getContext() : context ;
			_target  = (getTarget() != null)  ? getTarget()  : target ;			
			_time    = ( time > 0) ? time : ( (new Date()).valueOf() ) ;
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
		public function getTarget():* 
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
			return this.type ;
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
		public function setTarget(target:*):void 
		{
			_target = target || null ;
		}

		/**
		 * Sets the event type of this event.
		 */
		public function setType( type:String ):void 
		{
			this.type = type || null ;
		}

		private var _context:* = null ;
	
		private var _target:* = null ;
	
		private var _time:Number ;

		/**
		 * Sets the timestamp of the event (used this method only in internal in the Event class).
		 */
		/*protected*/ private function _setTimeStamp( time:Number ):void 
		{
			_time = (time >= 0) ? time : (new Date()).valueOf() ;	
		}

	}
	
		}