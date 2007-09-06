/*

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
    
    import vegas.events.BasicEvent;
    import vegas.util.ClassUtil;
    import vegas.util.Serializer;
    
    public class DomEvent extends BasicEvent implements IEvent
	{
		
		public function DomEvent(type:String, target:Object = null , context:* =null, bubbles:Boolean=false, time:Number = 0 )
		{
			
			super( type, target, context, bubbles, cancelable, time ) ;
			
			_type = type || null ;
			_target = target ;
			_context = context ;
			_bubbles = bubbles;
			
			if (rest != null) 
			{
			
				_eventPhase = isNaN(rest[0]) ? EventPhase.AT_TARGET : rest[0] ;
				_time = isNaN(rest[1]) ? (new Date()).valueOf() : rest[1]  ;
				_stop = isNaN(rest[2]) ? EventPhase.NONE : rest[2] ;
				
			}
			
		}
		
		public function get stop():uint
		{
			return _stop ;
		}

		public function set stop( value:uint ):void
		{
			_stop = value ;
		}

		public override function clone():Event
		{
			return new DomEvent(getType(), getTarget(), getContext()) ;
		}

		public function cancel():void 
		{
			_cancelled = true ;
		}
		
		public function copy():*
		{
			return new DomEvent(getType(), getTarget(), getContext(), getBubbles(), getEventPhase(), getTimeStamp(), stop) ;
		}
		
		public function getBubbles():Boolean
		{
			return _bubbles ;
		}

		public function getContext():*
		{
			return _context ;
		}
			
		public function getCurrentTarget():*
		{
			return _currentTarget ;
		}
			
		public function getEventPhase():uint
		{
			return _eventPhase ;
		}

		public function getTarget():*
		{
			return _target ;
		}

		public function getTimeStamp():uint
		{
			return _time ;
		}

		public function getType():String
		{
			return _type ;
		}

        public function hashCode() : uint
        {
        	return ;
        }

		public function initEvent(type:String, bubbles:Boolean, cancelable:Boolean):void
		{
			_type = type ;
			_bubbles = bubbles ;
			_cancelled = cancelable ;
			_time = (new Date()).valueOf() ;
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

		public function setContext( context:* = null ):void
		{
			_context = context ;
		}

		public function setCurrentTarget( target:* =null ):void
		{
			_currentTarget = target ;
		}

		public function setEventPhase(phase:uint):void
		{
			_eventPhase = phase ;
		}

		public function setTarget( target:* = null ):void
		{
			_target = target
		}

		public function setType(type:String):void
		{
			_type = type ;
		}

		public function stopPropagation():void
		{
			_stop = EventPhase.STOP ;
		}

		public function stopImmediatePropagation():void
		{
			_stop = EventPhase.STOP_IMMEDIATE ;
		}

		override public function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, _getParams()) ;
		}

		override public function toString():String 
		{
			var phase:uint = getEventPhase() ;
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
			if (getBubbles() && phase != EventPhase.BUBBLING_PHASE) 
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
		private var _context:* = null ;
		private var _currentTarget:* ;
		private var _cancelled:Boolean = false ;
		private var _eventPhase:uint ;
		private var _inQueue:Boolean = false ;
		private var _stop:uint ;
		private var _target:* = null ;
		private var _time:uint ;
		private var _type:String ;

	
		protected function _getParams():Array 
		{
			return [
				getType() ,
				getTarget() ,
				getContext() ,
				getBubbles() ,
				getEventPhase() ,
				getTimeStamp() ,
				stop
			] ;
		}
	
		protected function _setTimeStamp( nTime:Number=NaN ):void 
		{
			_time = ( isNaN(nTime) || nTime < 0 ) ? (new Date()).valueOf() : nTime ;	
        }        
        

    }
}