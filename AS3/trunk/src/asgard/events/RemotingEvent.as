/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.events
{

    import flash.events.Event ;	
	import vegas.events.BasicEvent ;
	
	/**
	 * The RemotingEvent class.
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param cancelable indicates if the event is a cancelable event.
	 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 * @author eKameleon
	 */
	public class RemotingEvent extends BasicEvent
	{
		
		/**
	 	 * Creates a new RemotingEvent instance.
		 */
		public function RemotingEvent( type:String , target:Object = null , result:* = null , fault:* = null, methodName:String = null, code:String = null, level:String = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			super( type, target, context, bubbles, cancelable, time );
			this.code = code ;
			this.level = level ;
			setMethodName( methodName ) ;
			setResult( result) ;
			setFault( fault) ;
		}
	
		public static const ERROR:String = "onError" ;	

		public static const FAULT:String = "onFault" ;
		
		public static const RESULT:String = "onResult" ;
		
		public var code:String ;

		public var level:String ;

		public function get fault():* 
		{
			return getFault() ;	
		}
		
		public function get result():*
		{
			return getResult() ;	
		}
		
		/**
	 	 * Returns a shallow copy of this object.
		 * @return a shallow copy of this object.
		 */
		public override function clone():Event
		{
			return new RemotingEvent( type , target, getResult(), getFault(), getMethodName(), code, level, context ) ;
    	}

		public function getCode():String 
		{
			return _code ;
		}

		public function getDescription():String 
		{
			return _description ;
		}

		public function getDetail():String 
		{
			return _detail ;
		}

		public function getExceptionStack():String 
		{
			return _exceptionStack ;
		}
	
		public function getFault():*
		{
			return _fault ;
		}

		public function getLevel():String 
		{
			return _level ;
		}
	
		public function getLine():String 
		{
			return _line ;
		}
	
		public function getMethodName():String 
		{
			return _methodName ;
		}
	
		public function getResult():*
		{
			return _result ;	
		}
	
		public function setFault( fault:* = null , methodName:String=null):void 
		{
		
			_fault = fault || null ;	
			
			if (_fault != null) 
			{
				_code = (_fault.hasOwnProperty("code")) ? fault.code : null ;
				_detail = (_fault.hasOwnProperty("details")) ? fault.details : null ;
				if (_fault.hasOwnProperty("description"))
				{
					_description = fault.description ;
				}
				if (_fault.hasOwnProperty("exceptionStack"))_exceptionStack = fault.exceptionStack ;
				if (_fault.hasOwnProperty("level"))_level = fault.level ;
				if (_fault.hasOwnProperty("line"))_line = fault.line ;
			}
			
			if (methodName != null ) {
				setMethodName( methodName ) ;
			}
		}
	
		public function setMethodName( methodName:String=null ):void
		{
			_methodName = methodName ;	
		}
	
		public function setResult( result:* = null , methodName:String = null ):void
		{
			_result = result ;
			if (methodName != null)
			{
				setMethodName( methodName ) ;
			} 
		}		
		
		private var _fault:* ;

		private var _result:* ;	

		private var _code:String ;
		
		private var _description:String ;

		private var _detail : String ;

		private var _exceptionStack:String ;

		private var _level:String ;

		private var _line:String ;

		private var _methodName:String ;
	
	}

}