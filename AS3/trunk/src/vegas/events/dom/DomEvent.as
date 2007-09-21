﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
        http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events.dom
{
    import flash.events.Event;
    
    import vegas.core.ICopyable;
    import vegas.core.IFormattable;
    import vegas.core.IHashable;
    import vegas.core.ISerializable;
    import vegas.events.BasicEvent;
    import vegas.util.ClassUtil;
    
    public class DomEvent extends BasicEvent implements ICopyable, IFormattable, IHashable, ISerializable
	{
		
		public function DomEvent(type:String, target:Object = null , context:* =null, bubbles:Boolean=false, time:Number = 0 , ...rest:Array )
		{
			
			super( type, target, context, bubbles, cancelable, time ) ;

			_bubbles = bubbles;
			
			_eventPhase = isNaN(rest[0]) ? EventPhase.AT_TARGET : rest[0] ;
			_stop       = isNaN(rest[2]) ? EventPhase.NONE : rest[2] ;
			
		}
		
		public function get stop():uint
		{
			return _stop ;
		}

		public function set stop( value:uint ):void
		{
			_stop = value ;
		}
		
		/**
		 * Returns a shallow copy of this event.
		 * @return a shallow copy of this event.
		 */
		public override function clone():Event
		{
			return new DomEvent(getType(), getTarget(), getContext()) ;
		}

		public function cancel():void 
		{
			_cancelled = true ;
		}
		
		/**
		 * Returns a deep copy of this object.
		 * @return a deep copy of this object.
		 */
		public function copy():*
		{
			return new DomEvent(getType(), getTarget(), getContext(), bubbles, getTimeStamp(), eventPhase, stop) ;
		}
		
		public override function get bubbles():Boolean
		{
			return _bubbles ;
		}

		public override function get currentTarget():*
		{
			return _currentTarget ;
		}
			
		public override function get eventPhase():uint
		{
			return _eventPhase ;
		}

        public function hashCode() : uint
        {
        	return ;
        }

		public function initEvent(type:String, bubbles:Boolean, cancelable:Boolean):void
		{
			type       = type ;
			bubbles    = bubbles ;
			cancelable = cancelable ;
			timeStamp  = (new Date()).valueOf() ;
		}

		public function isCancelled():Boolean
		{
			return _cancelled ;
		}

		public function isQueued():Boolean
		{
			return _inQueue ;
		}

		public function queueEvent():void
		{
			_inQueue = true ;
		}

		public function setBubbles(b:Boolean=false):void
		{
			_bubbles = b ;
		}

		public function setCurrentTarget( target:* =null ):void
		{
			_currentTarget = target ;
		}

		public function setEventPhase(phase:uint):void
		{
			_eventPhase = phase ;
		}

		public override function stopPropagation():void
		{
			_stop = EventPhase.STOP ;
		}

		public override function stopImmediatePropagation():void
		{
			_stop = EventPhase.STOP_IMMEDIATE ;
		}
		
		public function toSource( ...arguments:Array ):String 
		{
			return "new DomEvent()" ; // TODO finish
		}
		
		public override function toString():String 
		{
			var phase:uint = eventPhase ;
			var	name:String = ClassUtil.getName(this);
			var txt:String = "[" + name ;
			if (getType()) txt += " " + getType() ;
			switch (phase) 
			{
				case EventPhase.CAPTURING_PHASE :
					txt += ", CAPTURING" ;
					break;
				case EventPhase.AT_TARGET:
					txt += ", AT TARGET" ;
					break ;
				case EventPhase.BUBBLING_PHASE:
					txt += ", BUBBLING" ;
					break ;
				default :
					txt += ", (inactive)" ;
					break;
			}
			if (bubbles && phase != EventPhase.BUBBLING_PHASE) 
			{
				txt += ", bubbles" ;
			}
			if (isCancelled()) 
			{
				txt += ", can cancel" ;
			}
			txt += "]" ;
			return txt ;
		}

		private var _bubbles:Boolean ;
		private var _currentTarget:* ;
		private var _cancelled:Boolean = false ;
		private var _eventPhase:uint ;
		private var _inQueue:Boolean = false ;
		private var _stop:uint ;

       
        

    }
}